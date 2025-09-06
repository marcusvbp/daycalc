import 'package:daycalc/app/enums/operation_type.dart';
import 'package:daycalc/app/models/date_operation_record.dart';
import 'package:daycalc/app/providers/date_operations_history_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class HistoryTabScreen extends ConsumerWidget {
  const HistoryTabScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(dateOperationsHistoryNotifierProvider);

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
                'Erro ao carregar histórico',
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
                child: const Text('Tentar novamente'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: historyAsync.when(
        data: (history) => history.isNotEmpty
            ? Container(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton.icon(
                    onPressed: () => _showClearHistoryDialog(context, ref),
                    icon: const Icon(Icons.clear_all),
                    label: const Text('Limpar Histórico'),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
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
              'Nenhuma operação registrada',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'As operações realizadas aparecerão aqui',
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
      children: [
        // Lista de operações
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: sortedHistory.length,
            itemBuilder: (context, index) {
              final record = sortedHistory[index];
              return _buildHistoryItem(context, ref, record, index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryItem(
    BuildContext context,
    WidgetRef ref,
    DateOperationRecord record,
    int index,
  ) {
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    final isAddOperation = record.operationType == OperationType.add;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isAddOperation ? Colors.green : Colors.red,
          child: Icon(
            isAddOperation ? Icons.add : Icons.remove,
            color: Colors.white,
          ),
        ),
        title: Text(
          record.operationDescription,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          dateFormat.format(record.timestamp),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'delete') {
              _showDeleteConfirmationDialog(context, ref, record);
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Excluir'),
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
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir Operação'),
        content: Text(
          'Tem certeza que deseja excluir a operação "${record.operationDescription}"?',
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
                  .removeOperationRecord(record);
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Operação excluída com sucesso')),
              );
            },
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }
}
