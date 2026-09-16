import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/amount_provider.dart';
import '../database/database_helper.dart';

class AddExpenseSheet extends ConsumerStatefulWidget {
  const AddExpenseSheet({super.key});

  @override
  ConsumerState<AddExpenseSheet> createState() => _AddExpenseSheetState();
}

class _AddExpenseSheetState extends ConsumerState<AddExpenseSheet> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  String selectedCategory = 'Food';

  @override
  Widget build(BuildContext context) {
    final currentList = ref.read(expenseListProvider);
    final totalExpense = ref.read(expenseProvider);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Add Expense",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              labelText: "Title",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Amount",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
            ),
          ),
          const SizedBox(height: 8),
          DropdownButton<String>(
            value: selectedCategory,
            items: [
              'Food',
              'Travel',
              'Shopping',
              'Clothe',
              'Snack',
              'Utilities',
              'Healthcare',
              'Education',
              'Other',
            ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (value) {
              setState(() {
                selectedCategory = value!;
              });
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              final newExpense = {
                'id': DateTime.now().millisecondsSinceEpoch.toString(),
                'title': titleController.text,
                'amount': double.tryParse(amountController.text) ?? 0,
                'category': selectedCategory,
                'time': DateTime.now(),
              };
              ref.read(expenseListProvider.notifier).state = [
                ...currentList,
                newExpense,
              ];

              await DatabaseHelper.instance.saveExpenseList(
                ref.read(expenseListProvider),
              );
              ref.read(expenseProvider.notifier).state =
                  (double.tryParse(amountController.text) ?? 0) + totalExpense;

                await DatabaseHelper.instance.saveMoney(ref.read(expenseProvider));

              Navigator.pop(context);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }
}
