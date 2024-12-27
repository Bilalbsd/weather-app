import 'package:flutter/foundation.dart';
import '../models/question.dart';

class QuizProvider with ChangeNotifier {
  int _currentQuestionIndex = 0;
  int _score = 0;
  List<bool> _answeredQuestions = [];

  final List<Question> questions = [
    Question(
      questionText: "La Révolution française a commencé en 1789.",
      isCorrect: true,
    ),
    Question(
      questionText: "Napoléon Bonaparte est devenu empereur en 1804.",
      isCorrect: true,
    ),
    Question(
      questionText:
          "La bataille de Verdun a eu lieu pendant la Seconde Guerre mondiale.",
      isCorrect: false,
    ),
    Question(
      questionText: "La prise de la Bastille a marqué la fin du Moyen Âge.",
      isCorrect: false,
    ),
    Question(
      questionText: "Jeanne d'Arc a libéré Orléans en 1429.",
      isCorrect: true,
    ),
  ];

  final List<String> images = [
    'assets/images/revolution_francaise.jpg',
    'assets/images/napoleon.jpg',
    'assets/images/bataille_verdun.jpg',
    'assets/images/prise_bastille.jpg',
    'assets/images/jeanne_darc.jpg',
  ];

  QuizProvider() {
    _answeredQuestions = List.generate(questions.length, (index) => false);
  }

  // Getters
  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;
  List<bool> get answeredQuestions => _answeredQuestions;
  Question get currentQuestion => questions[_currentQuestionIndex];
  String get currentImage => images[_currentQuestionIndex];

  // Methods
  void checkAnswer(bool userChoice) {
    if (!_answeredQuestions[_currentQuestionIndex]) {
      final isCorrect =
          questions[_currentQuestionIndex].isCorrect == userChoice;
      _answeredQuestions[_currentQuestionIndex] = true;
      if (isCorrect) _score++;

      if (_currentQuestionIndex < questions.length - 1) {
        _currentQuestionIndex++;
      }

      notifyListeners();
    }
  }

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _score = 0;
    _answeredQuestions = List.generate(questions.length, (index) => false);
    notifyListeners();
  }

  void goToPreviousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      notifyListeners();
    }
  }

  void goToNextQuestion() {
    if (_currentQuestionIndex < questions.length - 1) {
      _currentQuestionIndex++;
      notifyListeners();
    }
  }

  bool get isQuizFinished => _currentQuestionIndex >= questions.length - 1;
}
