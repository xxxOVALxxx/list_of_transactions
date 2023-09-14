import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_of_transactions/common/widgets/widgets.dart';
import 'package:list_of_transactions/features/transactions/presentation/bloc/transactions_bloc.dart';
import 'package:list_of_transactions/features/transactions/presentation/widgets/widgets.dart';

class ChartsPage extends StatelessWidget {
  const ChartsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsBloc, TransactionsState>(
      builder: (BuildContext context, TransactionsState state) {
        return switch (state) {
          FetchingTransactions() => const AppProgressIndicator(),
          TransactionsBlocInitial() => const AppProgressIndicator(),
          TransactionsFetched() => DonutChart(state.transactions)
        };
      },
    );
  }
}
