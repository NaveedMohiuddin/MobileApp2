import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:mp2/views/displayDice.dart';

class Yahtzee extends StatelessWidget {
  const Yahtzee({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Yahtzee",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                letterSpacing: -0.050,
                fontSize: 28,
              )),
          backgroundColor: const Color.fromARGB(136, 92, 251, 195),
        ),
        body: const DisplayDice());
  }
}
