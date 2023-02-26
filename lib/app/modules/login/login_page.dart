import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_timer/app/modules/login/controller/login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key, required this.loginController});

  final LoginController loginController;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return BlocListener<LoginController, LoginState>(
      bloc: loginController,
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == LoginStatus.failure) {
          final message = state.errorMessage ?? "Erro ao  realizar login";
          AsukaSnackbar.alert(message).show();
        }
      },
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0XFF0092B9),
                Color(0XFF0167B2),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png'),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: screenSize.width,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    loginController.signIn();
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.grey[200]),
                  child: Image.asset('assets/images/google.png'),
                ),
              ),
              BlocSelector<LoginController, LoginState, bool>(
                bloc: loginController,
                selector: (state) => state.status == LoginStatus.loading,
                builder: (context, show) {
                  return Visibility(
                    visible: show,
                    child: const Padding(
                      padding: EdgeInsets.only(top: 24),
                      child: Center(
                        child: CircularProgressIndicator.adaptive(
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
