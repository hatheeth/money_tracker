import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/amount_provider.dart';
import 'package:intl/intl.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _Home();
}

class _Home extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    final budget = ref.watch(budgetProvider);
    final totalExpense = ref.watch(expenseProvider);
    final currency = ref.watch(currencyProvier);
    final balance = budget - totalExpense;
    final expenseList = ref.watch(expenseListProvider);
  
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('hh:mm a').format(now);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Fixed header card
            Container(
              margin: const EdgeInsets.all(16),
              width: double.infinity,
              height: 220,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [Color.fromARGB(255, 131, 87, 217), Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(30),
                    spreadRadius: 5,
                    blurRadius: 8,
                    offset: const Offset(1, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10,),
                    const Text(
                      "Balance:",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "$currency $balance",
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Budget:",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "$budget $currency",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Expenses:",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "$totalExpense $currency",
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(width: 20),

            // Scrollable list of cards
            Expanded(
              child: ListView.builder(
                itemCount: expenseList.length,
                itemBuilder: (context, index) {
                  final item = expenseList[index];
                  String formattedTime = DateFormat(
                    'hh:mm a',
                  ).format(item['time']);
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: ListTile(
                      leading: _buildCategoryIcon(item['category']),
                      title: Text(
                        item['title'],
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        '${item['category']} - ${item['amount']} $currency',
                      ),
                      trailing: Row(mainAxisSize: MainAxisSize.min,
                      children: [Icon(Icons.delete_outline, color: Colors.red, size: 30,),SizedBox(width: 5,),Text(formattedTime), ],),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryIcon(String category) {
    switch (category) {
      case "Food":
        return Image.asset(
          'assets/food.png',
          width: 40,
          height: 40,
        );
      case "Travel":
        return Image.asset('assets/transport.png', width: 40, height: 40,);
      
      case "Shopping":
        return Image.asset('assets/shopping.png', width: 40, height: 40,);
      default: 
        return const Icon(Icons.category);
    }
  }
}
