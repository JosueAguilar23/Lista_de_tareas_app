import 'package:flutter/material.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Añadir tarea')),
      body: const Center(
        child: Text('UI estática se implementa en el punto 4'),
      ),
    );
  }
}