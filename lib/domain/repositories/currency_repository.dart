import 'package:testing/core/error/ApiFailure.dart';
import 'package:testing/domain/entities/currency.dart';
import 'package:dartz/dartz.dart';

abstract class CurrencyRepository {
  Future<Either<ApiFailure,List<Currency>>> getCurrency();
}