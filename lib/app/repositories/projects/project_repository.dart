import '../../entities/project.dart';
import '../../entities/project_status.dart';

abstract class ProjectRepository {
  Future<void> register({required Project project});
  Future<List<Project>> findByStatus({required ProjectStatus status});
}
