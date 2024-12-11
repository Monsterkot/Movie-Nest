import 'package:flutter/material.dart';
import 'package:movie_nest_app/constants/app_constants.dart';
import 'package:movie_nest_app/models/person/person_details.dart';
import 'package:movie_nest_app/theme/app_box_decoration_style.dart';
import 'package:movie_nest_app/theme/app_text_style.dart';
import 'package:movie_nest_app/utils/date_formatter.dart';

class ActorMainInfoWidget extends StatelessWidget {
  const ActorMainInfoWidget({super.key, required this.actor});

  final PersonDetails actor;

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
                child: actor.profilePath == null
                    ? const Image(
                        image: AssetImage('lib/images/no_image_avalible.png'),
                      )
                    : FadeInImage(
                        placeholder: const AssetImage('lib/images/placeholder.png'),
                        image: NetworkImage('$imageUrl${actor.profilePath}'),
                      ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                actor.name,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Stage Name',
                        style: AppTextStyle.small18WhiteBoldTextStyle,
                      ),
                      Text(
                        actor.name,
                        style: AppTextStyle.small16WhiteTextStyle,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 60,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Known For',
                        style: AppTextStyle.small18WhiteBoldTextStyle,
                      ),
                      Text(
                        actor.knownForDepartment,
                        style: AppTextStyle.small16WhiteTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Known Credits',
                        style: AppTextStyle.small18WhiteBoldTextStyle,
                      ),
                      Text(
                        actor.combinedCredits.length.toString(),
                        style: AppTextStyle.small16WhiteTextStyle,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 60,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Gender',
                        style: AppTextStyle.small18WhiteBoldTextStyle,
                      ),
                      Text(
                        actor.gender.label,
                        style: AppTextStyle.small16WhiteTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Birthday',
                        style: AppTextStyle.small18WhiteBoldTextStyle,
                      ),
                      if (actor.deathday == null)
                        Text(
                          '${DateFormatter.stringFromDate(actor.birthday)} (${DateTime.now().year - actor.birthday!.year} years)',
                          style: AppTextStyle.small16WhiteTextStyle,
                        )
                      else ...[
                        //оператор развертывания
                        Text(
                          DateFormatter.stringFromDate(actor.birthday),
                          style: AppTextStyle.small16WhiteTextStyle,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Deathday',
                          style: AppTextStyle.small18WhiteBoldTextStyle,
                        ),
                        Text(
                          '${DateFormatter.stringFromDate(actor.deathday)} (${actor.deathday!.year - actor.birthday!.year} years)',
                          style: AppTextStyle.small16WhiteTextStyle,
                        ),
                      ]
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Place of Birth',
                        style: AppTextStyle.small18WhiteBoldTextStyle,
                      ),
                      Text(
                        actor.placeOfBirth,
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
