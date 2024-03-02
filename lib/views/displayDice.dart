import 'package:flutter/material.dart';
import 'package:mp2/models/datamodel.dart';
import 'package:provider/provider.dart';

class DisplayDice extends StatefulWidget {
  const DisplayDice({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DisplayDiceState createState() => _DisplayDiceState();
}

class _DisplayDiceState extends State<DisplayDice> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Consumer<DataModel>(builder: (context, data, _) {
              return ListenableBuilder(
                  listenable: data.dice,
                  builder: (BuildContext context, Widget? child) {
                    return Column(children: [
                      const SizedBox(height: 16),
                      if (data.isRollButtonPressed)
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children:
                                List.generate(data.dice.values.length, (index) {
                              final i = index;
                              return Expanded(
                                child: GestureDetector(
                                    onTap: () => {
                                          data.dice.toggleHold(i),
                                          setState(() {})
                                        },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 100.0,
                                        height: 100.0,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: data.dice.isHeld(i)
                                                ? Colors.red
                                                : Colors.black,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "${data.dice.values[i]}",
                                            style:
                                                const TextStyle(fontSize: 60),
                                          ),
                                        ),
                                      ),
                                    )),
                              );
                            })),
                      const SizedBox(height: 12),
                      ElevatedButton(
                          onPressed: data.dice.rollCount > 0
                              ? () {
                                  data.dice.roll();
                                  data.dice.rollCount -= 1;
                                  setState(() {
                                    data.isRollButtonPressed = true;
                                  });
                                }
                              : null,
                          child: Text(data.dice.rollCount > 0
                              ? "Roll ${data.dice.rollCount}"
                              : "Out of Rolls")),
                      TextButton(
                          onPressed: data.score.completed
                              ? () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Game Over'),
                                        content: Text(
                                            'Total Score: ${data.score.total}'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              // Clear registered scores and dice to start a new game
                                              data.score.clear();
                                              data.dice.clear();
                                              setState(() {
                                                data.isRollButtonPressed =
                                                    false;
                                              });
                                              Navigator.pop(
                                                  context); // Close the dialog box
                                            },
                                            child: const Text('New Game'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              : null,
                          child: Text(
                            data.score.completed
                                ? '!!Game Over!! Check Score'
                                : '',
                          ))
                    ]);
                  });
            }),
          ],
        ));
  }
}
