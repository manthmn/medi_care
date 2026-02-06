import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/network/connectivity_cubit.dart';
import 'package:medi_care/core/theme/app_theme.dart';
import 'package:medi_care/core/theme/app_typography.dart';

class SyncStatus extends StatelessWidget {
  const SyncStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityCubit,
        ConnectivityState>(
      builder: (_, state) {
        final offline = state.isOffline;

        return Padding(
          padding:
              const EdgeInsets.only(right: 16, bottom: 8),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.end,
            children: [
              Icon(
                offline
                    ? Icons.error_outline
                    : Icons.check_circle,
                size: 16,
                color: offline
                    ? AppTheme.warning
                    : AppTheme.success,
              ),
              const SizedBox(width: 6),
              Text(
                offline
                    ? 'Offline • Showing cached data'
                    : 'Synced 2 mins ago',
                style: AppTypography
                    .textStyle12Regular,
              ),
            ],
          ),
        );
      },
    );
  }
}
