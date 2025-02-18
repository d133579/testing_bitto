import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/presentation/cubit/currency_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CurrencySelectionScreen extends StatelessWidget {
  const CurrencySelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 從 cubit 取得資料
    final currencies = context.watch<CurrencyCubit>().currencies;

    return Scaffold(
      appBar: AppBar(
        title: Text('選擇貨幣'),
      ),
      body: ListView.builder(
        itemCount: currencies.length,
        itemBuilder: (context, index) {
          final currency = currencies[index];
          return ListTile(
            leading: CachedNetworkImage(
              imageUrl: currency.icon,
              width: 30,
              height: 30,
              placeholder:
                  (context, url) =>
                  CircularProgressIndicator(),
              errorWidget:
                  (context, url, error) =>
                  Icon(Icons.error),
            ),
            title: Text(currency.currency),
            onTap: () {
              // 點選後將選擇結果返回上一頁
              Navigator.pop(context, currency);
            },
          );
        },
      ),
    );
  }
}