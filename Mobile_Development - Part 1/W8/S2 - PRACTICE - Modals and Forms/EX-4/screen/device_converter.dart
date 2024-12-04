import 'package:flutter/material.dart';
 
class DeviceConverter extends StatefulWidget {
  const DeviceConverter({super.key});

  @override
  State<DeviceConverter> createState() => _DeviceConverterState();
}

class _DeviceConverterState extends State<DeviceConverter> {
  final _dollarController = TextEditingController();

  final BoxDecoration textDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
  );

  final Map<String, double> _conversionRates = {
    'Euro': 0.92,
    'Riels': 4100.0,
    'Dong': 24000.0,
  };

  String? _selectedCurrency;
  double _convertedAmount = 0.0;

  @override
  void dispose() {
    _dollarController.dispose();
    super.dispose();
  }

  void _convertCurrency() {
    // Check if both dollar input and currency are selected
    if (_dollarController.text.isNotEmpty && _selectedCurrency != null) {
      try {
        double dollarAmount = double.parse(_dollarController.text);
        setState(() {
          _convertedAmount = dollarAmount * (_conversionRates[_selectedCurrency] ?? 1.0);
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a valid dollar amount')),
        );
      }
    }
  }
 

  @override
  void initState() {
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(
            Icons.money,
            size: 60,
            color: Colors.white,
          ),
          const Center(
            child: Text(
              "Converter",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
          const SizedBox(height: 50),
          const Text("Amount in dollars:"),
          const SizedBox(height: 10),

          TextField(
            controller: _dollarController,
            decoration: InputDecoration(
                prefix: const Text('\$ '),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Enter an amount in dollar',
                hintStyle: const TextStyle(color: Colors.white)),
            style: const TextStyle(color: Colors.white)),

          const SizedBox(height: 30),
          DropdownButton(
            hint: const Text("Currency"),
            value: _selectedCurrency,
            items: _conversionRates.keys.map((String currency){
              return DropdownMenuItem(
                value: currency,
                child: Text(currency)
              );
            }).toList(), 
            onChanged: (String? value){
              setState(() {
                _selectedCurrency = value;
              });
              _convertCurrency();
            }
            ),
       
          const SizedBox(height: 30),
          const Text("Amount in selected device:"),
          const SizedBox(height: 10),
          Container(
              padding: const EdgeInsets.all(10),
              decoration: textDecoration,
              child: Text(
                _selectedCurrency != null 
                ? '$_convertedAmount'
                : '0'
              )
            )
        ],
      )),
    );
  }
}
