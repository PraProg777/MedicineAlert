import 'package:flutter/material.dart';
import 'screens/HomeScreen.dart';
import 'screens/MedicineScreen.dart';
import 'screens/CalenderScreen.dart';
import 'screens/SettingScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Lista de pantallas importadas
  final List<Widget> _screens = const [
    HomeScreen(),
    MedicineScreen(),
    CalenderScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // El cuerpo cambia segun la pantalla seleccionada
      body: _screens[_selectedIndex],

      // La barra siempre permance fija
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.medical_services),
            label: 'Medicamentos',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today),
            label: 'Calendario',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Configuración',
          ),
        ],
      ),
    );
  }
}