import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'expense.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController()
    ..text = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String? _selectedCategory;
  final List<String> _categories = [
    'Audio',
    'Automotive',
    'Bags',
    'Beauty',
    'Books',
    'Camera',
    'Clothing',
    'Footwear',
    'Gaming',
    'Grocery',
    'Health & Fitness',
    'Food',
    'Mobile',
    'LifeStyle'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Expense'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Center(
                  child: Text(
                    'Add Expense',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  prefixIcon: Icon(Icons.attach_money),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an amount';
                  }
                  try {
                    double.parse(value);
                  } catch (_) {
                    return 'Invalid amount format';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                value: _selectedCategory,
                items: _categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Date (YYYY-MM-DD)',
                  prefixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                keyboardType: TextInputType.datetime,
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      _dateController.text =
                          DateFormat('yyyy-MM-dd').format(selectedDate);
                    });
                  }
                },
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  if (_amountController.text.trim().isNotEmpty &&
                      _selectedCategory != null &&
                      _dateController.text.isNotEmpty) {
                    try {
                      final double amount =
                          double.parse(_amountController.text.trim());
                      final expense = Expense(
                        category: _selectedCategory!,
                        amount: amount,
                        date: _dateController.text,
                      );
                      Navigator.pop(context, expense);
                    } catch (e) {
                      print("Error: $e");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Invalid amount format'),
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please fill in all fields'),
                      ),
                    );
                  }
                },
                child: Text('Save Expense'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200, 60),
                  backgroundColor: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
