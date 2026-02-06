import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_care/l10n/app_localizations.dart';
import 'package:medi_care/core/theme/app_theme.dart';

import '../../../../core/network/connectivity_cubit.dart';
import '../../../../core/preferences/preferences_service.dart';
import '../../../../injector.dart';
import '../bloc/product_bloc.dart';
import '../bloc/sync_cubit.dart';
import '../product_layout/product_layout.dart';
import '../product_layout/product_list_view.dart';
import '../product_layout/product_skeleton_view.dart';
import '../widgets/delivery_header.dart';
import '../widgets/empty_view.dart';
import '../widgets/error_view.dart';
import '../widgets/first_launch_offline.dart';
import '../widgets/sync_status.dart';
import '../widgets/search_bar.dart';

enum ViewMode { list, grid }

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  static const routeName = '/products';

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late ViewMode _viewMode;
  final PreferencesService _preferencesService = sl<PreferencesService>();

  ProductLayout get _layout =>
      _viewMode == ViewMode.grid ? ProductLayout.grid : ProductLayout.list;

  @override
  void initState() {
    super.initState();
    // Restore saved view mode preference
    _viewMode = _preferencesService.getViewMode();
  }

  void _onViewModeChanged(ViewMode mode) {
    setState(() => _viewMode = mode);
    // Persist the view mode preference
    _preferencesService.setViewMode(mode);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return MultiBlocListener(
      listeners: [
        // Refresh products when coming back online
        BlocListener<ConnectivityCubit, ConnectivityState>(
          listenWhen: (prev, curr) =>
              prev.isOffline && !curr.isOffline, // offline → online
          listener: (context, state) {
            context
                .read<ProductBloc>()
                .add(const ProductEvent.refreshRequested());
          },
        ),
        // Update lastSyncedAt when products are successfully loaded
        BlocListener<ProductBloc, ProductState>(
          listenWhen: (prev, curr) =>
              prev.status != ProductStatus.success &&
              curr.status == ProductStatus.success,
          listener: (context, state) {
            context.read<SyncCubit>().updateLastSynced();
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: AppTheme.backgroundWhite,
        body: Stack(
          children: [
            Column(
              children: [
                DeliveryHeader(
                  viewMode: _viewMode,
                  onViewModeChanged: _onViewModeChanged,
                ),
                const SearchField(),
                const SyncStatus(),
                Expanded(
                  child: BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                      switch (state.status) {
                        case ProductStatus.loading:
                          return ProductSkeletonView(layout: _layout);

                        case ProductStatus.firstLaunchOffline:
                          return FirstLaunchOffline(
                            message: state.error ?? l10n.connectToInternet,
                          );

                        case ProductStatus.error:
                          return ErrorView(
                            message: state.error ?? l10n.somethingWentWrong,
                            onRetry: () => context
                                .read<ProductBloc>()
                                .add(const ProductEvent.refreshRequested()),
                          );

                        case ProductStatus.empty:
                          return const EmptyView();

                        case ProductStatus.success:
                          return ProductListView(
                            products: state.visibleProducts,
                            layout: _layout,
                          );

                        case ProductStatus.initial:
                          return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
