import 'package:flutter/material.dart';
 
import '../../models/expense.dart';
import 'expenses_form.dart';
import 'expenses_list.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  Expense? _lastRemovedExpense; // Store the last removed expense
  int? _lastRemovedIndex; // Store the last removed expense's index

  void onExpenseRemoved(Expense expense) {
    _lastRemovedExpense = expense;
    _lastRemovedIndex = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });

    // Clear any existing SnackBars
    ScaffoldMessenger.of(context).clearSnackBars();

    // Show the SnackBar with the undo action
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${expense.title} deleted'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Restore the removed expense
            setState(() {
              _registeredExpenses.insert(_lastRemovedIndex!, _lastRemovedExpense!);
            });
          },
        ),
      ),
    );
  }

  void onExpenseCreated(Expense newExpense) {
    setState(() {
      _registeredExpenses.add(newExpense);
    });
  }
 

  void onAddPressed() {
    showModalBottomSheet(
      sheetAnimationStyle: AnimationStyle(
        duration: const Duration(milliseconds: 1000,),
        reverseDuration: const Duration(milliseconds: 500)
      ),
      context: context,
      isScrollControlled: true,
      builder: (ctx) => ExpenseForm(onCreated: onExpenseCreated,),
    );
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: onAddPressed,
          )
        ],
        backgroundColor: Colors.blue[700],
        title: const Text('Ronan-The-Best Expenses App'),
      ),
      body: ExpensesList(expenses: _registeredExpenses, onExpenseRemoved: onExpenseRemoved,),
    );
  }
}
