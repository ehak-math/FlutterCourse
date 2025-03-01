import 'package:flutter/material.dart';
import '../widgets/bla_button.dart';

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
              label: "Contact Volodia",
              isPrimary: false,
              icon: Icons.contact_support_outlined,
              onPressed: (){},
            ),
            const SizedBox(height: 15),
            BlaButton(
              label: "Request to book",
              icon: Icons.calendar_month_outlined,
              onPressed: (){},
            ),
          ],
        ),
      ),
    );
  }
}
