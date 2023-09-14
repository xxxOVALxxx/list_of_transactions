part of 'transactions_bloc.dart';

@immutable
sealed class TransactionsState {}

final class TransactionsBlocInitial extends TransactionsState {}

final class FetchingTransactions extends TransactionsState {}

final class TransactionsFetched extends TransactionsState {
  TransactionsFetched(this.transactions);

  final List<Transaction> transactions;
}
