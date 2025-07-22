import 'question.dart';

class MockData {
  static List<Question> getSampleQuestions() {
    return [
      Question(
        id: 'mock_1',
        text: 'What is the AWS service used for object storage?',
        options: [
          'Amazon EC2',
          'Amazon S3',
          'Amazon RDS',
          'Amazon Lambda'
        ],
        correctAnswers: [1],
      ),
      Question(
        id: 'mock_2',
        text: 'Which AWS service provides serverless computing?',
        options: [
          'Amazon EC2',
          'Amazon ECS',
          'AWS Lambda',
          'Amazon EKS'
        ],
        correctAnswers: [2],
      ),
      Question(
        id: 'mock_3',
        text: 'What does AWS IAM stand for?',
        options: [
          'Identity and Access Management',
          'Infrastructure as a Service',
          'Internet Application Manager',
          'Integrated API Management'
        ],
        correctAnswers: [0],
      ),
      Question(
        id: 'mock_4',
        text: 'Which of the following are AWS compute services? (Select all that apply)',
        options: [
          'Amazon EC2',
          'Amazon S3',
          'AWS Lambda',
          'Amazon ECS'
        ],
        correctAnswers: [0, 2, 3],
      ),
      Question(
        id: 'mock_5',
        text: 'What is the main benefit of using AWS CloudFormation?',
        options: [
          'Infrastructure as Code',
          'Data analytics',
          'Content delivery',
          'Database management'
        ],
        correctAnswers: [0],
      ),
    ];
  }
}