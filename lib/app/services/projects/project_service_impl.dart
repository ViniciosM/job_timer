// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/repositories/projects/project_repository.dart';
import 'package:job_timer/view_models/project_model.dart';
import 'package:job_timer/view_models/project_task_model.dart';

import '../../entities/project.dart';
import '../../entities/project_task.dart';
import './project_service.dart';

class ProjectServiceImpl implements ProjectService {
  final ProjectRepository _projectRepository;

  ProjectServiceImpl({required ProjectRepository projectRepository})
      : _projectRepository = projectRepository;

  @override
  Future<void> register({required ProjectModel projectModel}) async {
    final project = Project()
      ..id = projectModel.id
      ..name = projectModel.name
      ..status = projectModel.status
      ..estimate = projectModel.estimate;

    await _projectRepository.register(project: project);
  }

  @override
  Future<List<ProjectModel>> findByStatus(
      {required ProjectStatus status}) async {
    final projects = await _projectRepository.findByStatus(status: status);

    return projects.map(ProjectModel.fromEntity).toList();
  }

  @override
  Future<ProjectModel> addTask(
      {required int projectId, required ProjectTaskModel task}) async {
    final projectTask = ProjectTask()
      ..name = task.name
      ..duration = task.duration;

    final project = await _projectRepository.addTask(
        projectId: projectId, task: projectTask);

    return ProjectModel.fromEntity(project);
  }

  @override
  Future<ProjectModel> findById({required int projectId}) async {
    final project = await _projectRepository.findById(projectId: projectId);
    return ProjectModel.fromEntity(project);
  }

  @override
  Future<void> finish({required int projectId}) async {
    _projectRepository.finish(projectId: projectId);
  }
}
