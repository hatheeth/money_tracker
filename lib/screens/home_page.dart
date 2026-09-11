import 'package:flutter/material.dart';
import '../subScreen/home.dart';
import '../subScreen/profile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _selectedIndex =0;

  final List<Widget> _pages = [
    Home(),
    Profile()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Color.fromARGB(255, 131, 87, 217)),
              child: Text(
                "Menu",
                style: TextStyle(
                  color: Color.fromARGB(255, 254, 254, 254),
                  fontSize: 20,
                ),
              ),
            ),
            ListTile(leading: Icon(Icons.category), title: Text("Categories")),
            ListTile(leading: Icon(Icons.settings), title: Text("Settings")),
          ],
        ),
      ),
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
      // action for middle button
    },
    child: const Icon(Icons.add),
  ),
  floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
