import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_nest_app/blocs/account_info_bloc/account_info_bloc.dart';
import 'package:movie_nest_app/theme/app_colors.dart';
import 'package:movie_nest_app/views/account_page/widgets/profile_card.dart';
import 'package:movie_nest_app/views/account_page/widgets/view_full_profile_button.dart';
import '../../theme/app_text_style.dart';
import 'widgets/log_out_button.dart';

@RoutePage()
class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountInfoBloc()..add(LoadAccountInfoEvent()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          centerTitle: true,
          title: const Text(
            'Your Profile',
            style: AppTextStyle.middleWhiteTextStyle,
          ),
        ),
        body: Container(
          color: AppColors.mainColor,
          child: BlocBuilder<AccountInfoBloc, AccountInfoState>(
            builder: (context, state) {
              if (state is AccountInfoLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.lightBlue.shade600,
                  ),
                );
              } else if (state is AccountInfoLoaded) {
                return ListView(
                  children: [
                    ProfileCard(accountInfo: state.accountInfo),
                    ViewFullProfileButton(username: state.accountInfo.username),
                    const LogOutButton(),
                  ],
                );
              } else if (state is AccountInfoError) {
                return Center(
                    child: Text(
                  state.message,
                  style: AppTextStyle.middleWhiteTextStyle,
                ));
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
