import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final budgetProvider = StateProvider<int>((ref) => 0);
final expenseProvider = StateProvider<int>((ref) => 0);

final balanceProvider = Provider<int>((ref){
  final budget = ref.watch(budgetProvider);
  final expense = ref.watch(expenseProvider);
  return budget - expense;
});