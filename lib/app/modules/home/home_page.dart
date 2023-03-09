import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_timer/app/modules/home/controller/home_controller.dart';
import 'package:job_timer/app/modules/home/widgets/header_project_menu.dart';
import 'package:job_timer/app/modules/home/widgets/project_tile.dart';
import 'package:job_timer/view_models/project_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.homeController});

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeController, HomeState>(
      bloc: homeController,
      listener: (context, state) {
        if (state.status == HomeStatus.failure) {
          AsukaSnackbar.alert('Erro ao buscar os projetos').show();
        }
      },
      child: Scaffold(
        drawer: const Drawer(
          child: SafeArea(
              child: ListTile(
            title: Text('Sair'),
          )),
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              const SliverAppBar(
                title: Text('Projetos'),
                expandedHeight: 100,
                toolbarHeight: 100,
                centerTitle: true,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(15))),
              ),
              SliverPersistentHeader(
                delegate: HeaderProjectMenu(homeController: homeController),
                pinned: true,
              ),
              BlocSelector<HomeController, HomeState, bool>(
                  bloc: homeController,
                  selector: (state) => state.status == HomeStatus.loading,
                  builder: (context, showLoading) {
                    return SliverVisibility(
                        visible: showLoading,
                        sliver: const SliverToBoxAdapter(
                          child: SizedBox(
                            height: 50,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ));
                  }),
              BlocSelector<HomeController, HomeState, List<ProjectModel>>(
                bloc: homeController,
                selector: (state) => state.projects,
                builder: (context, projects) {
                  return SliverList(
                      delegate: SliverChildListDelegate(projects
                          .map((project) => ProjectTile(projectModel: project))
                          .toList()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
