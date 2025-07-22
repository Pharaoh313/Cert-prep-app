import 'package:flutter/material.dart';
import '../services/api_services.dart';

class DebugScreen extends StatefulWidget {
  const DebugScreen({super.key});

  @override
  State<DebugScreen> createState() => _DebugScreenState();
}

class _DebugScreenState extends State<DebugScreen> {
  String _connectionStatus = 'Not tested';
  String _apiTestResult = 'Not tested';
  bool _testing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug Dashboard'),
        backgroundColor: Colors.red.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Deployment Status',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text('App Version: 1.0.0+1'),
                    Text('Build Mode: ${_getBuildMode()}'),
                    Text('Platform: Web'),
                    Text('Current URL: ${Uri.base}'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'API Connectivity',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text('AWS API Gateway: https://t18q1ugo32.execute-api.us-east-1.amazonaws.com/prod'),
                    const SizedBox(height: 4),
                    Text('Backend: AWS Lambda Functions'),
                    Text('Region: us-east-1'),
                    Text('Service: API Gateway + Lambda'),
                    const SizedBox(height: 8),
                    Text('Connection Status: $_connectionStatus'),
                    Text('API Test Result: $_apiTestResult'),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: _testing ? null : _testConnection,
                          child: _testing 
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Text('Test Connection'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: _testing ? null : _testApi,
                          child: const Text('Test API'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Common Issues & Solutions',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    const Text('• API 404: Backend Lambda not deployed'),
                    const Text('• API 403: CORS not configured properly'),
                    const Text('• Timeout: Network connectivity issues'),
                    const Text('• Build fails: Missing dependencies'),
                    const Text('• Deploy fails: AWS credentials not set'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getBuildMode() {
    bool isDebug = false;
    assert(isDebug = true);
    return isDebug ? 'Debug' : 'Release';
  }

  Future<void> _testConnection() async {
    setState(() {
      _testing = true;
      _connectionStatus = 'Testing...';
    });

    try {
      final isConnected = await ApiService.testConnection();
      setState(() {
        _connectionStatus = isConnected ? 'Connected ✅' : 'Failed ❌';
      });
    } catch (e) {
      setState(() {
        _connectionStatus = 'Error: $e';
      });
    } finally {
      setState(() {
        _testing = false;
      });
    }
  }

  Future<void> _testApi() async {
    setState(() {
      _testing = true;
      _apiTestResult = 'Testing...';
    });

    try {
      final questions = await ApiService.fetchQuestions('aws_cp');
      setState(() {
        _apiTestResult = 'Success: ${questions.length} questions loaded ✅';
      });
    } catch (e) {
      setState(() {
        _apiTestResult = 'Error: $e';
      });
    } finally {
      setState(() {
        _testing = false;
      });
    }
  }
}