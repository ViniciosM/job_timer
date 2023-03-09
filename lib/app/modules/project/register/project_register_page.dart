import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_timer/app/core/ui/button_with_loader.dart';
import 'package:job_timer/app/modules/project/register/controller/project_register_controller.dart';
import 'package:validatorless/validatorless.dart';

class ProjectRegisterPage extends StatefulWidget {
  const ProjectRegisterPage(
      {super.key, required this.projectRegisterController});

  final ProjectRegisterController projectRegisterController;

  @override
  State<ProjectRegisterPage> createState() => _ProjectRegisterPageState();
}

final _formKey = GlobalKey<FormState>();
late TextEditingController _nameEC;
late TextEditingController _estimateEC;

class _ProjectRegisterPageState extends State<ProjectRegisterPage> {
  @override
  void initState() {
    _nameEC = TextEditingController();
    _estimateEC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameEC.dispose();
    _estimateEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProjectRegisterController, ProjectRegisterStatus>(
      bloc: widget.projectRegisterController,
      listener: (context, state) {
        switch (state) {
          case ProjectRegisterStatus.success:
            AsukaSnackbar.success('Projeto criado com sucesso!');
            Navigator.pop(context);
            break;
          case ProjectRegisterStatus.failure:
            AsukaSnackbar.alert('Erro ao salvar projeto');
            break;
          default:
            break;
        }
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text(
              'Criar novo projeto',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black),
            elevation: 0,
          ),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                TextFormField(
                  controller: _nameEC,
                  decoration: const InputDecoration(
                    label: Text('Nome do projeto'),
                  ),
                  validator: Validatorless.required('Nome obrigatório'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                    controller: _estimateEC,
                    decoration: const InputDecoration(
                      label: Text('Estimativa de horas'),
                    ),
                    keyboardType: TextInputType.number,
                    validator: Validatorless.multiple([
                      Validatorless.required('Estimativa obrigatória.'),
                      Validatorless.number('Permitido somente números'),
                    ])),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  child: ButtonWithLoader<ProjectRegisterController,
                          ProjectRegisterStatus>(
                      selector: (state) =>
                          state == ProjectRegisterStatus.loading,
                      bloc: widget.projectRegisterController,
                      onPressed: () async {
                        final formValid =
                            _formKey.currentState?.validate() ?? false;
                        if (formValid) {
                          final name = _nameEC.text;
                          final estimate = int.parse(_estimateEC.text);
                          await widget.projectRegisterController
                              .register(name: name, estimate: estimate);
                        }
                      },
                      label: 'Salvar'),
                ),
              ]),
            ),
          )),
    );
  }
}
