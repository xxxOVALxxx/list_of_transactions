import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_of_transactions/features/transactions/data/models/transaction.dart';
import 'package:list_of_transactions/features/transactions/presentation/bloc/transactions_bloc.dart';
import 'package:list_of_transactions/features/transactions/presentation/widgets/widgets.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList(this.transactions, {super.key});

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text('Transactions count: ${transactions.length}'),
        ),
        const Divider(),
        Expanded(
          child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                Transaction transaction = transactions[index];
                return ListTile(
                  onTap: () => showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return TransactionInfo(transaction, () {
                        context
                            .read<TransactionsBloc>()
                            .add(RemoveTransaction(transaction));
                        context
                            .read<TransactionsBloc>()
                            .add(FetchTransactions());
                      });
                    },
                  ),
                  trailing: Text('Type: ${transaction.type.name}'),
                  title: Text('Amount: ${transaction.amount} У.е.'),
                  subtitle: Text('id ${transaction.id}'),
                );
              }),
        ),
      ],
    );
  }
}
