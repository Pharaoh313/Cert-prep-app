import 'package:flutter/material.dart';
import 'exam_screen.dart';
import 'debug_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cert Prep")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
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
            const SizedBox(height: 20),
            OutlinedButton.icon(
              icon: const Icon(Icons.bug_report),
              label: const Text("Debug Dashboard"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DebugScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}