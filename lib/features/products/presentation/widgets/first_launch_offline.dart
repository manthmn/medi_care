import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_care/l10n/app_localizations.dart';
import '../bloc/product_bloc.dart';
import 'package:medi_care/core/theme/app_dimensions.dart';

class FirstLaunchOffline extends StatelessWidget {
  final String message;

  const FirstLaunchOffline({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: AppDimensions.padding24,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.wifi_off, size: 64),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context
                  .read<ProductBloc>()
                  .add(const ProductEvent.refreshRequested()),
              child: Text(l10n.retryConnection),
            ),
          ],
        ),
      ),
    );
  }
}
