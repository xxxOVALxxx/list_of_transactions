import 'package:hive/hive.dart';
import 'package:list_of_transactions/features/transactions/data/models/transaction.dart';

abstract interface class LocalTransactionDataSource {
  Future<List<Transaction>> fetchUserTransactions();
  Future<void> deleteUserTransaction(String id);
  Future<void> putTransaction(Transaction transaction);
}

class HiveTransactionDataSource implements LocalTransactionDataSource {
  HiveTransactionDataSource._internal(this._box);

  final Box<Transaction> _box;

  @override
  Future<void> putTransaction(Transaction transaction) async {
    await _box.put(transaction.id, transaction);
  }

  @override
  Future<void> deleteUserTransaction(String id) async {
    await _box.delete(id);
  }

  @override
  Future<List<Transaction>> fetchUserTransactions() async {
    return _box.values.toList();
  }
}

class HiveTransactionDataSourceConnector {
  static Future<HiveTransactionDataSource> connect() async {
    return HiveTransactionDataSource._internal(
        await Hive.openBox<Transaction>('transactions'));
  }
}
