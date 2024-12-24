import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp2_flutter_bilalb/bloc/quiz_bloc.dart';
import 'package:tp2_flutter_bilalb/bloc/quiz_event.dart';
import 'package:tp2_flutter_bilalb/bloc/quiz_state.dart';

class QuizBlocPage extends StatelessWidget {
  const QuizBlocPage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QuizBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          backgroundColor: Colors.blue,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: BlocListener<QuizBloc, QuizState>(
          listener: (context, state) {
            if (state is QuizCompleted) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => AlertDialog(
                  title: const Text('Le Quiz est terminé !'),
                  content: Text(
                      'Score final: ${state.score}/${state.totalQuestions}'),
                  actions: [
                    TextButton(
                      child: const Text('Retour à l\'accueil'),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                      child: const Text('Recommencer'),
                      onPressed: () {
                        Navigator.pop(context);
                        context.read<QuizBloc>().add(ResetQuiz());
                      },
                    ),
                  ],
                ),
              );
            }
          },
          child: BlocBuilder<QuizBloc, QuizState>(
            builder: (context, state) {
              if (state is QuizInitial) {
                return _buildInitialState(context);
              } else if (state is QuizInProgress) {
                return _buildInProgressState(context, state);
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildInitialState(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          context.read<QuizBloc>().add(StartQuiz());
        },
        child: const Text('Commencer le Quiz'),
      ),
    );
  }

  Widget _buildInProgressState(BuildContext context, QuizInProgress state) {
    final question = state.questions[state.currentQuestionIndex];
    final imagePath = state.images[state.currentQuestionIndex];
    final isAnswered = state.answeredQuestions[state.currentQuestionIndex];

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            imagePath,
            height: 300,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              question.questionText,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: state.currentQuestionIndex > 0
                    ? () => context.read<QuizBloc>().add(PreviousQuestion())
                    : null,
                icon: const Icon(Icons.arrow_left),
                color: Colors.blueAccent,
                iconSize: 36,
              ),
              ElevatedButton(
                onPressed: isAnswered
                    ? null
                    : () {
                        context
                            .read<QuizBloc>()
                            .add(SubmitAnswer(true, userAnswer: true));
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isAnswered ? Colors.grey : Colors.blueAccent,
                ),
                child: const Text('VRAI'),
              ),
              ElevatedButton(
                onPressed: isAnswered
                    ? null
                    : () {
                        context
                            .read<QuizBloc>()
                            .add(SubmitAnswer(false, userAnswer: false));
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isAnswered ? Colors.grey : Colors.blueAccent,
                ),
                child: const Text('FAUX'),
              ),
              IconButton(
                onPressed:
                    state.currentQuestionIndex < state.questions.length - 1
                        ? () => context.read<QuizBloc>().add(NextQuestion())
                        : null,
                icon: const Icon(Icons.arrow_right),
                color: Colors.blueAccent,
                iconSize: 36,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
