import 'dart:math';

import 'package:testing/domain/entities/currency.dart';
import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:testing/domain/use_cases/get_currency_pairs.dart';

abstract class CurrencyState {}

class CurrencyInitial extends CurrencyState {}

class CurrencyLoading extends CurrencyState {}

class CurrencyLoaded extends CurrencyState {
  final List<Currency> currencies;

  CurrencyLoaded(this.currencies);
}

class CurrencyError extends CurrencyState {
  final String message;

  CurrencyError(this.message);
}

class CurrencyCubit extends Cubit<CurrencyState> {
  final GetCurrencyPairs getCurrencyPairsUseCase;
  List<Currency> currencies = [];

  CurrencyCubit({required this.getCurrencyPairsUseCase})
    : super(CurrencyInitial());

  Future<void> getCurrencyPairs() async {
    emit(CurrencyLoading());
    final pairs = await getCurrencyPairsUseCase.execute();
    pairs.fold(
      (error) {
        emit(CurrencyError(error.responseBody));
      },
      (value) {
        currencies = value;
        emit(CurrencyLoaded(value));
      },
    );
  }

  double convertCurrency({
    required String amount,
    required Currency? from,
    required Currency? to,
  }) {
    if (from == null || to == null || amount.trim().isEmpty) {
      return 0.0;
    }

    try {
      final num parsedNum = NumberFormat.decimalPattern('en_US').parse(amount);
      final double parsedAmount = parsedNum.toDouble();

      double twPrice = parsedAmount * from.twPrice;
      double targetAmount = twPrice / to.twPrice;
      double factor = pow(10, to.amountDecimal).toDouble();
      double truncated = (targetAmount * factor).floor() / factor;

      return truncated;
    } catch (e) {
      return 0.0;
    }
  }
}
