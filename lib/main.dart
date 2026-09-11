import 'package:flutter/material.dart';
import '../screens/login_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Tracker',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Color.fromARGB(255, 131, 87, 217))),
      home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}


