import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';

class QuizProvidersPage extends StatelessWidget {
  const QuizProvidersPage({super.key, required this.title});
  final String title;

  void _showFinalScoreDialog(BuildContext context, QuizProvider quizProvider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Le Quiz est terminé !'),
        content: Text(
            'Score final: ${quizProvider.score}/${quizProvider.questions.length}'),
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
              quizProvider.resetQuiz();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuizProvider(),
      child: Consumer<QuizProvider>(
        builder: (context, quizProvider, child) {
          final bool isAnswered =
              quizProvider.answeredQuestions[quizProvider.currentQuestionIndex];

          // Show final score dialog when the last question is answered
          if (quizProvider.isQuizFinished && isAnswered) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _showFinalScoreDialog(context, quizProvider);
            });
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(title),
              backgroundColor: Colors.blue,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    quizProvider.currentImage,
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
                      quizProvider.currentQuestion.questionText,
                      style:
                          const TextStyle(fontSize: 20, color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: quizProvider.goToPreviousQuestion,
                        icon: const Icon(Icons.arrow_left),
                        color: Colors.blueAccent,
                        iconSize: 36,
                      ),
                      ElevatedButton(
                        onPressed: isAnswered
                            ? null
                            : () => quizProvider.checkAnswer(true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isAnswered ? Colors.grey : Colors.blueAccent,
                        ),
                        child: const Text('VRAI'),
                      ),
                      ElevatedButton(
                        onPressed: isAnswered
                            ? null
                            : () => quizProvider.checkAnswer(false),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isAnswered ? Colors.grey : Colors.blueAccent,
                        ),
                        child: const Text('FAUX'),
                      ),
                      IconButton(
                        onPressed: quizProvider.goToNextQuestion,
                        icon: const Icon(Icons.arrow_right),
                        color: Colors.blueAccent,
                        iconSize: 36,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
