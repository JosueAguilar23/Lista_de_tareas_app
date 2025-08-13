import 'package:flutter/material.dart';
import 'add_task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selected = 0; // 0: diarias, 1: próximas, 2: no completadas

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Organiza tu tiempo')),
      body: Column(
        children: [
          // Header con 3 botones
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Row(
              children: [
                _HeaderButton(
                  text: 'Tareas diarias',
                  selected: selected == 0,
                  onTap: () => setState(() => selected = 0),
                ),
                const SizedBox(width: 8),
                _HeaderButton(
                  text: 'Tareas próximas',
                  selected: selected == 1,
                  onTap: () => setState(() => selected = 1),
                ),
                const SizedBox(width: 8),
                _HeaderButton(
                  text: 'No completadas',
                  selected: selected == 2,
                  onTap: () => setState(() => selected = 2),
                ),
              ],
            ),
          ),

          // Zona central con 3 "cajones" (estructura, sin lógica)
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: const [
                    _Box(label: 'Título de la tarea', height: 56),
                    SizedBox(height: 12),
                    _Box(label: 'Descripción de la tarea', height: 120),
                    SizedBox(height: 12),
                    _Box(label: 'Editar tarea (placeholder)', height: 56),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      // Footer con dos botones separados
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AddTaskPage()),
                    );
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Añadir nueva tarea'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Eliminar tarea'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.delete),
                  label: const Text('Eliminar tarea'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderButton extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onTap;

  const _HeaderButton({
    required this.text,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          side: BorderSide(
            color: selected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).dividerColor,
          ),
          backgroundColor:
              selected ? Theme.of(context).colorScheme.primaryContainer : null,
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _Box extends StatelessWidget {
  final String label;
  final double height;

  const _Box({required this.label, this.height = 64});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      child: Container(
        height: height,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }
}