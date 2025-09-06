import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'add_task_page.dart';
import 'task_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selected = 0; // 0: diarias, 1: próximas, 2: no completadas
  final List<Map<String, dynamic>> dailyTasks = [];
  final List<Map<String, dynamic>> upcomingTasks = [];
  final Set<int> expandedIndexes = {};
  final Set<int> selectedIndexes = {}; // Para eliminar tareas seleccionadas

  void addTask(String title, String description, {bool upcoming = false}) {
    final newTask = {
      'title': title,
      'description': description,
      'completed': false,
    };
    setState(() {
      if (upcoming) {
        upcomingTasks.add(newTask);
      } else {
        dailyTasks.add(newTask);
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Tarea añadida')),
    );
  }

  void removeSelectedTasks() {
    setState(() {
      if (selected == 0) {
        selectedIndexes.toList().reversed.forEach((i) => dailyTasks.removeAt(i));
      } else if (selected == 1) {
        selectedIndexes.toList().reversed.forEach((i) => upcomingTasks.removeAt(i));
      } else if (selected == 2) {
        // Eliminar solo de las tareas no completadas
        selectedIndexes.toList().reversed.forEach((i) {
          final allTasks = [...dailyTasks, ...upcomingTasks];
          final task = allTasks[i];
          if (dailyTasks.contains(task)) {
            dailyTasks.remove(task);
          } else if (upcomingTasks.contains(task)) {
            upcomingTasks.remove(task);
          }
        });
      }
      selectedIndexes.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Tarea(s) eliminada(s)')),
    );
  }

  void toggleCompleted(List<Map<String, dynamic>> taskList, int index) {
    setState(() {
      taskList[index]['completed'] = !taskList[index]['completed'];
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredTasks;
    List<Map<String, dynamic>> taskList;

    if (selected == 0) {
      filteredTasks = dailyTasks;
      taskList = dailyTasks;
    } else if (selected == 1) {
      filteredTasks = upcomingTasks;
      taskList = upcomingTasks;
    } else {
      filteredTasks = [
        ...dailyTasks.where((t) => !t['completed']),
        ...upcomingTasks.where((t) => !t['completed']),
      ];
      taskList = filteredTasks;
    }

    final String currentDate =
        DateFormat('EEEE, d MMMM y', 'es_ES').format(DateTime.now());

    return Scaffold(
      body: Column(
        children: [
          // Botones superiores
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 23, 16, 8),
            child: Row(
              children: [
                _AnimatedHeaderButton(
                  text: 'Tareas diarias',
                  selected: selected == 0,
                  onTap: () => setState(() => selected = 0),
                ),
                const SizedBox(width: 8),
                _AnimatedHeaderButton(
                  text: 'Tareas próximas',
                  selected: selected == 1,
                  onTap: () => setState(() => selected = 1),
                ),
                const SizedBox(width: 8),
                _AnimatedHeaderButton(
                  text: 'No completadas',
                  selected: selected == 2,
                  onTap: () => setState(() => selected = 2),
                ),
              ],
            ),
          ),

          // Lista de tareas
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                itemCount: filteredTasks.length,
                itemBuilder: (context, index) {
                  final task = filteredTasks[index];
                  return _buildTaskCard(task, index, taskList);
                },
              ),
            ),
          ),

          // Barra con fecha
          Container(
            width: double.infinity,
            color: const Color(0xFFD9D9D9),
            padding: const EdgeInsets.all(12),
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  currentDate,
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),

          // Footer
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Row(
                children: [
                  Expanded(
                    child: _AnimatedFooterButton(
                      text: 'Añadir nueva tarea',
                      icon: Icons.add,
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AddTaskPage(),
                          ),
                        );
                        if (result != null && result is Map<String, String>) {
                          addTask(
                            result['title']!,
                            result['description']!,
                            upcoming: selected == 1,
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _AnimatedFooterButton(
                      text: selected == 2
                          ? 'Eliminar tarea'
                          : 'Eliminar seleccionadas',
                      icon: Icons.delete,
                      onPressed: removeSelectedTasks,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskCard(
      Map<String, dynamic> task, int index, List<Map<String, dynamic>> taskList) {
    final completed = task['completed'] as bool;
    final isExpanded = expandedIndexes.contains(index);
    final isSelected = selectedIndexes.contains(index);

    return Card(
      color: completed ? Colors.green[100] : Colors.white,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: Checkbox(
              value: isSelected,
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    selectedIndexes.add(index);
                  } else {
                    selectedIndexes.remove(index);
                  }
                });
              },
              activeColor: Colors.green,
            ),
            title: Text(
              task['title'],
              style: const TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            trailing: IconButton(
              icon: Icon(isExpanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  if (isExpanded) {
                    expandedIndexes.remove(index);
                  } else {
                    expandedIndexes.add(index);
                  }
                });
              },
            ),
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TaskDetailsPage(
                    title: task['title'],
                    description: task['description'],
                    completed: completed,
                  ),
                ),
              );

              if (result != null && result is Map<String, dynamic>) {
                setState(() {
                  task['title'] = result['title'];
                  task['description'] = result['description'];
                  if (result['completed'] == true) {
                    task['completed'] = true; // Volver verde la tarjeta
                  }
                });
              }
            },
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Text(
                task['description'],
                style: const TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// Botones superiores con animación de color y centrado
class _AnimatedHeaderButton extends StatefulWidget {
  final String text;
  final bool selected;
  final VoidCallback onTap;

  const _AnimatedHeaderButton({
    required this.text,
    required this.selected,
    required this.onTap,
  });

  @override
  State<_AnimatedHeaderButton> createState() => _AnimatedHeaderButtonState();
}

class _AnimatedHeaderButtonState extends State<_AnimatedHeaderButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTapDown: (_) => setState(() => isPressed = true),
        onTapUp: (_) {
          setState(() => isPressed = false);
          widget.onTap();
        },
        onTapCancel: () => setState(() => isPressed = false),
        child: Container(
          decoration: BoxDecoration(
            color: isPressed ? const Color(0xFF3B82F6) : const Color(0xFFD9D9D9),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              widget.text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: widget.selected ? FontWeight.w700 : FontWeight.w600,
                fontFamily: 'Nunito',
                color: isPressed ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Botones footer con animación de color y centrado
class _AnimatedFooterButton extends StatefulWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const _AnimatedFooterButton({
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  State<_AnimatedFooterButton> createState() => _AnimatedFooterButtonState();
}

class _AnimatedFooterButtonState extends State<_AnimatedFooterButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => isPressed = true),
      onTapUp: (_) {
        setState(() => isPressed = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => isPressed = false),
      child: Container(
        decoration: BoxDecoration(
          color: isPressed ? const Color(0xFF3B82F6) : const Color(0xFFD9D9D9),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(widget.icon, color: isPressed ? Colors.white : Colors.black),
                const SizedBox(width: 6),
                Text(
                  widget.text,
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w600,
                    color: isPressed ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
