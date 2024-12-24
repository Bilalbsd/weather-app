import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/question.dart';
import 'quiz_state.dart';
import 'quiz_event.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final List<Question> _questions = [
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

  final List<String> _images = [
    'assets/images/revolution_francaise.jpg',
    'assets/images/napoleon.jpg',
    'assets/images/bataille_verdun.jpg',
    'assets/images/prise_bastille.jpg',
    'assets/images/jeanne_darc.jpg',
  ];

  QuizBloc() : super(QuizInitial()) {
    on<StartQuiz>(_onStartQuiz);
    on<SubmitAnswer>(_onSubmitAnswer);
    on<ResetQuiz>(_onResetQuiz);
    on<PreviousQuestion>(_onPreviousQuestion);
    on<NextQuestion>(_onNextQuestion);
  }

  void _onStartQuiz(StartQuiz event, Emitter<QuizState> emit) {
    emit(QuizInProgress(
      currentQuestionIndex: 0,
      score: 0,
      questions: _questions,
      images: _images,
      answeredQuestions: List.generate(_questions.length, (_) => false),
    ));
  }

  void _onSubmitAnswer(SubmitAnswer event, Emitter<QuizState> emit) {
    if (state is QuizInProgress) {
      final currentState = state as QuizInProgress;
      final currentIndex = currentState.currentQuestionIndex;

      if (!currentState.answeredQuestions[currentIndex]) {
        final isCorrect =
            _questions[currentIndex].isCorrect == event.userAnswer;
        final newScore =
            isCorrect ? currentState.score + 1 : currentState.score;

        final updatedAnsweredQuestions =
            List<bool>.from(currentState.answeredQuestions)
              ..[currentIndex] = true;

        // Si c'est la dernière question et qu'elle est répondue, terminer le quiz
        if (currentIndex == _questions.length - 1) {
          emit(QuizCompleted(
            score: newScore,
            totalQuestions: _questions.length,
          ));
        } else {
          emit(QuizInProgress(
            currentQuestionIndex: currentIndex,
            score: newScore,
            questions: currentState.questions,
            images: currentState.images,
            answeredQuestions: updatedAnsweredQuestions,
          ));
        }
      }
    }
  }

  void _onPreviousQuestion(PreviousQuestion event, Emitter<QuizState> emit) {
    if (state is QuizInProgress) {
      final currentState = state as QuizInProgress;
      if (currentState.currentQuestionIndex > 0) {
        emit(QuizInProgress(
          currentQuestionIndex: currentState.currentQuestionIndex - 1,
          score: currentState.score,
          questions: currentState.questions,
          images: currentState.images,
          answeredQuestions: currentState.answeredQuestions,
        ));
      }
    }
  }

  void _onNextQuestion(NextQuestion event, Emitter<QuizState> emit) {
    if (state is QuizInProgress) {
      final currentState = state as QuizInProgress;
      if (currentState.currentQuestionIndex <
          currentState.questions.length - 1) {
        emit(QuizInProgress(
          currentQuestionIndex: currentState.currentQuestionIndex + 1,
          score: currentState.score,
          questions: currentState.questions,
          images: currentState.images,
          answeredQuestions: currentState.answeredQuestions,
        ));
      } else {
        // Terminer le quiz si on est à la dernière question
        emit(QuizCompleted(
          score: currentState.score,
          totalQuestions: currentState.questions.length,
        ));
      }
    }
  }

  void _onResetQuiz(ResetQuiz event, Emitter<QuizState> emit) {
    emit(QuizInitial());
  }
}
