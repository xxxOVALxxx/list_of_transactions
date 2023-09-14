import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_of_transactions/app/router.dart';
import 'package:list_of_transactions/app/theme.dart';
import 'package:list_of_transactions/features/transactions/data/data_sources/transactions_data_source.dart';
import 'package:list_of_transactions/features/transactions/data/models/transaction.dart';
import 'package:list_of_transactions/features/transactions/domain/repositories/transactions_repository/transaction_repository.dart';
import 'package:list_of_transactions/features/transactions/presentation/bloc/transactions_bloc.dart';
import 'package:list_of_transactions/features/users/domain/entities/user.dart';
import 'package:list_of_transactions/features/users/domain/repositories/user_repository.dart';
import 'package:list_of_transactions/features/users/presentation/bloc/login_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(TransactionTypeAdapter());
  Hive.registerAdapter(TransactionAdapter());

  final userRepository = await HiveUserRepositoryConnector.connect();
  final transactionDataSource =
      await HiveTransactionDataSourceConnector.connect();

  await _initDB();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => LoginBloc(userRepository)),
      BlocProvider(
          create: (context) => TransactionsBloc(
              LocalTransactionsRepository(transactionDataSource))
            ..add(FetchTransactions()))
    ],
    child: MaterialApp.router(
      routerConfig: router,
      theme: theme,
    ),
  ));
}

Future<void> _initDB() async {
  final bool? isOpenedFirstTime =
      (await Hive.openBox('isOpenedFirstTime')).values.firstOrNull;

  //Clear cache or set isOpenedFirstTime == true to reinit records
  if (isOpenedFirstTime == null || isOpenedFirstTime == true) {
    Hive.box("isOpenedFirstTime").add(false);

    //Put test records
    Hive.box<User>('users').put('user', User('user', 'user'));
    Hive.box<User>('users').put('', User('', ''));
    Hive.box<Transaction>('transactions').put(
        '1',
        Transaction(TransactionType.deposit, '1', DateTime(2017, 9, 7, 17, 30),
            1000, 10));
    Hive.box<Transaction>('transactions').put(
        '2',
        Transaction(TransactionType.deposit, '2', DateTime(2017, 9, 7, 17, 30),
            2570, 49));
    Hive.box<Transaction>('transactions').put(
        '3',
        Transaction(TransactionType.deposit, '3', DateTime(2017, 9, 7, 17, 30),
            3000, 30));

    Hive.box<Transaction>('transactions').put(
        '4',
        Transaction(TransactionType.transfer, '4',
            DateTime(2017, 10, 8, 20, 30), 500, 50));

    Hive.box<Transaction>('transactions').put(
        '5',
        Transaction(TransactionType.withdrawal, '5',
            DateTime(2018, 2, 1, 20, 30), 500, 50));
  }
}
