import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_nest_app/blocs/actor_details_bloc/person_bloc.dart';
import 'package:movie_nest_app/views/actor_details_page/widgets/actor_known_for.dart';
import 'package:movie_nest_app/views/actor_details_page/widgets/actor_main_info.dart';
import 'package:movie_nest_app/views/widgets/custom_background.dart';
import 'package:movie_nest_app/views/widgets/loading_indicator.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_style.dart';
import 'widgets/actor_biography.dart';

@RoutePage()
class ActorDetailsScreen extends StatefulWidget {
  const ActorDetailsScreen({super.key, required this.id});
  final int id;

  @override
  State<ActorDetailsScreen> createState() => _ActorDetailsScreenState();
}

class _ActorDetailsScreenState extends State<ActorDetailsScreen> {
  late PersonBloc _personBloc;

  @override
  void initState() {
    super.initState();

    _personBloc = PersonBloc();
    _personBloc.add(LoadPersonDetails(id: widget.id));
  }

  @override
  void dispose() {
    _personBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _personBloc,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          centerTitle: true,
          title: BlocBuilder<PersonBloc, PersonState>(
            builder: (context, state) {
              if (state is PersonDetailsLoadSuccess) {
                return Text(
                  state.person.name,
                  style: AppTextStyle.middleWhiteTextStyle,
                );
              } else if (state is PersonDetailsLoadFailure) {
                return const Text(
                  'Error',
                  style: AppTextStyle.middleWhiteTextStyle,
                );
              } else {
                return const Text(
                  'Loading...',
                  style: AppTextStyle.middleWhiteTextStyle,
                );
              }
            },
          ),
          leading: const BackButton(
            color: Colors.white,
          ),
        ),
        body: CustomPaint(
          size: Size.infinite,
          painter: BackgroundPainter(),
          child: BlocBuilder<PersonBloc, PersonState>(
            builder: (context, state) {
              if (state is PersonDetailsLoadSuccess) {
                return ListView(
                  children: [
                    ActorMainInfoWidget(actor: state.person),
                    state.person.biography == ''
                        ? const SizedBox.shrink()
                        : ActorBiographyWidget(biography: state.person.biography),
                    ActorKnownForWidget(combinedCredits: state.person.combinedCredits),
                    const SizedBox(height: 10),
                  ],
                );
              } else if (state is PersonDetailsLoadFailure) {
                return Text(
                  state.message,
                  style: AppTextStyle.middleWhiteTextStyle,
                );
              } else {
                return const LoadingIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
