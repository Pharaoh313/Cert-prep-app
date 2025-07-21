import 'package:flutter/material.dart';
import 'exam_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cert Prep")),
      body: Center(
        child: ElevatedButton(
          child: const Text("Start AWS Cloud Practitioner Exam"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ExamScreen(certId: 'aws_cp'),
              ),
            );
          },
        ),
      ),
    );
  }
}