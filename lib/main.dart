import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  // Enable better error handling for web
  if (kIsWeb) {
    // Handle web-specific initialization
    FlutterError.onError = (FlutterErrorDetails details) {
      print('Flutter Error: ${details.exception}');
      print('Stack Trace: ${details.stack}');
    };
  }
  
  runApp(const CertPrepApp());
}

class CertPrepApp extends StatelessWidget {
  const CertPrepApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cert Prep',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      // Add error handling for web
      builder: (context, child) {
        ErrorWidget.builder = (FlutterErrorDetails details) {
          if (kIsWeb) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    const Text(
                      'Something went wrong',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text('Please refresh the page'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Reload the page on web
                        if (kIsWeb) {
                          // This will be handled by the browser
                        }
                      },
                      child: const Text('Reload'),
                    ),
                  ],
                ),
              ),
            );
          }
          return ErrorWidget(details.exception);
        };
        return child!;
      },
    );
  }
}