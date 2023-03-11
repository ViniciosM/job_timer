import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:job_timer/app/services/projects/project_service.dart';

import '../../../../view_models/project_model.dart';
import '../../../entities/project_status.dart';

part 'home_state.dart';

class HomeController extends Cubit<HomeState> {
  final ProjectService _projectService;

  HomeController({required ProjectService projectService})
      : _projectService = projectService,
        super(HomeState.initial());

  Future<void> loadProjects() async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));
      final projects =
          await _projectService.findByStatus(status: state.projectFilter);
      emit(state.copyWith(status: HomeStatus.complete, projects: projects));
    } catch (e, s) {
      log('Erro ao buscar os projetos', error: e, stackTrace: s);
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }

  Future<void> filter(ProjectStatus status) async {
    emit(state.copyWith(status: HomeStatus.loading, projects: []));
    final projects = await _projectService.findByStatus(status: status);
    emit(state.copyWith(
        status: HomeStatus.complete,
        projects: projects,
        projectFilter: status));
  }

  Future<void> updateList() async {
    if (state.status == HomeStatus.complete) {
      filter(state.projectFilter);
    } else {
      filter(ProjectStatus.em_andamento);
    }
  }
}
