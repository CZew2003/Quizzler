import 'package:flutter/material.dart';
import 'quizEngine.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'iconManager.dart';

QuizEngine quizEngine = QuizEngine();
IconManager iconManager = IconManager();

void main() {
  runApp(const Quizzler());
}

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  void guess(bool myGuess) {
    if (quizEngine.getQuestionAnswer() == myGuess) {
      correctAnswer();
    } else {
      wrongAnswer();
    }
  }

  void checkIfFinished() {
    if (quizEngine.quizFinished()) {
      Alert(
              context: context,
              title: "Quiz Ended!",
              desc: "${iconManager.getPercentage()}%")
          .show();
      quizEngine.resetQuiz();
      iconManager.resetIcon();
    }
  }

  void correctAnswer() {
    setState(() {
      quizEngine.getNextIndex();
      iconManager.addRightAnswer();
      checkIfFinished();
    });
  }

  void wrongAnswer() {
    setState(() {
      quizEngine.getNextIndex();
      iconManager.addWrongAnswer();
      checkIfFinished();
    });
  }

  Expanded buttonApp(
      {Color? color,
      String? message,
      required void Function(bool) function,
      required bool guess}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(color ?? Colors.white),
          ),
          onPressed: () {
            function(guess);
          },
          child: Center(
            child: Text(
              message ?? "Default",
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Expanded questionText({String? message}) {
    return Expanded(
      flex: 5,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Text(
            textAlign: TextAlign.center,
            message ?? 'There is no question left so sorry :(((',
            style: const TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        questionText(
          message: quizEngine.getQuestionText(),
        ),
        buttonApp(
          color: Colors.green,
          message: 'True',
          function: guess,
          guess: true,
        ),
        buttonApp(
            color: Colors.red, message: 'False', function: guess, guess: false),
        Row(
          children: iconManager.getIcons(),
        ),
      ],
    );
  }
}
