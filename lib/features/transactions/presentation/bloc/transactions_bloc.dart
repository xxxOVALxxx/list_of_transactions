import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:list_of_transactions/features/transactions/data/models/transaction.dart';
import 'package:list_of_transactions/features/transactions/domain/repositories/transactions_repository/transaction_repository.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  final TransactionsRepository repository;

  TransactionsBloc(this.repository) : super(TransactionsBlocInitial()) {
    on<FetchTransactions>(_onFetchTransactions);
    on<RemoveTransaction>(_onRemoveTransaction);
  }

  Future<FutureOr<void>> _onFetchTransactions(
      FetchTransactions event, Emitter<TransactionsState> emit) async {
    emit(FetchingTransactions());

    try {
      final transactions = await repository.fetchUserTransactions();
      emit(TransactionsFetched(transactions));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  FutureOr<void> _onRemoveTransaction(
      RemoveTransaction event, Emitter<TransactionsState> emit) {
    repository.deleteUserTransaction(event.transactionToRemove);
  }
}
