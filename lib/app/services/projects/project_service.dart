import '../../../view_models/project_model.dart';
import '../../../view_models/project_task_model.dart';
import '../../entities/project_status.dart';

abstract class ProjectService {
  Future<void> register({required ProjectModel projectModel});
  Future<List<ProjectModel>> findByStatus({required ProjectStatus status});
  Future<ProjectModel> findById({required int projectId});
  Future<ProjectModel> addTask(
      {required int projectId, required ProjectTaskModel task});

  Future<void> finish({required int projectId});
}
