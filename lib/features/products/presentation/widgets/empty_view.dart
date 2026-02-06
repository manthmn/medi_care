import 'package:flutter/material.dart';
import 'package:medi_care/l10n/app_localizations.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Text(l10n.noProductsAvailable),
    );
  }
}
