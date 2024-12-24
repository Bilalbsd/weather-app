abstract class QuizEvent {}

class StartQuiz extends QuizEvent {}

class SubmitAnswer extends QuizEvent {
  final bool userAnswer;

  SubmitAnswer(bool bool, {required this.userAnswer});
}

class ResetQuiz extends QuizEvent {}

// New events for navigation
class PreviousQuestion extends QuizEvent {}

class NextQuestion extends QuizEvent {}
