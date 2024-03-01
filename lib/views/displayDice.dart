import 'package:flutter/material.dart';
import 'package:mp2/models/dice.dart';
// import 'package:provider/provider.dart';

class DisplayDice extends StatefulWidget {
  const DisplayDice({super.key});

  @override
  // ignore: library_private_types_in_public_api
      _DisplayDiceState createState() => _DisplayDiceState();
}

class _DisplayDiceState extends State<DisplayDice> {
  final Dice _dice = Dice(5);
  bool _isButtonPressed = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListenableBuilder(
                listenable: _dice,
                builder: (BuildContext context, Widget? child) {
                  return Column(children: [
                    const SizedBox(height: 16),
                    if (_isButtonPressed)
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(5, (i) {
                            return Expanded(
                              child: GestureDetector(
                                  onTap: () =>
                                      {_dice.toggleHold(i), setState(() {})},
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 100.0,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: _dice.isHeld(i)
                                              ? Colors.red
                                              : Colors.black,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "${_dice.values[i]}",
                                          style: const TextStyle(fontSize: 60),
                                        ),
                                      ),
                                    ),
                                  )),
                            );
                          })),
                    const SizedBox(height: 12),
                    ElevatedButton(
                        onPressed: _dice.rollCount > 0
                            ? () {
                                _dice.roll();
                                _dice.rollCount -= 1;
                                setState(() {
                                  _isButtonPressed = true;
                                });
                              }
                            : null,
                        child: Text("Roll ${_dice.rollCount}"))
                  ]);
                }),
          ],
        ));
  }
}
