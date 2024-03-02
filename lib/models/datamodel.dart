
import 'package:flutter/material.dart';
import 'package:mp2/models/dice.dart';
import 'package:mp2/models/scorecard.dart';


class DataModel with ChangeNotifier {
  final Dice _dice = Dice(5);
  final ScoreCard _score = ScoreCard();
  bool isRollButtonPressed = false;

  Dice get dice => _dice;
  ScoreCard get score => _score;
}
