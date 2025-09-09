import 'package:daycalc/app/enums/operation_type.dart';
import 'package:daycalc/app/l10n/app_localizations.dart';
import 'package:daycalc/app/models/date_operation_record.dart';
import 'package:daycalc/app/providers/date_operations_history_provider.dart';
import 'package:daycalc/app/providers/date_operations_provider.dart';
import 'package:daycalc/app/providers/user_date_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class HistoryTabScreen extends ConsumerWidget {
  final VoidCallback? onNavigateToHomeTab;

  const HistoryTabScreen({super.key, this.onNavigateToHomeTab});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(dateOperationsHistoryNotifierProvider);
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: historyAsync.when(
        data: (history) => _buildHistoryList(context, ref, history),
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
                onPressed: () =>
                    ref.refresh(dateOperationsHistoryNotifierProvider),
                child: Text(localizations.tryAgain),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: historyAsync.when(
        data: (history) => history.isNotEmpty
            ? FloatingActionButton.extended(
                onPressed: () => _showClearHistoryDialog(context, ref),
                icon: const Icon(Icons.clear_all),
                label: Text(localizations.clearHistory),
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
    WidgetRef ref,
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

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sortedHistory.length,
      itemBuilder: (context, index) {
        final record = sortedHistory[index];
        return Padding(
          padding: index == sortedHistory.length - 1
              ? const EdgeInsets.only(bottom: 74)
              : EdgeInsets.zero,
          child: _buildHistoryItem(context, ref, record, index),
        );
      },
    );
  }

  Widget _buildHistoryItem(
    BuildContext context,
    WidgetRef ref,
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
          ref.read(userDateNotifierProvider.notifier).add(record.initialDate);

          // 2. Definir o tipo de operação e total de horas
          final dateOpsNotifier = ref.read(
            dateOperationsNotifierProvider.notifier,
          );
          dateOpsNotifier.setOperationType(record.operationType);
          dateOpsNotifier.setTotalHours(record.totalHours);
          dateOpsNotifier.setTimeUnit(record.timeUnit);
          dateOpsNotifier.setIsHistoryRestored(true);

          // 3. Navegar para a tab home
          onNavigateToHomeTab?.call();
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
          '${record.operationType.symbol} ${record.formatHoursToString(localizations.localeName)}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'delete') {
              _showDeleteConfirmationDialog(context, ref, record);
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

  void _showClearHistoryDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Limpar Histórico'),
        content: const Text(
          'Tem certeza que deseja limpar todo o histórico de operações? Esta ação não pode ser desfeita.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              ref
                  .read(dateOperationsHistoryNotifierProvider.notifier)
                  .clearHistory();
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Histórico limpo com sucesso')),
              );
            },
            child: const Text('Limpar'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(
    BuildContext context,
    WidgetRef ref,
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
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              ref
                  .read(dateOperationsHistoryNotifierProvider.notifier)
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
