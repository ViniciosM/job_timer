import 'package:flutter/material.dart';

import '../../../../view_models/project_model.dart';
import '../../../core/ui/job_timer_icons.dart';

class ProjectTile extends StatelessWidget {
  const ProjectTile({super.key, required this.projectModel});

  final ProjectModel projectModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 90),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey[300]!,
          )),
      child: Column(
        children: [
          _ProjectName(projectModel: projectModel),
          Expanded(
            child: _ProjectProgress(
              projectModel: projectModel,
            ),
          )
        ],
      ),
    );
  }
}

class _ProjectName extends StatelessWidget {
  final ProjectModel projectModel;

  const _ProjectName({required this.projectModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(projectModel.name),
          Icon(
            JobTimerIcons.angle_double_right,
            color: Theme.of(context).primaryColor,
            size: 20,
          ),
        ],
      ),
    );
  }
}

class _ProjectProgress extends StatelessWidget {
  final ProjectModel projectModel;

  const _ProjectProgress({Key? key, required this.projectModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalTasks = projectModel.tasks.fold<int>(
        0, ((previousValue, task) => previousValue += task.duration));

    var percent = 0.0;

    if (totalTasks > 0) {
      percent = totalTasks / projectModel.estimate;
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Expanded(
              child: LinearProgressIndicator(
            value: percent,
            backgroundColor: Colors.grey[400],
            color: Theme.of(context).primaryColor,
          )),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text('${projectModel.estimate}'),
          )
        ],
      ),
    );
  }
}
