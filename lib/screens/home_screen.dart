import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _pendingDoses = 2;
  bool _markedToday = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MedicineAlert'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            const Text(
              'Mi día',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Card(
              child: ListTile(
                title: const Text('Losartán'),
                subtitle: Text('$_pendingDoses pendientes'),
                trailing: IconButton(
                  tooltip: 'Marcar como tomada',
                  onPressed: _pendingDoses > 0
                      ? () {
                          setState(() {
                            _pendingDoses = (_pendingDoses - 1).clamp(0, 2);
                            _markedToday = true;
                          });
                        }
                      : null,
                  icon: Icon(
                    _markedToday ? Icons.check_circle : Icons.check_circle_outline,
                    color: _markedToday ? Colors.green : Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}