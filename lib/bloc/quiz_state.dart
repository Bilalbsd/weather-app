import '../models/question.dart';

abstract class QuizState {}

class QuizInitial extends QuizState {}

class QuizInProgress extends QuizState {
  final int currentQuestionIndex;
  final int score;
  final List<Question> questions;
  final List<String> images;
  final List<bool> answeredQuestions;

  QuizInProgress({
    required this.currentQuestionIndex,
    required this.score,
    required this.questions,
    required this.images,
    required this.answeredQuestions,
  });
}

class QuizCompleted extends QuizState {
  final int score;
  final int totalQuestions;

  QuizCompleted({required this.score, required this.totalQuestions});
}
