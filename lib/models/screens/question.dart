class Question {
  final String id;
  final String text;
  final List<String> options;
  final List<int> correctAnswers;

  Question({
    required this.id,
    required this.text,
    required this.options,
    required this.correctAnswers,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['questionId'],
      text: json['text'],
      options: List<String>.from(json['options']),
      correctAnswers: List<int>.from(json['correctAnswers']),
    );
  }
}