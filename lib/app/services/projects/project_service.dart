import '../../../view_models/project_model.dart';
import '../../entities/project_status.dart';

abstract class ProjectService {
  Future<void> register({required ProjectModel projectModel});
  Future<List<ProjectModel>> findByStatus({required ProjectStatus status});
}
