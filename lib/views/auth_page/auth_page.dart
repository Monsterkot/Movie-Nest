import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_nest_app/theme/app_colors.dart';
import 'package:movie_nest_app/theme/app_text_style.dart';
import 'package:movie_nest_app/views/auth_page/widgets/form_widget.dart';
import 'package:movie_nest_app/views/auth_page/widgets/header_widget.dart';
import '../../blocs/auth_bloc/auth_bloc.dart';

@RoutePage()
class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                backgroundColor: AppColors.mainColor,
                title: const Text(
                  'Log in to your account',
                  style: AppTextStyle.middleWhiteTextStyle,
                ),
                centerTitle: true,
              ),
              body: Container(
                color: AppColors.mainColor,
                child: const Column(
                  children: [
                    HeaderWidget(),
                    FormWidget(),
                  ],
                ),
              ),
            ),
            if (state is AuthLoading)
              const ModalBarrier(
                dismissible: false,
                color: Colors.black54,
              ),
            if (state is AuthLoading)
              Center(
                child: CircularProgressIndicator(
                  color: Colors.lightBlue.shade600,
                ),
              ),
          ],
        );
      },
    );
  }
}
