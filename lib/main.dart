import 'package:flutter/material.dart';
import 'addExpense.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Tracker',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'Money Tracker'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.deepPurple),
                child: Text(
                  "Menu",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              ListTile(
                leading: Icon(Icons.category),
                title: Text("Manage Categories"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),

              ListTile(
                leading: Icon(Icons.numbers),
                title: Text("Add tags"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: (){},
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text("Money Tracker"),
          centerTitle: true,
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white54,
            tabs: [
              Tab(text: "By Date"),
              Tab(text: "By Category"),
            ],
            indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: Text("this is for the first one")),
            Center(child: Text("this is second")),
          ],
        ),

        floatingActionButton: FloatingActionButton(
          onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddExpensePage()));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
