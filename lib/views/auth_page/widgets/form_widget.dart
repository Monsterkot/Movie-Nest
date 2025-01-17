import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_nest_app/router/router.gr.dart';
import 'package:movie_nest_app/theme/app_button_style.dart';
import 'package:movie_nest_app/theme/app_text_field_style.dart';
import '../../../blocs/auth_bloc/auth_bloc.dart';
import '../../../blocs/url_launcher_bloc/url_launcher_bloc.dart';
import '../../../generated/l10n.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({super.key});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _loginTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  bool _isSnackBarVisible = false;
  bool _obscureText = true;
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(
      () {
        if (!_focusNode.hasFocus) {
          setState(() {
            _obscureText = true;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _showSnackbar(String message) {
    if (_isSnackBarVisible) return;
    _isSnackBarVisible = true;
    final snackBar = SnackBar(
      backgroundColor: Colors.grey.withValues(alpha: 0.4),
      content: Text(message),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.fixed,
      elevation: 10,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar).closed.then(
      (_) {
        _isSnackBarVisible = false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              switch (state.errorCode) {
                case 1:
                  _showSnackbar(S.of(context).usernameAndPasswordFieldsMustBeFilledIn);
                  break;
                case 2:
                  _showSnackbar(S.of(context).unknownErrorTryAgainLater);
                  break;
                case 3:
                  _showSnackbar(S.of(context).invalidUsernameOrPassword);
                  break;
              }
              
            }
            if (state is AuthSuccess) {
              AutoRouter.of(context).replace(const MainHomeRoute());
            }
          },
        ),
        BlocListener<UrlLauncherBloc, UrlLauncherState>(
          listener: (context, state) {
            if (state is UrlLauncherLaunchFailure) {
              _showSnackbar(S.of(context).somethingWentWrong);
            }
          },
        ),
      ],
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final authInProcess = state is AuthLoading;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.of(context).username,
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: _loginTextController,
                  enabled: authInProcess ? false : true,
                  decoration: AppTextFieldStyle.textFieldDecorator,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  S.of(context).password,
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: _passwordTextController,
                  focusNode: _focusNode,
                  enabled: authInProcess ? false : true,
                  decoration: AppTextFieldStyle.textFieldDecorator.copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  obscureText: _obscureText,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: authInProcess
                          ? null
                          : () {
                              context.read<AuthBloc>().add(AuthLoginEvent(
                                    _loginTextController.text,
                                    _passwordTextController.text,
                                  ));
                            },
                      style: authInProcess
                          ? AppButtonStyle.inactiveButtonStyle
                          : AppButtonStyle.buttonStyle,
                      child: Text(S.of(context).login),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        context
                            .read<UrlLauncherBloc>()
                            .add(LaunchUrlLauncherEvent('/reset-password'));
                      },
                      style: AppButtonStyle.linkButtonStyle,
                      child: Text(S.of(context).resetPassword),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
