import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../subScreen/home.dart';
import '../subScreen/profile.dart';
import '../providers/amount_provider.dart';
import '../util/expenseAdd.dart';
import '../database/database_helper.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  int _selectedIndex = 0;
  String selectedCategory = 'Food';
  final List<Widget> _pages = [Home(), Profile()];

  @override
  void initState() {
    super.initState();
    _loadBudget();
    _loadCurrency();
    _loadList();
    _loadMoney();

    
  }

  Future<void> _loadBudget() async {
    final db = DatabaseHelper.instance;
    final savedBudget = await db.loadBudget();
    if (savedBudget != null) {
      ref.read(budgetProvider.notifier).state = savedBudget;
    }
  }

  Future<void> _loadCurrency() async {
    final db = DatabaseHelper.instance;
    final savedCurrency = await db.loadCurrency();
    if (savedCurrency != null) {
      ref.read(currencyProvier.notifier).state = savedCurrency;
    }
  }

  Future<void> _loadList() async {
    final expense = await DatabaseHelper.instance.loadExpenseList();
    ref.read(expenseListProvider.notifier).state = expense;
  }

  Future<void> _loadMoney() async {
    final money = await DatabaseHelper.instance.loadMoney();
    if (money != null) {
      ref.read(expenseProvider.notifier).state = money;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(), // notch for FAB
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                setState(() => _selectedIndex = 0);
              },
            ),
            const SizedBox(width: 40), // space for middle button
            IconButton(
              icon: const Icon(Icons.manage_accounts),
              onPressed: () {
                setState(() => _selectedIndex = 1);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showGeneralDialog(
            context: context,
            barrierDismissible: true,
            barrierLabel: '',
            transitionDuration: const Duration(milliseconds: 300),
            pageBuilder: (context, animation1, animation2) {
              return Center(
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: const AddExpenseSheet(),
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
