import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_nest_app/blocs/movie_details_bloc/movie_details_bloc.dart';
import 'package:movie_nest_app/theme/app_text_style.dart';
import 'package:movie_nest_app/views/movie_details_page/widgets/movie_details_main_info_widget.dart';
import 'package:movie_nest_app/views/movie_details_page/widgets/movie_details_screen_cast_widget.dart';
import 'package:movie_nest_app/views/widgets/custom_background.dart';
import '../../theme/app_colors.dart';

@RoutePage()
class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({
    super.key,
    required this.movieId,
  });

  final int movieId;

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late MovieDetailsBloc _movieDetailsBloc;

  @override
  void initState() {
    super.initState();
    _movieDetailsBloc = MovieDetailsBloc()
      ..add(LoadMovieDetails(movieId: widget.movieId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      bloc: _movieDetailsBloc,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.mainColor,
            centerTitle: true,
            title: state is MovieDetailsLoadSuccess
                ? Text(
                    state.movieDetails.title, // Используем название фильма
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
            child: state is MovieDetailsLoadFailure
                ? Center(
                    child: Text(
                      state.message,
                      style: AppTextStyle.middleWhiteTextStyle,
                    ),
                  )
                : state is MovieDetailsLoadSuccess
                    ? ListView(
                        children: [
                          MovieDetailsMainInfoWidget(
                              movieDetails: state.movieDetails),
                          const MovieDetailsMainScreenCastWidget(),
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
