import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_nest_app/blocs/tv_show_details_bloc/tv_show_details_bloc.dart';
import 'package:movie_nest_app/theme/app_text_style.dart';
import 'package:movie_nest_app/views/tv_show_details/widgets/tv_show_details_main_info_widget.dart';
import 'package:movie_nest_app/views/tv_show_details/widgets/tv_show_details_screen_cast_widget.dart';
import 'package:movie_nest_app/views/widgets/custom_background.dart';
import '../../theme/app_colors.dart';

@RoutePage()
class TvShowDetailsScreen extends StatefulWidget {
  const TvShowDetailsScreen({
    super.key,
    required this.tvShowId,
  });

  final int tvShowId;

  @override
  State<TvShowDetailsScreen> createState() => _TvShowDetailsScreenState();
}

class _TvShowDetailsScreenState extends State<TvShowDetailsScreen> {
  late TvShowDetailsBloc _tvShowDetailsBloc;

  @override
  void initState() {
    super.initState();
    _tvShowDetailsBloc = TvShowDetailsBloc()
      ..add(LoadTvShowDetails(tvShowId: widget.tvShowId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvShowDetailsBloc, TvShowDetailsState>(
      bloc: _tvShowDetailsBloc,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.mainColor,
            centerTitle: true,
            title: state is TvShowDetailsLoadSuccess
                ? Text(
                    state.tvShowDetails.name, // Используем название фильма
                    style: AppTextStyle.middleWhiteTextStyle,
                  )
                : const Text(
                    'Loading...',
                    style: AppTextStyle.middleWhiteTextStyle,
                  ),
            leading: const BackButton(
              color: Colors.white,
            ),
          ),
          body: CustomPaint(
            painter: BackgroundPainter(),
            size: Size.infinite,
            child: state is TvShowDetailsLoadFailure
                ? Center(
                    child: Text(
                      state.message,
                      style: AppTextStyle.middleWhiteTextStyle,
                    ),
                  )
                : state is TvShowDetailsLoadSuccess
                    ? ListView(
                        children: [
                          TvShowDetailsMainInfoWidget(
                              tvShowDetails: state.tvShowDetails),
                          const TvShowDetailsMainScreenCastWidget(),
                          const SizedBox(height: 10),
                        ],
                      )
                    : const Center(
                        child: CircularProgressIndicator(color: Colors.blue),
                      ),
          ),
        );
      },
    );
  }
}
