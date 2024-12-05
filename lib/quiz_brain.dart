import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;
  int _score = 0;
  bool _lastQuestion = false;

  final List<Question> _questionBank = [
    Question(
      'What are the main building blocks of Flutter UIs?',
      ['Widgets', 'Components', 'Blocks', 'Functions'],
      'Widgets', // Respuesta correcta
    ),
    Question(
      'How are Flutter UIs built?',
      ['By combining widgets in code', 'By combining widgets in a visual editor', 'By defining widgets in config files', 'By using XCode for iOS and Android Studio for Android'],
      'By combining widgets in code',
    ),
    Question(
      'What\'s the purpose of a StatefulWidget?',
      ['Update UI as data changes', 'Update data as UI changes', 'Ignore data changes', 'Render UI that does not depend on data'],
      'Update UI as data changes',
    ),
    Question(
      'Which widget should you try to use more often: StatelessWidget or StatefulWidget?',
      ['StatelessWidget', 'StatefulWidget', 'Both are equally good', 'None of the above'],
      'StatelessWidget',
    ),
    Question(
      'What happens if you change data in a StatelessWidget?',
      ['The UI is not updated', 'The UI is updated', 'The closest StatefulWidget is updated', 'Any nested StatefulWidgets are updated'],
      'The UI is not updated',
    ),
    Question(
      'How should you update data inside of StatefulWidgets?',
      ['By calling setState()', 'By calling updateData()', 'By calling updateUI()', 'By calling updateState()'],
      'By calling setState()',
    ),
  ];

  void addOneToTheScore() {
    _score++;
  }

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  void reset() {
    _lastQuestion = false;
    _score = 0;
    _questionNumber = 0;
  }

  bool lastQuestion() {
    if (_questionNumber == _questionBank.length - 1) {
      _lastQuestion = true;
    }
    return _lastQuestion;
  }

  int scoreGetter() => _score;

  // Obtiene el texto de la pregunta actual
  String questionTextGetter() => _questionBank[_questionNumber].questionText;

  // Obtiene la respuesta correcta (como un String)
  String correctAnswerGetter() => _questionBank[_questionNumber].correctAnswer;

  // Obtiene las opciones de la pregunta actual
  List<String> optionsGetter() => _questionBank[_questionNumber].options;

  int questionLengthGetter() => _questionBank.length;
}
