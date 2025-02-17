import 'package:flutter/material.dart';
import 'package:testing/presentation/cubit/currency_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/currency.dart';

class RateConversionScreen extends StatefulWidget {
  const RateConversionScreen({super.key});

  @override
  State<RateConversionScreen> createState() => _RateConversionScreenState();
}

class _RateConversionScreenState extends State<RateConversionScreen> {
  late Currency? from;
  late Currency? to;
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final currencies = context.read<CurrencyCubit>().currencies;
    from = currencies.isNotEmpty ? currencies[0] : null;
    to = currencies.length > 1 ? currencies[1] : from;
  }

  Widget buildCurrencyDropdown(BuildContext context, String currency) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.35,
      height: 40,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Row(
        children: [
          const SizedBox(width: 5),
          const Icon(Icons.arrow_downward, color: Colors.black, size: 30),
          const Spacer(),
          Text(currency),
          const SizedBox(width: 10),
          const Icon(Icons.arrow_drop_down, color: Colors.black, size: 30),
        ],
      ),
    );
  }

  Widget buildCurrencyTextField(
    BuildContext context,
    TextEditingController controller, {
    bool readOnly = false,
  }) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.35,
      height: 40,
      margin: const EdgeInsets.only(right: 8),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.right,
        readOnly: readOnly,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 8),
        ),
        onChanged:
            !readOnly
                ? (text) {
                  updateConversion(text);
                }
                : null,
      ),
    );
  }

  Widget buildCurrencyRow(
    BuildContext context,
    TextEditingController controller, {
    bool readOnly = false,
  }) {
    return Row(
      children: [
        buildCurrencyDropdown(
          context,
          readOnly == false ? from?.currency ?? '' : to?.currency ?? '',
        ),
        const Spacer(),
        if (from != null && to != null)
          buildCurrencyTextField(context, controller, readOnly: readOnly),
      ],
    );
  }

  void updateConversion(String text) {
    double converted = context.read<CurrencyCubit>().convertCurrency(
      amount: text,
      from: from,
      to: to,
    );
    setState(() {
      toController.text = '$converted';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rate Conversion'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildCurrencyRow(context, fromController),
            const SizedBox(height: 16),
            Container(
              width: MediaQuery.sizeOf(context).width - 32,
              height: 60,
              child: Stack(
                children: [
                  Positioned(
                    top: 29,
                    child: Container(
                      color: Colors.black,
                      width: MediaQuery.sizeOf(context).width - 32,
                      height: 2,
                    ),
                  ),
                  Positioned(
                    top: 5,
                    left: 55,
                    child: ClipOval(
                      child: Container(
                        height: 50,
                        width: 50,
                        color: Colors.black,
                        child: const Icon(
                          Icons.keyboard_double_arrow_down_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 20,
                    child: Text(
                      '1 ${from?.currency ?? ""}≈ ${context.read<CurrencyCubit>().convertCurrency(amount: '1', from: from, to: to)} ${to?.currency ?? ""}',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            buildCurrencyRow(context, toController, readOnly: true),
          ],
        ),
      ),
    );
  }
}
