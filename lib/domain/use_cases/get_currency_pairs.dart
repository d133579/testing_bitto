import 'package:testing/core/error/ApiFailure.dart';
import 'package:testing/domain/entities/currency.dart';
import 'package:testing/domain/repositories/currency_repository.dart';
import 'package:dartz/dartz.dart';

class GetCurrencyPairs {
  final CurrencyRepository repository;

  GetCurrencyPairs(this.repository);

  Future<Either<ApiFailure,List<Currency>>> execute() async {
    return await repository.getCurrency();
  }
}