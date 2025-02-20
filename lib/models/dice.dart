import 'package:collection/collection.dart';
import 'dart:math';

import 'package:flutter/material.dart';

class Dice with ChangeNotifier {
  final List<int?> _values;
  final List<bool> _held;
  int rollCount = 3;
  bool _shouldNotify = false;

  Dice(int numDice)
      : _values = List<int?>.filled(numDice, null),
        _held = List<bool>.filled(numDice, false);

  List<int> get values => List<int>.unmodifiable(_values.whereNotNull());

  int? operator [](int index) => _values[index];

  bool isHeld(int index) => _held[index];

  void clear() {
    for (var i = 0; i < _values.length; i++) {
      _values[i] = null;
      _held[i] = false;
    }
    notifyListeners();
  }

  void roll() {
    for (var i = 0; i < _values.length; i++) {
      if (!_held[i]) {
        _values[i] = Random().nextInt(6) + 1;
      }
    }
     if (_shouldNotify) {
      notifyListeners();
    } else {
      _shouldNotify = true;
    }
  }

  void toggleHold(int index) {
    _held[index] = !_held[index];
  }
}
