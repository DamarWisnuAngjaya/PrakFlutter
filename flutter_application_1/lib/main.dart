import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulator Konversi Suhu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final TextEditingController suhuController = TextEditingController();

  String satuan = "Celsius";

  double c = 0;
  double f = 0;
  double k = 0;
  double r = 0;

  void konversi() {

    double input = double.tryParse(suhuController.text) ?? 0;

    setState(() {

      if (satuan == "Celsius") {
        c = input;
        f = (9/5 * c) + 32;
        k = c + 273.15;
        r = 4/5 * c;
      }

      else if (satuan == "Fahrenheit") {
        f = input;
        c = (f - 32) * 5/9;
        k = c + 273.15;
        r = 4/5 * c;
      }

      else if (satuan == "Kelvin") {
        k = input;
        c = k - 273.15;
        f = (9/5 * c) + 32;
        r = 4/5 * c;
      }

      else if (satuan == "Reaumur") {
        r = input;
        c = 5/4 * r;
        f = (9/5 * c) + 32;
        k = c + 273.15;
      }

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Kalkulator Konversi Suhu"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            TextField(
              controller: suhuController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Masukkan Suhu",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            DropdownButton<String>(
              value: satuan,
              items: const [
                DropdownMenuItem(value: "Celsius", child: Text("Celsius")),
                DropdownMenuItem(value: "Fahrenheit", child: Text("Fahrenheit")),
                DropdownMenuItem(value: "Kelvin", child: Text("Kelvin")),
                DropdownMenuItem(value: "Reaumur", child: Text("Reaumur")),
              ],
              onChanged: (value) {
                setState(() {
                  satuan = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: konversi,
              child: const Text("Konversi"),
            ),

            const SizedBox(height: 30),

            Text("Celsius : ${c.toStringAsFixed(2)} °C"),
            Text("Fahrenheit : ${f.toStringAsFixed(2)} °F"),
            Text("Kelvin : ${k.toStringAsFixed(2)} K"),
            Text("Reaumur : ${r.toStringAsFixed(2)} °R"),

          ],
        ),
      ),
    );
  }
}