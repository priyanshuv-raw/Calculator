// ignore: file_names
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userInput = "";
  String result = "0";

  List<String> buttonList = [
    "AC",
    "(",
    ")",
    "/",
    "7",
    "8",
    "9",
    "*",
    "4",
    "5",
    "6",
    "+",
    "1",
    "2",
    "3",
    "-",
    "C",
    "0",
    ".",
    "=",
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // ignore: sized_box_for_whitespace
            Container(
              height: MediaQuery.of(context).size.height / 3.1,
              child: resultWidget(),
            ),
            Expanded(child: buttonWidget()),
          ],
        ),
      ),
    );
  }

  Widget resultWidget() {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              userInput,
              style: const TextStyle(
                fontSize: 38,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.centerRight,
            child: Text(
              result,
              style: const TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buttonWidget() {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Color.fromARGB(0, 255, 255, 255),
      child: GridView.builder(
          itemCount: buttonList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            return button(buttonList[index]);
          }),
    );
  }

  getColor(String text) {
    if (text == "/" || text == "*" || text == "+" || text == "-") {
      return Colors.white;
    }
    if (text == "1" ||
        text == "2" ||
        text == "3" ||
        text == "4" ||
        text == "5" ||
        text == "6" ||
        text == "7" ||
        text == "8" ||
        text == "9" ||
        text == "0" ||
        text == "AC" ||
        text == "(" ||
        text == ")" ||
        text == "C" ||
        text == ".") {
      return Color.fromARGB(255, 55, 55, 55);
    }
    if (text == "=") {
      return Colors.white;
    }
    return Colors.blue;
  }

  getBgColor(String text) {
    if (text == "/" ||
        text == "*" ||
        text == "+" ||
        text == "-" ||
        text == "=") {
      return Colors.blueAccent;
    }
    if (text == "AC" || text == "(" || text == ")" || text == "C") {
      return const Color.fromARGB(255, 205, 205, 205);
    }
    return Colors.white;
  }

  Widget button(String text) {
    return InkWell(
      onTap: () {
        setState(() {
          handleButtonPress(text);
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: getBgColor(text),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 1,
                spreadRadius: 1,
              )
            ]),
        child: Center(
            child: Text(
          text,
          style: TextStyle(
            color: getColor(text),
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
    );
  }

  handleButtonPress(String text) {
    if (text == "AC") {
      userInput = "";
      result = "0";
      return;
    }
    if (text == "C") {
      if (userInput.length > 0) {
        userInput = userInput.substring(0, userInput.length - 1);
        return;
      } else {
        return null;
      }
    }
    if (userInput.endsWith(".")) {
      userInput = userInput.replaceAll(".", ".");
    }
    if (text == "=") {
      result = calculate();
      userInput = result;
      if (userInput.endsWith(".0")) {
        userInput = userInput.replaceAll(".0", "");
      }
      if (result.endsWith(".0")) {
        result = result.replaceAll(".0", "");
      }
      return;
    }
    userInput = userInput + text;
  }

  String calculate() {
    try {
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return "Error";
    }
  }
}
