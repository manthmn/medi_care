import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_care/l10n/app_localizations.dart';
import '../../../../core/network/connectivity_cubit.dart';
import 'package:medi_care/core/theme/app_theme.dart';
import 'package:medi_care/core/theme/app_typography.dart';

class SyncStatus extends StatelessWidget {
  const SyncStatus({super.key});

  String _getRelativeTime(DateTime? lastSynced, AppLocalizations l10n) {
    if (lastSynced == null) {
      return l10n.syncedNever;
    }

    final now = DateTime.now();
    final difference = now.difference(lastSynced);

    if (difference.inMinutes < 1) {
      return l10n.syncedJustNow;
    } else if (difference.inMinutes < 60) {
      return l10n.syncedMinutesAgo(difference.inMinutes);
    } else if (difference.inHours < 24) {
      return l10n.syncedHoursAgo(difference.inHours);
    } else {
      return l10n.syncedDaysAgo(difference.inDays);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<ConnectivityCubit, ConnectivityState>(
      builder: (_, state) {
        final offline = state.isOffline;
        final relativeTime = _getRelativeTime(state.lastSyncedAt, l10n);

        String statusText;
        if (offline) {
          if (state.lastSyncedAt != null) {
            statusText = l10n.offlineWithLastSync(relativeTime);
          } else {
            statusText = l10n.offlineShowingCached;
          }
        } else {
          statusText = relativeTime;
        }

        return Padding(
          padding: const EdgeInsets.only(right: 16, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                offline ? Icons.error_outline : Icons.check_circle,
                size: 16,
                color: offline ? AppTheme.warning : AppTheme.success,
              ),
              const SizedBox(width: 6),
              Text(
                statusText,
                style: AppTypography.textStyle12Regular,
              ),
            ],
          ),
        );
      },
    );
  }
}
