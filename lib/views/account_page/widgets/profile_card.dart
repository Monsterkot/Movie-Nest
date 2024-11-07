import 'package:flutter/material.dart';
import 'package:movie_nest_app/constants/app_constants.dart';
import 'package:movie_nest_app/models/account_info.dart';
import '../../../theme/app_box_decoration_style.dart';
import '../../../theme/app_text_style.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, required this.accountInfo});
  final AccountInfo accountInfo;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: AppBoxDecorationStyle.boxDecoration,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              CircleAvatar(
                radius: 100,
                backgroundImage: accountInfo.avatarPath != ''
                    ? NetworkImage('$imageUrl${accountInfo.avatarPath}')
                    : const AssetImage('lib/images/account_avatar.png'),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                accountInfo.name,
                style: AppTextStyle.bigWhiteTextStyle,
              ),
              Text(
                accountInfo.username,
                style: AppTextStyle.middleGreyTextStyle,
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
