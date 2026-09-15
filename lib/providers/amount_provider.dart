import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final budgetProvider = StateProvider<double>((ref) => 0);
final expenseProvider = StateProvider<double>((ref) => 0);
final currencyProvier = StateProvider<String>((ref) => "");
final expenseListProvider = StateProvider<List<Map<String, dynamic>>>((ref) => []);

 

final balanceProvider = Provider<double>((ref){
  final budget = ref.watch(budgetProvider);
  final expense = ref.watch(expenseProvider);
  return budget - expense;
});