import 'package:flutter/material.dart';
import 'package:time_tracker_app/screens/account/views/account_page.dart';
import 'package:time_tracker_app/screens/entries/landingEntries.dart';
import 'package:time_tracker_app/screens/entries/views/entries_page.dart';
import 'screens/home/views/job_page.dart';
import 'services/auth.dart';

class BottomNavigator extends StatefulWidget {
  final AuthBase auth;
  BottomNavigator({this.auth});
  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  final List<Widget> _widgetOptions = [
    JobsPage(),
    Entries(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Jobs',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            label: 'Entries',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
            backgroundColor: Colors.white,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        elevation: 9,
        showUnselectedLabels: false,


      ),
    );
  }
}
