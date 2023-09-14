import 'package:hive/hive.dart';

part 'transaction.g.dart';

@HiveType(typeId: 0)
class Transaction {
  Transaction(this.type, this.id, this.time, this.amount, this.fee);
  @HiveField(0)
  final TransactionType type;
  @HiveField(1)
  final String id;
  @HiveField(2)
  final DateTime time;
  @HiveField(3)
  final double amount;
  @HiveField(4)
  final double fee;
  double calculateTotal() {
    return amount - fee;
  }
}

@HiveType(typeId: 1)
enum TransactionType {
  @HiveField(0)
  transfer,
  @HiveField(1)
  deposit,
  @HiveField(2)
  withdrawal
}
