class Expense {
  final String category;
  final String? imagePath;
  final double amount;
  final String date; // Use String type for date

  Expense({
    required this.category,
    this.imagePath,
    required this.amount,
    required this.date,
  });

  @override
  String toString() {
    return 'Expense{category: $category, amount: $amount, date: $date}';
  }
}
