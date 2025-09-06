import 'package:flutter/material.dart';

class TaskDetailsPage extends StatefulWidget {
  final String title;
  final String description;
  final bool completed;

  const TaskDetailsPage({
    super.key,
    required this.title,
    required this.description,
    required this.completed,
  });

  @override
  State<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  late String title;
  late String description;
  late bool isCompleted;

  @override
  void initState() {
    super.initState();
    title = widget.title;
    description = widget.description;
    isCompleted = widget.completed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles de la tarea'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: const TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () async {
                    // Abrir diálogo para editar
                    final result = await showDialog<Map<String, String>>(
                      context: context,
                      builder: (context) {
                        final titleController =
                            TextEditingController(text: title);
                        final descriptionController =
                            TextEditingController(text: description);
                        return AlertDialog(
                          title: const Text('Editar tarea'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: titleController,
                                decoration:
                                    const InputDecoration(labelText: 'Título'),
                              ),
                              TextField(
                                controller: descriptionController,
                                decoration: const InputDecoration(
                                    labelText: 'Descripción'),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, {
                                  'title': titleController.text,
                                  'description': descriptionController.text,
                                });
                              },
                              child: const Text('Guardar'),
                            ),
                          ],
                        );
                      },
                    );

                    if (result != null) {
                      setState(() {
                        title = result['title']!;
                        description = result['description']!;
                      });
                    }
                  },
                  child: const Text('Editar tarea'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isCompleted ? Colors.green : null,
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () {
                    setState(() {
                      isCompleted = true;
                    });
                  },
                  child: const Text('Tarea completada'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () {
                    setState(() {
                      isCompleted = false;
                    });
                  },
                  child: const Text('Tarea no completada'),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              // Regresar al HomePage con datos actualizados
              Navigator.pop(context, {
                'title': title,
                'description': description,
                'completed': isCompleted.toString(),
              });
            },
            child: const Text('Guardar cambios y volver'),
          ),
        ),
      ),
    );
  }
}