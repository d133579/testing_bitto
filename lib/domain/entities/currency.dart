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
}