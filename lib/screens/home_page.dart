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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 131, 87, 217),
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.manage_accounts), label: "Manage"),
          
        ],
      ),
    );
  }
}
