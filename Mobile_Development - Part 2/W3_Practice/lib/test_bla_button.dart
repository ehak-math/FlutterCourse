import 'package:flutter/material.dart';
import 'widgets/bla_button.dart';

void main() {
  runApp(const MaterialApp(
    home: TestBlaButtonScreen(),
  ));
}
class TestBlaButtonScreen extends StatelessWidget {
  const TestBlaButtonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Test BlaButton")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BlaButton(
              text: "Contact Volodia",
              type: BlaButtonType.secondary,
              icon: Icons.contact_support_outlined,
              onPressed: (){},
            ),
            const SizedBox(height: 15),
            BlaButton(
              text: "Request to book",
              icon: Icons.calendar_month_outlined,
              onPressed: (){},
            ),
          ],
        ),
      ),
    );
  }
}
