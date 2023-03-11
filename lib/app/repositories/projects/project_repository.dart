import '../../entities/project.dart';
import '../../entities/project_status.dart';
import '../../entities/project_task.dart';

abstract class ProjectRepository {
  Future<void> register({required Project project});
  Future<List<Project>> findByStatus({required ProjectStatus status});
  Future<Project> findById({required int projectId});
  Future<Project> addTask({required int projectId, required ProjectTask task});
  Future<void> finish({required int projectId});
}
