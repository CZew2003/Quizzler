import 'package:flutter/material.dart';

class IconManager {
  List<Icon> _icons = [];

  int _rightAnswers = 0, _wrongAnswers = 0;

  void addRightAnswer() {
    _rightAnswers++;
    _icons.add(
      const Icon(
        Icons.check,
        color: Colors.green,
      ),
    );
  }

  void addWrongAnswer() {
    _wrongAnswers++;
    _icons.add(
      const Icon(
        Icons.cancel,
        color: Colors.red,
      ),
    );
  }

  void resetIcon() {
    _icons = [];
    _rightAnswers = 0;
    _wrongAnswers = 0;
  }

  List<Icon> getIcons() => _icons;

  int getPercentage() {
    return (_rightAnswers.toDouble() /
            (_rightAnswers + _wrongAnswers).toDouble() *
            100)
        .toInt();
  }
}
