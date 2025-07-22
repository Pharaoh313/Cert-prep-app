import 'dart:async';
import 'package:flutter/material.dart';
import '../models/screens/question.dart';
import '../services/api_services.dart';

class ExamScreen extends StatefulWidget {
  final String certId;
  const ExamScreen({super.key, required this.certId});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  late Future<List<Question>> questionsFuture;
  late Timer countdownTimer;
  int remainingSeconds = 5400; // 90 minutes

  @override
  void initState() {
    super.initState();
    questionsFuture = ApiService.fetchQuestions(widget.certId);
    startCountdown();
  }

  void startCountdown() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds == 0) {
        timer.cancel();
        _handleAutoSubmit();
      } else {
        setState(() => remainingSeconds--);
      }
    });
  }

  String formatTime(int seconds) {
    final mins = seconds ~/ 60;
    final secs = seconds % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  void _handleAutoSubmit() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Time's up!"),
        content: const Text("Your exam time is over. Submitting your answers."),
        actions: [
          TextButton(
            onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    countdownTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.certId.toUpperCase()} Exam'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Center(
              child: Text(
                formatTime(remainingSeconds),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
      body: FutureBuilder<List<Question>>(
        future: questionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 12),
                  Text("Fetching questions from AWS..."),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final questions = snapshot.data!;
          return ListView.builder(
            itemCount: questions.length,
            itemBuilder: (_, i) {
              final q = questions[i];
              return ListTile(
                title: Text(q.text),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(q.options.length, (j) {
                    return Text('${String.fromCharCode(65 + j)}. ${q.options[j]}');
                  }),
                ),
              );
            },
          );
        },
      ),
    );
  }
}