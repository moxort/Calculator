import 'package:flutter/material.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  _ConverterScreenState createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final TextEditingController _kilometerController = TextEditingController();
  double _mileResult = 0.0;

  @override
  void dispose() {
    _kilometerController.dispose();
    super.dispose();
  }

  void convertKmToMile() {
    double km = double.tryParse(_kilometerController.text) ?? 0.0;
    double mile = km * 0.6213712;
    setState(() {
      _mileResult = mile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Converter"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _kilometerController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Kilometers",
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: convertKmToMile,
              child: const Text("Convert"),
            ),
            const SizedBox(height: 16.0),
            Text(
              "Miles: $_mileResult",
              style: const TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}
