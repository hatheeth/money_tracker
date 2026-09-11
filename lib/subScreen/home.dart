  import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
  import '../providers/amount_provider.dart';

  class Home extends ConsumerStatefulWidget{
    const Home({super.key});

  @override
 ConsumerState<Home> createState () => _Home();
  }

  class _Home extends ConsumerState<Home>{

    
    @override
    Widget build(BuildContext context){
      final _budget = ref.watch(budgetProvider);
      final _expense = ref.watch(expenseProvider);
      final _balance = ref.watch(budgetProvider);


      return SafeArea(
            child: Container(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        width: 335,
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
                              offset: Offset(1, 2),
                            ),
                          ],
                        ),
            
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 30),
                                  const Text(
                                    "Balance:",
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "LKR $_balance",
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children:  [
                                      Text(
                                        "Budget:",
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "$_budget LKR",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children:  [
                                      Text(
                                        "Expenses:",
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "$_expense LKR",
                                        style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 15),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
    }
  }

    