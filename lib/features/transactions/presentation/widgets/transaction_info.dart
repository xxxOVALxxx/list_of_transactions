import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:list_of_transactions/app/theme.dart';
import 'package:list_of_transactions/features/transactions/data/models/transaction.dart';

class TransactionInfo extends StatelessWidget {
  const TransactionInfo(this.transaction, this.removeTransaction, {super.key});

  final Transaction transaction;
  final Function() removeTransaction;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(spaceSm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Date:"),
                    Text("Amount:"),
                    Text("Fee:"),
                    Text("Total:"),
                    Text("ID:"),
                    Text("Type:"),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(transaction.time.toIso8601String()),
                    Text(transaction.amount.toString()),
                    Text(transaction.fee.toString()),
                    Text(transaction.calculateTotal().toString()),
                    Text(transaction.id),
                    Text(transaction.type.name),
                  ],
                )
              ],
            ),
            OutlinedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.error)),
                onPressed: () {
                  removeTransaction();
                  context.pop();
                },
                child:
                    const Text("Remove", style: TextStyle(color: Colors.white)))
          ],
        ),
      ),
    );
  }
}
