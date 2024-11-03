import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'expense.dart'; // Import the Expense class
import 'add_expense.dart';

class ExpensesPage extends StatefulWidget {
  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  double _currentSliderValue = 15;
  double balance = 50000.0;
  List<FlSpot> _fullData = [
    FlSpot(1, 3),
    FlSpot(2, 2),
    FlSpot(3, 5),
    FlSpot(4, 2.5),
    FlSpot(5, 4),
    FlSpot(6, 3),
    FlSpot(7, 4),
    FlSpot(8, 2),
    FlSpot(9, 4.5),
    FlSpot(10, 3.5),
    FlSpot(11, 5),
    FlSpot(12, 4.5),
    FlSpot(13, 3),
    FlSpot(14, 4),
    FlSpot(15, 3.5),
    FlSpot(16, 4.2),
    FlSpot(17, 5),
    FlSpot(18, 4),
    FlSpot(19, 3.8),
    FlSpot(20, 4.5),
    FlSpot(21, 4),
    FlSpot(22, 4.3),
    FlSpot(23, 3.9),
    FlSpot(24, 4.1),
    FlSpot(25, 4.7),
    FlSpot(26, 4.2),
    FlSpot(27, 4),
    FlSpot(28, 3.5),
    FlSpot(29, 4.5),
    FlSpot(30, 4.8),
    FlSpot(31, 4.1),
  ];

  void _addExpense(Expense expense) {
    setState(() {
      _expenses.add(expense);
      _expenses.sort(
          (a, b) => b.date.compareTo(a.date)); // Sort by date (descending)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Expense added successfully!')),
      );
    });
  }

  List<Expense> _expenses = [];

  @override
  Widget build(BuildContext context) {
    List<FlSpot> filteredData = _fullData.where((spot) {
      return spot.x <= _currentSliderValue;
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 175,
                    width: 175,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.amber[100],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Balance',
                          style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            'Rs ${balance.toStringAsFixed(2)}', // Display balance
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 175,
                    width: 175,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.amber[100],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Add Expense',
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.red)),
                        SizedBox(height: 10),
                        FloatingActionButton(
                          onPressed: () async {
                            final Expense? newExpense = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddExpense(),
                              ),
                            );

                            if (newExpense != null) {
                              _addExpense(newExpense);
                            }
                          },
                          child: Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Text('Expense Graph',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 100,
                child: LineChart(
                  LineChartData(
                    lineBarsData: [
                      LineChartBarData(
                        spots: filteredData,
                        isCurved: true,
                        dotData: FlDotData(show: false),
                        barWidth: 3,
                        belowBarData: BarAreaData(
                          show: true,
                          color: Colors.amber[100],
                        ),
                      ),
                    ],
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                        ),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                        ),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    lineTouchData: LineTouchData(
                      enabled: false,
                    ),
                  ),
                ),
              ),
              Slider(
                value: _currentSliderValue,
                min: 1,
                max: 31,
                divisions: 30,
                label: 'Day ${_currentSliderValue.round()}',
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value;
                  });
                },
              ),
              Center(
                child: Text(
                  'Day ${_currentSliderValue.round()}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Expenses Category Wise',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    color: Colors.red),
              ),
              SizedBox(height: 8),
              ..._expenses
                  .map((expense) => Tile(
                        text: expense.category,
                        imagePath: null,
                        spent: expense.amount,
                      ))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}

class Tile extends StatelessWidget {
  final String text;
  final String? imagePath;
  final double spent;

  const Tile({
    Key? key,
    required this.text,
    this.imagePath,
    required this.spent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.amber[100],
      ),
      child: Row(
        children: [
          if (imagePath != null)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Image.asset(
                imagePath!,
                height: 60,
                width: 60,
              ),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Spent: Rs ${spent.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
