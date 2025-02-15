import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:testing/core/error/ApiFailure.dart';
import 'package:testing/data/data_sources/currency_api_client.dart';
import 'package:testing/data/models/currency_model.dart';
import 'package:testing/domain/entities/currency.dart';

import '../../domain/repositories/currency_repository.dart';

class CurrencyRepositoryImpl implements CurrencyRepository {
  final CurrencyApiClient client;

  CurrencyRepositoryImpl({required this.client});

  @override
  Future<Either<ApiFailure,List<Currency>>> getCurrency() async {
    final response = await client.getCurrencyPairs();
    if (response.statusCode != 200) {
      return Left(ApiFailure(statusCode: response.statusCode, responseBody: response.body));
    }
    final List<dynamic> jsonList = json.decode(response.body);
    return Right(jsonList.map((json) => CurrencyModel.fromJson(json)).toList());
  }
}