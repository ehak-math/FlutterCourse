import 'package:flutter/material.dart';
import 'package:quiz/model/quiz.dart';

class QuestionScreen extends StatelessWidget {
  final Question question;
  final Function(String) onTap;
  final VoidCallback onSkip;

  const QuestionScreen({
    super.key,
    required this.question,
    required this.onTap,
    required this.onSkip
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(40.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                question.title,
                style: const TextStyle(color: Colors.white, fontSize: 35),
              ),
              const SizedBox(height: 20),
              for (String answer in question.possibleAnswers)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 30,),
                    ElevatedButton(
                      onPressed: () {
                        onTap(answer);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        backgroundColor: const Color(0xff64B5F6),
                        shadowColor: Colors.black
                      ),
                      child: Text(answer, style: const TextStyle(color: Colors.white),),
                    ),
                  ],
                ),
                const SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton.icon(
                      label: const Text("Skip", style: TextStyle(color: Colors.white),),
                      icon: const Icon(Icons.skip_next, color: Colors.white,),
                      iconAlignment: IconAlignment.end,
                      onPressed: onSkip, // Handle skip action
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        backgroundColor: const Color(0xff64B5F6),
                      ),
                    ),
                ],
              )
            ],
          ),

        ),
      );
  }
}
