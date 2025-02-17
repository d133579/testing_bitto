import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:testing/core/error/ApiFailure.dart';
import 'package:testing/data/data_sources/currency_api_client.dart';
import 'package:testing/data/repositories/currency_repository_impl.dart';
import 'package:testing/domain/entities/currency.dart';
import 'package:testing/domain/repositories/currency_repository.dart';
import 'package:testing/domain/use_cases/get_currency_pairs.dart';
import 'package:testing/presentation/cubit/currency_cubit.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'dart:convert';

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
  group('CurrencyCubit - getCurrencyPairs', () {
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
  group('description', (){
    exchange();
  });
}

void exchange() {
  final mockResponse = jsonEncode([
    [
      {
        "currency": "OMR",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 51387.29,
        "amount_decimal": "4",
        "id": "1"
      },
      {
        "currency": "NZD",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 29856.83,
        "amount_decimal": "6",
        "id": "2"
      },
      {
        "currency": "LTL",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 17975.59,
        "amount_decimal": "9",
        "id": "3"
      },
      {
        "currency": "TND",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 90481.5,
        "amount_decimal": "3",
        "id": "4"
      },
      {
        "currency": "XPD",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 5546.95,
        "amount_decimal": "8",
        "id": "5"
      },
      {
        "currency": "KMF",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 13686.11,
        "amount_decimal": "9",
        "id": "6"
      },
      {
        "currency": "CUC",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 99702.09,
        "amount_decimal": "7",
        "id": "7"
      },
      {
        "currency": "MDL",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 56017.28,
        "amount_decimal": "7",
        "id": "8"
      },
      {
        "currency": "VUV",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 96852.81,
        "amount_decimal": "1",
        "id": "9"
      },
      {
        "currency": "CUP",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 57355.5,
        "amount_decimal": "3",
        "id": "10"
      },
      {
        "currency": "BSD",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 32092.87,
        "amount_decimal": "9",
        "id": "11"
      },
      {
        "currency": "BTN",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 58602.09,
        "amount_decimal": "3",
        "id": "12"
      },
      {
        "currency": "AZN",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 39522.99,
        "amount_decimal": "1",
        "id": "13"
      },
      {
        "currency": "TOP",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 601.29,
        "amount_decimal": "4",
        "id": "14"
      },
      {
        "currency": "XPD",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 71747.91,
        "amount_decimal": "1",
        "id": "15"
      },
      {
        "currency": "SLL",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 40242.66,
        "amount_decimal": "8",
        "id": "16"
      },
      {
        "currency": "QAR",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 76636.44,
        "amount_decimal": "2",
        "id": "17"
      },
      {
        "currency": "BBD",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 96497.01,
        "amount_decimal": "8",
        "id": "18"
      },
      {
        "currency": "MZN",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 10938.29,
        "amount_decimal": "6",
        "id": "19"
      },
      {
        "currency": "BMD",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 97968.91,
        "amount_decimal": "3",
        "id": "20"
      },
      {
        "currency": "SAR",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 54328.41,
        "amount_decimal": "8",
        "id": "21"
      },
      {
        "currency": "AED",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 70009.9,
        "amount_decimal": "1",
        "id": "22"
      },
      {
        "currency": "VND",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 37943.21,
        "amount_decimal": "1",
        "id": "23"
      },
      {
        "currency": "CUP",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 93352.5,
        "amount_decimal": "2",
        "id": "24"
      },
      {
        "currency": "BTN",
        "currency_icon": "https://loremflickr.com/640/480/food",
        "twd_price": 84266.43,
        "amount_decimal": "2",
        "id": "25"
      }
    ]

  ]);
  final mockClient = MockClient((request) async {
    return http.Response(mockResponse,200);
  });

  final client = CurrencyApiClient(client: mockClient);
  final currencyRepositoryImpl = CurrencyRepositoryImpl(client: client);
  final getCurrencyPairs = GetCurrencyPairs(currencyRepositoryImpl);
  final cubit = CurrencyCubit(getCurrencyPairsUseCase: getCurrencyPairs);

  test('OMR to NZD(round down to maximum precision)', () {
    final omr = Currency(
      id: '1',
      icon: '',
      currency: 'OMR',
      twPrice: 51387.29,
      amountDecimal: 4,
    );
    final nzd = Currency(
      id: '2',
      icon: '',
      currency: 'NZD',
      twPrice: 29856.83,
      amountDecimal: 6,
    );
    /*
      1 OMR to TWD
      51,387.29 = 51,387.29
      2. TWD to NZD
      51,387.29 / 29,856.83 ≈ 1.72112344
    */
    final result = cubit.convertCurrency(amount: "1", from: omr, to: nzd);
    expect(result, 1.721123);
  });

  test('integer exchange', () {
    final btc = Currency(
      id: 'btc',
      icon: '',
      currency: 'BTC',
      twPrice: 10000,
      amountDecimal: 9,
    );
    final eth = Currency(
      id: 'eth',
      icon: '',
      currency: 'ETH',
      twPrice: 5000,
      amountDecimal: 6,
    );
    final result = cubit.convertCurrency(amount: "1", from: btc, to: eth);
    expect(result, equals(2.0));
  });

  test('should return 0.0 for empty amount', () {
    final dummyFrom = Currency(
      id: '1',
      icon: '',
      currency: 'A',
      twPrice: 10000,
      amountDecimal: 2,
    );
    final dummyTo = Currency(
      id: '2',
      icon: '',
      currency: 'B',
      twPrice: 5000,
      amountDecimal: 2,
    );
    final result = cubit.convertCurrency(amount: "", from: dummyFrom, to: dummyTo);
    expect(result, equals(0.0));
  });

  test('should return 0.0 for non-numeric amount', () {
    final dummyFrom = Currency(
      id: '1',
      icon: '',
      currency: 'A',
      twPrice: 10000,
      amountDecimal: 2,
    );
    final dummyTo = Currency(
      id: '2',
      icon: '',
      currency: 'B',
      twPrice: 5000,
      amountDecimal: 2,
    );
    final result = cubit.convertCurrency(amount: "abc", from: dummyFrom, to: dummyTo);
    expect(result, equals(0.0));
  });

  test('should return 0.0 when from or to is null', () {
    final dummy = Currency(
      id: '1',
      icon: '',
      currency: 'A',
      twPrice: 10000,
      amountDecimal: 2,
    );
    final result1 = cubit.convertCurrency(amount: "1", from: null, to: dummy);
    final result2 = cubit.convertCurrency(amount: "1", from: dummy, to: null);
    expect(result1, equals(0.0));
    expect(result2, equals(0.0));
  });

  test('should parse amount with thousand separators correctly', () {
    final dummyFrom = Currency(
      id: '1',
      icon: '',
      currency: 'X',
      twPrice: 1.0,
      amountDecimal: 2,
    );
    final dummyTo = Currency(
      id: '2',
      icon: '',
      currency: 'Y',
      twPrice: 1.0,
      amountDecimal: 2,
    );
    final result = cubit.convertCurrency(amount: "123,456.88", from: dummyFrom, to: dummyTo);
    expect(result, equals(123456.88));
  });
}
