part of 'transactions_bloc.dart';

@immutable
sealed class TransactionsEvent {}

final class FetchTransactions extends TransactionsEvent {}

final class RemoveTransaction extends TransactionsEvent {
  RemoveTransaction(this.transactionToRemove);

  final Transaction transactionToRemove;
}
