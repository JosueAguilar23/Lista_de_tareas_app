import 'package:flutter/material.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Añadir tarea',
          style: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Título',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              style: const TextStyle(
                  fontFamily: 'Nunito', fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: descController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Descripción',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              maxLines: 4,
              style: const TextStyle(
                  fontFamily: 'Nunito', fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    descController.text.isNotEmpty) {
                  Navigator.pop(context, {
                    'title': titleController.text,
                    'description': descController.text,
                  });
                }
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.resolveWith<Color>((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return const Color(0xFF3B82F6);
                  }
                  return const Color(0xFFD9D9D9);
                }),
                foregroundColor:
                    MaterialStateProperty.resolveWith<Color>((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.white;
                  }
                  return Colors.black;
                }),
                overlayColor: MaterialStateProperty.all(
                  const Color(0x33000000), // efecto parpadeo
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                ),
              ),
              child: const Text(
                'Guardar',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}