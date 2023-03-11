import 'package:flutter/material.dart';

import '../../../../../view_models/project_task_model.dart';

class ProjectTaskTile extends StatelessWidget {
  const ProjectTaskTile({required this.task, super.key});

  final ProjectTaskModel task;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(task.name),
          // Text('Duração'),
          // Text('4h'),
          RichText(
              text: TextSpan(children: [
            const TextSpan(
              text: 'Duração',
              style: TextStyle(color: Colors.grey),
            ),
            const TextSpan(
              text: '      ',
            ),
            TextSpan(
              text: '${task.duration}h',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            )
          ]))
        ],
      ),
    );
  }
}
