import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/modules/project/detail/controller/project_detail_controller.dart';
import 'package:job_timer/app/modules/project/detail/project_detail_page.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

import '../../../../view_models/project_model.dart';

class ProjectDetailModule extends Module {
  @override
  final List<Bind> binds = [
    BlocBind.lazySingleton(
      (i) => ProjectDetailController(projectService: i()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (context, args) {
      final ProjectModel projectModel = args.data;
      return ProjectDetailPage(
        projectDetailController: Modular.get()..setProject(projectModel),
      );
    })
  ];
}
