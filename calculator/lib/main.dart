// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:calculator/colors.dart';

void main() {
  runApp(const MaterialApp(
    home: CalculatorApp(),
  ));
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        Expanded(child: Container(color: Colors.red)),
        const Row(
          children: [Button(buttonColor,operatorColor),Button(operatorColor,buttonColor)],
        )
      ]),
    );
  }
}

class Button extends StatelessWidget {
  const Button(Color buColor ,Color oColor, {super.key});

  @override
  Widget build(BuildContext context) {

    return Expanded(
        child: Container(
            margin: const EdgeInsets.all(4),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    padding: const EdgeInsets.all(15),
                    primary: bColor),
                onPressed: () {},
                child: const Text(
                  '3',
                  style: TextStyle(
                    fontSize: 36,
                    color: oColor,
                    fontWeight: FontWeight.bold,
                  ),
                ))));
  }
}
