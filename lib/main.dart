import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
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
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> icons = [];

  void checkAnswer(String selectedAnswer) {
    String correctAnswer = quizBrain.correctAnswerGetter();

    setState(() {
      if (selectedAnswer == correctAnswer) {
        icons.add(Icon(
          Icons.check,
          color: Colors.green,
        ));
        quizBrain.addOneToTheScore();
      } else {
        icons.add(Icon(
          Icons.close,
          color: Colors.red,
        ));
      }

      if (quizBrain.lastQuestion()) {
        Alert(
          context: context,
          type: AlertType.none,
          title: "Well Done",
          desc: "Your score is: ${quizBrain.scoreGetter()} out of ${quizBrain.questionLengthGetter()}.",
          buttons: [
            DialogButton(
              child: Text(
                "Start Again",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  quizBrain.reset();
                  icons.clear();
                });
              },
              width: 120,
            )
          ],
        ).show();
      } else {
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.questionTextGetter(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        // Generar botones dinámicos
        ...quizBrain.optionsGetter().map((option) {
          return Expanded(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: Text(
                  option,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () {
                  checkAnswer(option);
                },
              ),
            ),
          );
        }).toList(),
        Row(
          children: icons,
        ),
      ],
    );
  }
}
