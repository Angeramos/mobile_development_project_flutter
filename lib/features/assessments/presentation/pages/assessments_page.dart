import 'package:flutter/material.dart';

class AssessmentsPage extends StatelessWidget {
  const AssessmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Evaluaciones y Criterios')),
      body: const Center(
        child: Text('Aquí se mostrarán las evaluaciones y criterios.'),
      ),
    );
  }
}
