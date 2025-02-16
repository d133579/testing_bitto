import 'package:testing/domain/entities/currency.dart';
import 'package:bloc/bloc.dart';

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

  CurrencyCubit({required this.getCurrencyPairsUseCase}) : super(CurrencyInitial());

  Future<void> getCurrencyPairs() async {
    emit(CurrencyLoading());
    final pairs = await getCurrencyPairsUseCase.execute();
    pairs.fold(
      (error) {
        emit(CurrencyError(error.responseBody));
      },
      (value) {
        emit(CurrencyLoaded(value));
      },
    );
  }
}
