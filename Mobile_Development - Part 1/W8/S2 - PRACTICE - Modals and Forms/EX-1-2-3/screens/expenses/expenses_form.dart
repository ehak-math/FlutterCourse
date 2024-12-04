import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/expense.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key, required this.onCreated});

  final Function(Expense) onCreated;

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  Category? _selectedCategory;
  DateTime? _selectedDate;

  String get title => _titleController.text;

  @override
  void dispose() {
    _titleController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  void onCancel() {
    
    // Close modal
    Navigator.pop(context);
  }

  void onAdd() {
    // 1- Get the values from inputs
    String title = _titleController.text;
    double? amount = double.tryParse(_valueController.text);

    bool isTitleValid = title.trim().isNotEmpty;
    bool isAmountValid = amount != null && amount > 0;
    bool isSelectedCategory = _selectedCategory != null;
    bool isSelectedDate = _selectedDate != null;
    bool valid = isTitleValid && isAmountValid && 
                  isSelectedCategory && isSelectedDate;

    if (valid) {
      // 2- Create the expense
      Expense expense = Expense(
          title: title,
          amount: amount,
          date: _selectedDate!,     
          category: _selectedCategory!,
      );
      // 3- Ask the parent to add the expense
      widget.onCreated(expense);

      // 4- Close modal
      Navigator.pop(context);
    }else{
        // Build error message
        String errorMessage = '';
        if (!isSelectedCategory) errorMessage ='Please select a category.';
        if (!isSelectedDate) errorMessage = 'Please select a date.';
        if (!isAmountValid) errorMessage = 'Please enter the amount.';
        if (!isTitleValid) errorMessage = 'The title cannot be empty.';

        showDialog(
          context: context, 
          builder: (BuildContext content){
            return AlertDialog(
              title: const Text("Invalid input"),
              content: Text(errorMessage),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(content, "Okay"), 
                  child: const Text("Okay"))
              ],
            );
          },
        );
    }
  }

  void _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
    }



  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: Colors.white
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            
            TextField(
              controller: _titleController,
              maxLength: 50,
              decoration: const InputDecoration(
                label: Text('Title'),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    controller: _valueController,
                    // maxLength: 50,
                    decoration: const InputDecoration(
                      prefix: Text('\$ '),
                      label: Text('Amount'),
                    ),
                  ),
                ),
                const SizedBox(width: 30,),
                Text(
                  _selectedDate != null
                  ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                  : 'No date selected',
                  style: const TextStyle(fontSize: 16),
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_month),
                  onPressed: _pickDate,
                ),
              ]
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton(
                  value: _selectedCategory,
                  hint: const Text("Category"),
                  items: Category.values.map((Category category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category.name.toUpperCase())
                    );
                  }).toList(),
                  onChanged: (Category? value){
                    setState(() {
                      _selectedCategory = value;
                    });
                  }
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: onCancel, 
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        side: const BorderSide(width: 0, color: Colors.white),
                      ),
                      child: const Text('Cancel')
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: onAdd, 
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[50]
                      ),
                      child: const Text('Save Expense')
                    ),
                  ],
                ),
              ]
            )
          ],
        ),
      ),
    );
  }
}
