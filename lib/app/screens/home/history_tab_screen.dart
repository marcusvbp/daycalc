import 'package:daycalc/app/config/constants.dart';
import 'package:daycalc/app/enums/operation_type.dart';
import 'package:daycalc/app/l10n/app_localizations.dart';
import 'package:daycalc/app/models/date_operation_record.dart';
import 'package:daycalc/app/providers/date_operations_history_provider.dart';
import 'package:daycalc/app/providers/date_operations_provider.dart';
import 'package:daycalc/app/providers/home_tabs_provider.dart';
import 'package:daycalc/app/providers/user_date_provider.dart';
import 'package:daycalc/app/screens/home/widgets/native_banner.dart';
import 'package:daycalc/app/widgets/rebuild_loop.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class HistoryTabScreen extends ConsumerStatefulWidget {
  const HistoryTabScreen({super.key});

  @override
  ConsumerState<HistoryTabScreen> createState() => _HistoryTabScreenState();
}

class _HistoryTabScreenState extends ConsumerState<HistoryTabScreen> {
  @override
  Widget build(BuildContext context) {
    final historyAsync = ref.watch(dateOperationsHistoryProvider);
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: historyAsync.when(
        data: (history) => _buildHistoryList(context, history),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                localizations.errorLoadingHistory,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(dateOperationsHistoryProvider),
                child: Text(localizations.tryAgain),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: historyAsync.when(
        data: (history) => history.isNotEmpty
            ? FloatingActionButton.extended(
                onPressed: () => _showClearHistoryDialog(context),
                icon: const Icon(Icons.clear_all),
                label: Text(localizations.clearHistory),
                tooltip: localizations.clearHistory,
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              )
            : null,
        loading: () => null,
        error: (error, stackTrace) => null,
      ),
    );
  }

  Widget _buildHistoryList(
    BuildContext context,
    List<DateOperationRecord> history,
  ) {
    final localizations = AppLocalizations.of(context)!;
    if (history.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              localizations.noHistory,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              localizations.noHistoryMessage,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
          ],
        ),
      );
    }

    // Ordena o histórico por data (mais recente primeiro)
    final sortedHistory = List<DateOperationRecord>.from(history)
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!kIsWeb)
          RebuildLoop(child: NativeBanner(adUnitId: admobHistoricoId)),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: sortedHistory.length,
            itemBuilder: (context, index) {
              final record = sortedHistory[index];
              return Padding(
                padding: index == sortedHistory.length - 1
                    ? const EdgeInsets.only(bottom: 74)
                    : EdgeInsets.zero,
                child: _buildHistoryItem(context, record, index),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryItem(
    BuildContext context,
    DateOperationRecord record,
    int index,
  ) {
    final isAddOperation = record.operationType == OperationType.add;
    final localizations = AppLocalizations.of(context)!;
    final dateFormat = DateFormat(
      localizations.localeName == 'en_US' ? 'MM/dd/yyyy' : 'dd/MM/yyyy',
    );

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        onTap: () {
          // Popular dados do record no home_tab_screen
          // 1. Definir a data inicial
          ref.read(userDateProvider.notifier).add(record.initialDate);

          // 2. Definir o tipo de operação e duração
          final dateOpsNotifier = ref.read(dateOperationsProvider.notifier);
          dateOpsNotifier.setOperationType(record.operationType);
          dateOpsNotifier.setInterval(record.interval);
          dateOpsNotifier.setTimeUnit(record.timeUnit);
          dateOpsNotifier.setIsHistoryRestored(true);

          // 3. Navegar para a tab home
          ref.read(homeTabsProvider.notifier).set(0);
        },
        leading: CircleAvatar(
          backgroundColor: isAddOperation ? Colors.green : Colors.red,
          child: Icon(
            isAddOperation ? Icons.add : Icons.remove,
            color: Colors.white,
          ),
        ),
        title: Text(
          dateFormat.format(record.initialDate),
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          '${record.operationType.symbol} ${record.formatDurationToString(localizations.localeName)}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'delete') {
              _showDeleteConfirmationDialog(context, record);
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, color: Colors.red),
                  SizedBox(width: 8),
                  Text(localizations.delete),
                ],
              ),
            ),
          ],
        ),
        isThreeLine: false,
      ),
    );
  }

  void _showClearHistoryDialog(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localizations.clearHistory),
        content: Text(localizations.clearHistoryConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(localizations.cancel),
          ),
          TextButton(
            onPressed: () {
              ref.read(dateOperationsHistoryProvider.notifier).clearHistory();
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(localizations.clearHistorySuccess)),
              );
            },
            child: Text(localizations.clearHistory),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(
    BuildContext context,
    DateOperationRecord record,
  ) {
    final localizations = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localizations.deleteOperation),
        content: Text(localizations.deleteOperationConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(localizations.cancel),
          ),
          TextButton(
            onPressed: () {
              ref
                  .read(dateOperationsHistoryProvider.notifier)
                  .removeOperationRecord(record);
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(localizations.deleteOperationSuccess)),
              );
            },
            child: Text(localizations.delete),
          ),
        ],
      ),
    );
  }
}
