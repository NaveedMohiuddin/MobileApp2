import 'package:flutter/material.dart';
import 'package:mp2/models/datamodel.dart';
import 'package:mp2/models/scorecard.dart';
import 'package:provider/provider.dart';

class DisplayScore extends StatefulWidget {
  const DisplayScore({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DisplayScoreState createState() => _DisplayScoreState();
}

class _DisplayScoreState extends State<DisplayScore> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: ScoreCategory.values.map((category) {
          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(category.name),
                Consumer<DataModel>(
                  builder: (context, data, _) {
                    return ListenableBuilder(
                      listenable: data.score,
                      builder: (BuildContext context, Widget? child) {
                        return Row(
                          children: [
                            TextButton(
                              onPressed: data.score[category] == null
                                  ? () {
                                      setState(() {
                                        data.score.registerScore(
                                            category, data.dice.values);
                                        data.dice.rollCount = 3;
                                        data.isRollButtonPressed = false;
                                      });
                                      data.dice.clear();
                                    }
                                  : null,
                              child: Text(
                                data.score[category] == null ? 'Pick me' : '',
                              ),
                            ),
                            if (data.score[category] != null)
                              Text("${data.score[category]}"),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
