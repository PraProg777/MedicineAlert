import 'package:flutter/material.dart';

import '../models/medicine.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  final medicines = <Medicine>[
    const Medicine(name: 'Losartán', dosage: '50 mg · 1 comprimido', nextDose: '08:00', color: 0xFF167D78),
    const Medicine(name: 'Vitamina D', dosage: '1000 UI · 1 cápsula', nextDose: '13:30', color: 0xFFE18A3D),
  ];

  void markAsTaken(int index) {
    setState(() => medicines[index] = medicines[index].copyWith(isTaken: true));
  }

  @override
  Widget build(BuildContext context) {
    final pages = [_buildDashboard(context), const _PlaceholderPage(icon: Icons.medication_outlined, title: 'Mis medicamentos'), const _PlaceholderPage(icon: Icons.history, title: 'Historial'), const _PlaceholderPage(icon: Icons.settings_outlined, title: 'Ajustes')];

    return Scaffold(
      appBar: AppBar(
        title: const Text('MedicineAlert', style: TextStyle(fontWeight: FontWeight.w800)),
        actions: [IconButton(onPressed: () {}, tooltip: 'Notificaciones', icon: const Icon(Icons.notifications_none))],
      ),
      body: SafeArea(child: pages[selectedIndex]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) => setState(() => selectedIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Inicio'),
          NavigationDestination(icon: Icon(Icons.medication_outlined), selectedIcon: Icon(Icons.medication), label: 'Medicamentos'),
          NavigationDestination(icon: Icon(Icons.history_outlined), selectedIcon: Icon(Icons.history), label: 'Historial'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: 'Ajustes'),
        ],
      ),
    );
  }

  Widget _buildDashboard(BuildContext context) {
    final pending = medicines.where((medicine) => !medicine.isTaken).length;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      children: [
        Text('Mi día', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 4),
        Text('Miércoles, 26 de agosto', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black54)),
        const SizedBox(height: 20),
        Card(
          color: const Color(0xFF19324A),
          child: const Padding(
            padding: EdgeInsets.all(20),
            child: Row(children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Todo bajo control', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
                SizedBox(height: 8),
                Text('Tu próxima toma está programada para las 08:00.', style: TextStyle(color: Colors.white70, height: 1.4)),
              ])),
              CircleAvatar(radius: 28, backgroundColor: Color(0xFF2D536F), child: Icon(Icons.check_rounded, color: Colors.white, size: 30)),
            ]),
          ),
        ),
        const SizedBox(height: 24),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Próximas dosis', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
          Text('$pending pendientes', style: const TextStyle(color: Color(0xFF167D78), fontWeight: FontWeight.w700)),
        ]),
        const SizedBox(height: 12),
        ...medicines.asMap().entries.map((entry) => _MedicineCard(medicine: entry.value, onTaken: () => markAsTaken(entry.key))),
        const SizedBox(height: 16),
        OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.add), label: const Text('Agregar medicamento')),
      ],
    );
  }
}

class _MedicineCard extends StatelessWidget {
  const _MedicineCard({required this.medicine, required this.onTaken});

  final Medicine medicine;
  final VoidCallback onTaken;

  @override
  Widget build(BuildContext context) {
    final color = Color(medicine.color);
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(backgroundColor: color.withAlpha(28), child: Icon(Icons.medication, color: color)),
        title: Text(medicine.name, style: const TextStyle(fontWeight: FontWeight.w800)),
        subtitle: Text('${medicine.dosage}\nPróxima toma: ${medicine.nextDose}'),
        isThreeLine: true,
        trailing: medicine.isTaken ? const Icon(Icons.check_circle, color: Color(0xFF167D78)) : IconButton(onPressed: onTaken, tooltip: 'Marcar como tomada', icon: const Icon(Icons.circle_outlined)),
      ),
    );
  }
}

class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, size: 56, color: const Color(0xFF167D78)), const SizedBox(height: 12), Text(title, style: Theme.of(context).textTheme.titleLarge)]));
  }
}