import 'package:flutter/material.dart';
import 'package:movie_nest_app/theme/app_box_decoration_style.dart';
import 'package:movie_nest_app/theme/app_button_style.dart';
import 'package:movie_nest_app/theme/app_text_style.dart';

class ActorBiographyWidget extends StatefulWidget {
  const ActorBiographyWidget({super.key});

  @override
  State<ActorBiographyWidget> createState() => _ActorBiographyWidgetState();
}

class _ActorBiographyWidgetState extends State<ActorBiographyWidget> {
  bool _isExpanded = false;
  final String _fullBiography =
      "William Bradley Pitt (born December 18, 1963) is an American actor and film producer. He is the recipient of various accolades, including an Academy Award, a British Academy Film Award, and two Golden Globe Awards for his acting, in addition to a second Academy Award, a second British Academy Film Award, and a third Golden Globe Award as a producer under his production company, Plan B Entertainment.";
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        decoration: AppBoxDecorationStyle.boxDecoration,
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Biography',
                style: AppTextStyle.middleWhiteTextStyle,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                _fullBiography,
                maxLines: _isExpanded ? 200 : 5,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.small18WhiteTextStyle,
                textAlign: TextAlign.justify,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    style: AppButtonStyle.linkButtonStyle,
                    onPressed: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    child: Text(
                      _isExpanded ? 'Show Less' : 'Show More',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
