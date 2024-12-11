import 'package:flutter/material.dart';
import 'package:movie_nest_app/theme/app_box_decoration_style.dart';
import 'package:movie_nest_app/theme/app_button_style.dart';
import 'package:movie_nest_app/theme/app_text_style.dart';

class ActorBiographyWidget extends StatefulWidget {
  const ActorBiographyWidget({super.key, required this.biography});
  final String biography;
  @override
  State<ActorBiographyWidget> createState() => _ActorBiographyWidgetState();
}

class _ActorBiographyWidgetState extends State<ActorBiographyWidget> {
  bool _isExpanded = false;

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
                widget.biography,
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
