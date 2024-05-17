import 'package:flutter/material.dart';
import 'package:gencoff_app/pages/Homepage/home_page_owner.dart';
import 'package:gencoff_app/pages/Homepage/history_page.dart';
import 'package:gencoff_app/pages/Homepage/settings_page.dart';

class BottomNavigasi extends StatefulWidget {
  const BottomNavigasi({super.key});

  @override
  State<BottomNavigasi> createState() => _BottomNavigasiState();
}

class _BottomNavigasiState extends State<BottomNavigasi> {
  get bottomNavigationBar => null;

  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _pages = [
    const HomePage(),
    const HistoryPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:
            Colors.brown, // Warna coklat untuk bottom navigation bar
        selectedItemColor: Colors.white, // Warna putih untuk item yang dipilih
        unselectedItemColor: Colors
            .brown[200], // Warna coklat muda untuk item yang tidak dipilih
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.history,
            ),
            label: 'Laporan',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            label: 'Pengaturan',
          ),
        ],
      ),
    );
  }
}
