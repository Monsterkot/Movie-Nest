import 'package:flutter/material.dart';
import 'package:movie_nest_app/theme/app_box_decoration_style.dart';
import 'package:movie_nest_app/theme/app_text_style.dart';

class ActorMainInfoWidget extends StatelessWidget {
  const ActorMainInfoWidget({super.key});

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
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: const Image(
                  image: AssetImage('lib/images/actor.png'),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Brad Pitt',
                style: AppTextStyle.bigWhiteTextStyle,
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  Text(
                    'Personal info',
                    style: AppTextStyle.middleWhiteTextStyle,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Stage Name',
                        style: AppTextStyle.small18WhiteBoldTextStyle,
                      ),
                      Text(
                        'Brad Pitt',
                        style: AppTextStyle.small16WhiteTextStyle,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 60,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Known For',
                        style: AppTextStyle.small18WhiteBoldTextStyle,
                      ),
                      Text(
                        'Acting',
                        style: AppTextStyle.small16WhiteTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Known Credits',
                        style: AppTextStyle.small18WhiteBoldTextStyle,
                      ),
                      Text(
                        '205',
                        style: AppTextStyle.small16WhiteTextStyle,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 60,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Gender',
                        style: AppTextStyle.small18WhiteBoldTextStyle,
                      ),
                      Text(
                        'Male',
                        style: AppTextStyle.small16WhiteTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Birthday',
                        style: AppTextStyle.small18WhiteBoldTextStyle,
                      ),
                      Text(
                        'December 18, 1963 (60 years old)',
                        style: AppTextStyle.small16WhiteTextStyle,
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Place of Birth',
                        style: AppTextStyle.small18WhiteBoldTextStyle,
                      ),
                      Text(
                        'Shawnee, Oklahoma, USA',
                        style: AppTextStyle.small16WhiteTextStyle,
                      ),
                    ],
                  )
                ],
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
