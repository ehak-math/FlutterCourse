import 'package:flutter/material.dart';
import 'package:quiz/model/submissoin.dart';
import 'package:quiz/screens/question_screen.dart';
import 'package:quiz/screens/result_screen.dart';
import 'package:quiz/screens/welcome_screen.dart';
import 'model/quiz.dart';

Color appColor = Colors.blue[500] as Color;

class QuizApp extends StatefulWidget {
  const QuizApp(this.quiz, {super.key});

  final Quiz quiz;

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  String currentScreen = 'welcome'; // 'welcome', 'question', 'result'
  late Quiz quiz;
  late Submission submission;  // To track the answers

  int currentQuestionIndex = 0; // Track the current question index

  @override
  void initState() {
    super.initState();
    quiz = widget.quiz; // Initialize quiz
    submission = Submission();  // Initialize Submission
  }

  // Function to switch screens
  void switchScreen(String screen) {
    setState(() {
      currentScreen = screen;
    });
  }

  // Function to handle when an answer is selected
  void submitAnswer(String answer) {
    // Create an Answer object and add it to the submission
    Answer userAnswer = Answer(
      userChoice: answer,
      question: quiz.questions[currentQuestionIndex],
    );
    submission.addAnswer(userAnswer);

    skipQuestion();
  }

  void skipQuestion() {
    // Move to the next question or show result if the quiz is finished
    if (currentQuestionIndex < quiz.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      // If it's the last question, switch to result screen
      switchScreen('result');
    }
  }

  // Function to restart the quiz
  void restartQuiz() {
    if (submission.getScore() == 0) {
      setState(() {
        currentQuestionIndex = 0;
        submission.removeAnswers();
        switchScreen('welcome');
      });
    }else{
      setState(() {
      currentQuestionIndex = 0;  // Restart the quiz from the first question
      submission.removeAnswers();  // Clear all answers in submission
      switchScreen('question');  // Go back to the question screen
    });
    }
  }


  Widget _builScreen(){
    switch (currentScreen) {
      case 'question':
        return QuestionScreen(
          question: quiz.questions[currentQuestionIndex],
          onTap: (answer) => submitAnswer(answer),
          onSkip: skipQuestion, // Add the skip functionality
        );
      case 'result':
        return ResultScreen(
          submission: submission,
          onRestart: restartQuiz, // Restart callback
          quiz: quiz, // Pass quiz for result display
        );
      default:
        return WelcomeScreen(
          quiz: quiz, 
          onStart: () => switchScreen('question')
        ); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[600],

          title: const Center(child: Text("Quizz", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),)),
        ),
        backgroundColor: appColor,
        body: Center(
          child: _builScreen()
        ),
      ),
    );
  }
}
