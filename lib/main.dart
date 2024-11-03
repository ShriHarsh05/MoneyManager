import 'package:flutter/material.dart';
import 'expenses_page.dart';
import 'creator_profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Money Manager',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> transactions = [
    {'title': 'Groceries', 'amount': 50.0, 'type': 'expense'},
    {'title': 'Salary', 'amount': 1500.0, 'type': 'income'},
    {'title': 'Electricity Bill', 'amount': 80.0, 'type': 'expense'},
  ];

  double balance = 50000.0;
  int _selectedIndex = 0;

  double calculateBalance() {
    double income = transactions
        .where((transaction) => transaction['type'] == 'income')
        .fold(0.0, (sum, transaction) => sum + transaction['amount']);
    double expenses = transactions
        .where((transaction) => transaction['type'] == 'expense')
        .fold(0.0, (sum, transaction) => sum + transaction['amount']);
    return balance + income - expenses;
  }

  void addTransaction(Map<String, dynamic> transaction) {
    setState(() {
      transactions.add(transaction);
      balance = calculateBalance();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      if (index == 1) {
        //If "Insights" (index 1) is tapped
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ExpensesPage()),
        );
      }
      if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Profile()),
        );
      }
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Money Manager',
            style: TextStyle(
              fontSize: 32,
              color: Colors.red,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        backgroundColor: Colors.green,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart), label: "Insights"),
          BottomNavigationBarItem(
              icon: Icon(Icons.accessibility_new), label: "Creator"),
        ],
        selectedItemColor: Colors.green,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BalanceCard(balance: calculateBalance()),
            SizedBox(height: 20),
            Expanded(child: TransactionList(transactions: transactions)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTransaction = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTransactionPage(),
            ),
          );

          if (newTransaction != null) {
            addTransaction(newTransaction);
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}

class BalanceCard extends StatelessWidget {
  final double balance;

  BalanceCard({required this.balance});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total Balance', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('Rs ${balance.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('Income', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 5),
                    Text('\₹7000',
                        style: TextStyle(color: Colors.green, fontSize: 18)),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Expenses',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Rs 20000',
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TransactionList extends StatelessWidget {
  final List<Map<String, dynamic>> transactions;

  TransactionList({required this.transactions});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return Card(
          child: ListTile(
            title: Text(transaction['title']),
            subtitle: Text(transaction['type']),
            trailing: Text(
              '\₹${transaction['amount']}',
              style: TextStyle(
                color:
                    transaction['type'] == 'income' ? Colors.green : Colors.red,
                fontSize: 16,
              ),
            ),
          ),
        );
      },
    );
  }
}

class AddTransactionPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Transaction"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || double.tryParse(value) == null) {
                    return 'Please enter a valid amount';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newTransaction = {
                      'title': _titleController.text,
                      'amount': double.parse(_amountController.text),
                      'type': 'expense', // Change type as needed
                    };
                    Navigator.pop(context, newTransaction);
                  }
                },
                child: Text('Save Transaction'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
