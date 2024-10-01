import 'package:flutter/material.dart';
import '../models/question.dart';
import '../widgets/quiz_button.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question> questionBank = [
    Question(
      'Thủ đô của Pháp là gì?',
      ['Berlin', 'Madrid', 'Paris', 'Rome'],
      2,
    ),
    Question(
      'Hành tinh nào được gọi là Hành tinh Đỏ?',
      ['Trái Đất', 'Sao Hỏa', 'Sao Mộc', 'Sao Thổ'],
      1,
    ),
    Question(
      'Ai đã viết "Hamlet"?',
      ['Leo Tolstoy', 'Mark Twain', 'William Shakespeare', 'Charles Dickens'],
      2,
    ),
    Question(
      'Quả táo màu gì?',
      ['Đỏ', 'Xanh', 'Vàng', 'Hồng'],
      0,
    ),
    Question(
      'Công nghệ thông tin viết tắt là gì?',
      ['CNTT', 'KHMT', 'KTM', 'KTMT'],
      0,
    ),
    Question(
      'Con chó tiếng anh là gi?',
      ['Cat', 'Pub', 'Dog', 'Neko'],
      2,
    ),
    Question(
      'Cây đào màu gì?',
      ['Xanh', 'Đỏ', 'Vàng', 'Hồng'],
      3,
    ),
    Question(
      'Đồng phục thể dục màu gi?',
      ['Xanh', 'Đỏ', 'Vàng', 'Hồng'],
      0,
    ),
    Question(
      'Black là gì?',
      ['Xanh', 'Đỏ', 'Đen', 'Hồng'],
      2,
    ),
    Question(
      'Bạn là ai?',
      ['Con người', 'AI', 'Robot', 'Alian'],
      0,
    ),
    // Thêm nhiều câu hỏi khác tại đây nếu cần
  ];

  List<Question> shuffledQuestions = [];
  int questionIndex = 0;
  int score = 0;
  int point = 0;
  bool quizFinished = false;
  List<Icon> scoreKeeper = [];

  @override
  void initState() {
    super.initState();
    resetQuiz();
  }

  void resetQuiz() {
    setState(() {
      shuffledQuestions = [...questionBank]..shuffle();
      for (var question in shuffledQuestions) {
        String correctAnswer = question.options[question.correctAnswerIndex]; // Lưu lại đáp án đúng trước khi xáo trộn

        question.options.shuffle(); // Xáo trộn các đáp án

        // Tìm vị trí mới của đáp án đúng sau khi xáo trộn
        question.correctAnswerIndex = question.options.indexOf(correctAnswer);
      }
      shuffledQuestions.shuffle(); // Xáo trộn danh sách câu hỏi
      questionIndex = 0;
      score = 0;
      point = 0;
      quizFinished = false;
      scoreKeeper = [];
    });
  }

  void checkAnswer(int userPickedAnswer) {
    int correctAnswerIndex = shuffledQuestions[questionIndex].correctAnswerIndex;

    setState(() {
      if (userPickedAnswer == correctAnswerIndex) {
        scoreKeeper.add(Icon(Icons.check, color: Colors.green));
        score++;
        point += 10;
      } else {
        scoreKeeper.add(Icon(Icons.close, color: Colors.red));
      }
      
      if (questionIndex < shuffledQuestions.length - 1) {
        questionIndex++;
      } else {
        quizFinished = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('Quizzler'),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: SafeArea(
        child: quizFinished
            ? Padding(
              padding: const EdgeInsets.only(left: 100.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Quiz két thúc!',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Số câu đúng: $score/${shuffledQuestions.length}',
                      style: const TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Điểm của bạn: $point/100',
                      style: const TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: resetQuiz,
                      child: Text('Restart Quiz'),
                    ),
                  ],
                ),
            )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Center(
                      child: Text(
                        shuffledQuestions[questionIndex].questionText,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 25.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  ...shuffledQuestions[questionIndex].options.asMap().entries.map((entry) {
                    int idx = entry.key;
                    String option = entry.value;
                    return Expanded(
                      child: QuizButton(
                        buttonColor: Colors.blueAccent,
                        buttonText: option,
                        onPressed: () => checkAnswer(idx),
                      ),
                    );
                  }).toList(),
                  Row(
                    children: scoreKeeper,
                  ),
                ],
              ),
      ),
    );
  }
}
