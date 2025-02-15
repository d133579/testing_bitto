import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing/core/error/ApiFailure.dart';
import 'package:testing/domain/entities/currency.dart';
import 'package:testing/domain/repositories/currency_repository.dart';
import 'package:testing/domain/use_cases/get_currency_pairs.dart';

class FakeCurrencyRepositorySuccess implements CurrencyRepository {
  @override
  Future<Either<ApiFailure, List<Currency>>> getCurrency() async {
    // 模擬回傳兩筆資料
    return Right([
      Currency(
        id: '1',
        currency: 'OMR',
        icon: 'https://loremflickr.com/640/480/food',
        twPrice: 51387.29,
        amountDecimal: 4,
      ),
      Currency(
        id: '2',
        currency: 'NZD',
        icon: 'https://loremflickr.com/640/480/food',
        twPrice: 29856.83,
        amountDecimal: 6,
      ),
    ]);
  }
}

class FakeCurrencyRepositoryFailure implements CurrencyRepository {
  @override
  Future<Either<ApiFailure, List<Currency>>> getCurrency() async {
    // 模擬回傳失敗，包含 status code 與 responseBody
    return Left(ApiFailure(statusCode: 404, responseBody: 'Not Found'));
  }
}

void main() {
  group('GetCurrencyPairs Use Case', () {
    test('success', () async {
      final repository = FakeCurrencyRepositorySuccess();
      final useCase = GetCurrencyPairs(repository);

      final result = await useCase.execute();
      expect(result.isRight(), true);

      result.fold(
            (failure) => fail('$failure'),
            (currencies) {
          expect(currencies, isA<List<Currency>>());
          expect(currencies.length, 2);
          expect(currencies.first.id, '1');
        },
      );
    });

    test('failed', () async {
      final repository = FakeCurrencyRepositoryFailure();
      final useCase = GetCurrencyPairs(repository);

      final result = await useCase.execute();
      expect(result.isLeft(), true);

      result.fold(
            (failure) {
          expect(failure, isA<ApiFailure>());
          expect(failure.statusCode, 404);
          expect(failure.responseBody, 'Not Found');
        },
            (currencies) => fail('$currencies'),
      );
    });
  });
}