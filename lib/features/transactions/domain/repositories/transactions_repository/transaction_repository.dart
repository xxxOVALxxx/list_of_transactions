import 'package:list_of_transactions/features/transactions/data/data_sources/transactions_data_source.dart';
import 'package:list_of_transactions/features/transactions/data/models/transaction.dart';

abstract interface class TransactionsRepository {
  Future<List<Transaction>> fetchUserTransactions();
  Future<void> deleteUserTransaction(Transaction transaction);
  Future<void> addTransaction(Transaction transaction);
}

class LocalTransactionsRepository implements TransactionsRepository {
  LocalTransactionsRepository(this.dataSource);

  LocalTransactionDataSource dataSource;

  @override
  Future<List<Transaction>> fetchUserTransactions() async {
    return dataSource.fetchUserTransactions();
  }

  @override
  Future<void> deleteUserTransaction(Transaction transaction) async {
    await dataSource.deleteUserTransaction(transaction.id);
  }

  @override
  Future<void> addTransaction(Transaction transaction) async {
    await dataSource.putTransaction(transaction);
  }
}
