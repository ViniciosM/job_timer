import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/modules/project/task/controller/task_controller.dart';
import 'package:job_timer/app/modules/project/task/task_page.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

class TaskModule extends Module {
  @override
  final List<Bind> binds = [
    BlocBind.lazySingleton((i) => TaskController(projectService: i()))
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: ((context, args) {
      final projectModel = args.data;

      return TaskPage(
        taskController: Modular.get()..setProject(projectModel),
      );
    }))
  ];
}
