import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

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
        icons.add(Icon(Icons.check, color: Colors.green));
        quizBrain.addOneToTheScore();
      } else {
        icons.add(Icon(Icons.close, color: Colors.red));
      }

      if (quizBrain.lastQuestion()) {
        Alert(
          context: context,
          type: AlertType.success,
          title: "Quiz Completed",
          desc: "Your score: ${quizBrain.scoreGetter()} out of ${quizBrain.questionLengthGetter()}",
          buttons: [
            DialogButton(
              child: Text("Restart", style: TextStyle(color: Colors.white, fontSize: 20)),
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  quizBrain.reset();
                  icons.clear();
                });
              },
            ),
          ],
        ).show();
      } else {
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                'Question ${quizBrain.questionNumberGetter + 1}:',
                style: TextStyle(fontSize: 20, color: Colors.grey.shade400),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Center(
              child: Text(
                quizBrain.questionTextGetter(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0, color: Colors.white),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: ListView.builder(
              itemCount: quizBrain.optionsGetter().length,
              itemBuilder: (context, index) {
                String option = quizBrain.optionsGetter()[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Colors.blueAccent,
                    child: InkWell(
                      onTap: () => checkAnswer(option),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: Text(
                            option,
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Row(children: icons),
        ],
      ),
    );
  }
}
