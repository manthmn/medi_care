import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_care/core/theme/app_theme.dart';

import '../bloc/product_bloc.dart';
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
  ViewMode _viewMode = ViewMode.grid;

  ProductLayout get _layout =>
      _viewMode == ViewMode.grid ? ProductLayout.grid : ProductLayout.list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundWhite,
      body: Stack(
        children: [
          Column(
            children: [
              DeliveryHeader(
                viewMode: _viewMode,
                onViewModeChanged: (mode) {
                  setState(() => _viewMode = mode);
                },
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
                          message: state.error ??
                              'Connect to the internet once to load products.',
                        );

                      case ProductStatus.error:
                        return ErrorView(
                          message: state.error ?? 'Something went wrong',
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
    );
  }
}
