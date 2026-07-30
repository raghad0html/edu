import 'dart:async';
import 'package:flutter/material.dart';

import '../../core/services/questions.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  int? selectedOption;
  bool answered = false;
  int score = 0;

  bool used5050 = false;
  bool usedSkip = false;
  List<int> removedOptions = [];

  int timeLeft = 15;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer?.cancel();
    timeLeft = 15;
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        timeLeft--;
        if (timeLeft == 0) {
          t.cancel();
          nextQuestion();
        }
      });
    });
  }

  void nextQuestion() {
    setState(() {
      answered = false;
      selectedOption = null;
      removedOptions = [];
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        startTimer();
      } else {
        timer?.cancel();
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Quiz Completed!"),
            content: Text("Your score: $score / ${questions.length}"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    currentQuestionIndex = 0;
                    score = 0;
                    used5050 = false;
                    usedSkip = false;
                    selectedOption = null;
                    answered = false;
                    removedOptions = [];
                    startTimer();
                  });
                },
                child: const Text("Restart"),
              ),
            ],
          ),
        );
      }
    });
  }

  void checkAnswer(int index) {
    if (answered) return;
    setState(() {
      selectedOption = index;
      answered = true;
      if (index == questions[currentQuestionIndex].correctIndex) {
        score++;
      }
    });

    Future.delayed(const Duration(seconds: 1), () {
      nextQuestion();
    });
  }

  void apply5050() {
    if (used5050 || answered) return;
    final correct = questions[currentQuestionIndex].correctIndex;
    final options = [0, 1, 2, 3];
    options.remove(correct);
    options.shuffle();
    setState(() {
      removedOptions = options.sublist(0, 2);
      used5050 = true;
    });
  }

  void skipQuestion() {
    if (usedSkip || answered) return;
    setState(() {
      usedSkip = true;
    });
    nextQuestion();
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestionIndex];
    return Scaffold(
      backgroundColor: const Color(0xFF0B2545),
      appBar: AppBar(
        title: const Text('Telecom Quiz'),
        backgroundColor: const Color(0xFF133B5C),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Score: $score",
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              "Time left: $timeLeft s",
              style: const TextStyle(color: Colors.orange, fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              "Q${currentQuestionIndex + 1}: ${question.questionText}",
              style: const TextStyle(fontSize: 22, color: Colors.white),
            ),
            const SizedBox(height: 20),
            ...List.generate(question.options.length, (index) {
              if (removedOptions.contains(index))
                return const SizedBox.shrink();

              Color bgColor = Colors.white;
              if (answered) {
                if (index == question.correctIndex) {
                  bgColor = Colors.green;
                } else if (index == selectedOption) {
                  bgColor = Colors.red;
                }
              }

              return GestureDetector(
                onTap: () => checkAnswer(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    question.options[index],
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              );
            }),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: used5050 ? null : apply5050,
                  icon: const Icon(Icons.cancel_presentation),
                  label: const Text("50:50"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: used5050 ? Colors.grey : Colors.blue,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: usedSkip ? null : skipQuestion,
                  icon: const Icon(Icons.skip_next),
                  label: const Text("Skip"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: usedSkip ? Colors.grey : Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
