import 'package:intl/intl.dart';

class Currency {
  final String id;
  final String icon;
  final String currency;
  final double twPrice;
  final int amountDecimal;

  Currency({
    required this.id,
    required this.icon,
    required this.currency,
    required this.twPrice,
    required this.amountDecimal
  });

  String formatedPrice() {
    final formatter = NumberFormat("#,##0.00", "en_US");
    return formatter.format(twPrice);
  }
}