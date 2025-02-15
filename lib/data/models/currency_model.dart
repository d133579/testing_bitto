import 'package:testing/domain/entities/currency.dart';

class CurrencyModel extends Currency {
  CurrencyModel({
    required super.id,
    required super.icon,
    required super.currency,
    required super.twPrice,
    required super.amountDecimal
  });
  
  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
        id: json['id'],
        icon: json['currency_icon'],
        currency: json['currency'],
        twPrice: json['twd_price'],
        amountDecimal: int.tryParse(json['amount_decimal'].toString()) ?? 0
    );
  }

  Map<String,dynamic> toJson() {
    return {
      'id': id,
      'currency': id,
      'currency_icon': icon,
      'twd_price': twPrice,
      'amount_decimal': amountDecimal
    };
  }
}