import 'package:flutter/material.dart';
import 'quiz_app.dart';
import 'model/quiz.dart';

void main() {

  Question q1 = const Question(
      title: "What are the colors of Cambodia's flag?",
      possibleAnswers: ["Red, blue", "Yellow, green", 'Black, blue'],
      goodChoice: 'Red, blue');
  Question q2 = const Question(
      title: "How many provinces does Cambodia have?",
      possibleAnswers: ["20", "25", '24'],
      goodChoice: '25');
  Question q3 = const Question(
      title: "What is the capital city of Cambodia?",
      possibleAnswers: ["Phnom Penh", "Siem Reap", 'Bangkok'],
      goodChoice: 'Phnom Penh');
  Question q4 = const Question(
      title: "What is Cambodia's currrency?",
      possibleAnswers: ["Bhat", "Dollar", 'Riel'],
      goodChoice: 'Riel');
      
      

  List<Question> myQuestions = [q1, q2, q3, q4];
  Quiz myQuiz = Quiz(title: "Crazy Quizz", questions: myQuestions);

  runApp(QuizApp(myQuiz));
}




// import 'model/Submissoin.dart';
// import 'model/quiz.dart';

// void main() {
//   // Create some questions
//   Question q1 = const Question(
//     title: "What is 2 + 2?",
//     goodChoice: "4",
//     possibleAnswers: ["3", "4", "5", "6"],
//   );
//   Question q2 = const Question(
//     title: "What is the capital of France?",
//     goodChoice: "Paris",
//     possibleAnswers: ["Berlin", "Madrid", "Paris", "Rome"],
//   );

//   // Create a submission
//   Submission submission = Submission();

//   // Add answers to the submission
//   submission.addAnswer(Answer(userChoice: "4", question: q1));
//   submission.addAnswer(Answer(userChoice: "Paris", question: q2));

//   // Calculate score
//   print("Score: ${submission.getScore()}"); // Should print "Score: 1"

//   // Get answer for a question
//   Answer? userAnswer = submission.getAnswerFor(q1);
//   Answer? userAnswer1 = submission.getAnswerFor(q2);

//   print("Answer for '${q1.title}': ${userAnswer?.userChoice}");
//   print("Answer for '${q1.title}': ${userAnswer1?.userChoice}");

// }

