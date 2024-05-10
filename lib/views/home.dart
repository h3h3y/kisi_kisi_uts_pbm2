import 'package:flutter/material.dart';
import 'package:tugas1_0080/views/CrudSqflite/crud_sqflite.dart';
import 'package:tugas1_0080/views/CrudApi/crud_api.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const CrudApi(),
    const CrudSqflite(),
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
        title: const Text('0080'),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.api),
            label: 'API CRUD',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storage),
            label: 'Sqflite CRUD',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
