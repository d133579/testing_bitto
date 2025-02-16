import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:testing/core/error/ApiFailure.dart';
import 'package:testing/domain/entities/currency.dart';
import 'package:testing/domain/repositories/currency_repository.dart';
import 'package:testing/domain/use_cases/get_currency_pairs.dart';
import 'package:testing/presentation/cubit/currency_cubit.dart';

class FakeGetCurrencyPairsSuccess implements GetCurrencyPairs {
  @override
  Future<Either<ApiFailure, List<Currency>>> execute() async {
    return Right([
      Currency(
        id: "1",
        currency: "USD",
        icon: "https://example.com/icon1.png",
        twPrice: 30.0,
        amountDecimal: 2,
      ),
      Currency(
        id: "2",
        currency: "EUR",
        icon: "https://example.com/icon2.png",
        twPrice: 35.0,
        amountDecimal: 2,
      ),
    ]);
  }

  @override
  // TODO: implement repository
  CurrencyRepository get repository => throw UnimplementedError();
}

class FakeGetCurrencyPairsFailure implements GetCurrencyPairs {
  @override
  Future<Either<ApiFailure, List<Currency>>> execute() async {
    return Left(ApiFailure(statusCode: 404, responseBody: "Not Found"));
  }

  @override
  // TODO: implement repository
  CurrencyRepository get repository => throw UnimplementedError();
}

void main() {
  group('CurrencyCubit', () {
    blocTest(
      'getCurrencyPairs success',
      build:
          () => CurrencyCubit(
            getCurrencyPairsUseCase: FakeGetCurrencyPairsSuccess(),
          ),
      act: (cubit) => cubit.getCurrencyPairs(),
      expect: () => [isA<CurrencyLoading>(), isA<CurrencyLoaded>()],
      verify: (cubit) {
        final state = cubit.state;
        if (state is CurrencyLoaded) {
          expect(state.currencies.length, 2);
          expect(state.currencies.first.id, '1');
        } else {
          fail('State is not CurrencyLoaded');
        }
      },
    );

    blocTest<CurrencyCubit, CurrencyState>(
      'getCurrencyPairs fails',
      build:
          () => CurrencyCubit(
            getCurrencyPairsUseCase: FakeGetCurrencyPairsFailure(),
          ),
      act: (cubit) => cubit.getCurrencyPairs(),
      expect: () => [isA<CurrencyLoading>(), isA<CurrencyError>()],
      verify: (cubit) {
        final state = cubit.state;
        if (state is CurrencyError) {
          expect(state.message, "Not Found");
        } else {
          fail('State is not CurrencyError');
        }
      },
    );
  });
}
