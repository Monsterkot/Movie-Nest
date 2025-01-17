import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:like_button/like_button.dart';
import 'package:movie_nest_app/blocs/movie_details_bloc/movie_details_bloc.dart';
import 'package:movie_nest_app/generated/l10n.dart';
import 'package:movie_nest_app/repositories/movie_repository.dart';
import 'package:movie_nest_app/theme/app_text_style.dart';
import 'package:movie_nest_app/views/movie_details_page/widgets/movie_details_main_info_widget.dart';
import 'package:movie_nest_app/views/movie_details_page/widgets/movie_details_screen_cast_widget.dart';
import 'package:palette_generator/palette_generator.dart';
import '../../constants/app_constants.dart';
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
  Color _dominantColor = AppColors.mainColor;
  bool _paletteGenerated = false; // Флаг для отслеживания, была ли сгенерирована палитра
  @override
  void initState() {
    super.initState();
    _movieDetailsBloc = MovieDetailsBloc()..add(LoadMovieDetails(movieId: widget.movieId));
  }

  @override
  void dispose() {
    _movieDetailsBloc.close();
    super.dispose();
  }

  Future<bool> onLikeButtonTapped(bool isLiked, int movieId) async {
    await GetIt.I<MovieRepository>().toggleFavorite(movieId: movieId, isLiked: !isLiked);
    return !isLiked;
  }

  Future<void> _generatePalette(String posterPath) async {
    final generator = await PaletteGenerator.fromImageProvider(
      NetworkImage('$imageUrl$posterPath'),
      maximumColorCount: 10,
    );
    if (mounted) {
      setState(() {
        _dominantColor = generator.dominantColor?.color ?? AppColors.mainColor;
      });
    }
  }

  bool isColorLight(Color color) {
    // Используем формулу для определения яркости
    final double brightness = (0.299 * color.r + 0.587 * color.g + 0.114 * color.b);
    return brightness > 0.5; // Пороговое значение, можно настроить
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      bloc: _movieDetailsBloc,
      builder: (context, state) {
        bool isMovieFavorite = false;
        late int movieId;
        if (state is MovieDetailsLoadSuccess) {
          isMovieFavorite = state.isMovieFavorite;
          movieId = state.movieDetails.id;

          // Генерация палитры только один раз
          if (!_paletteGenerated && state.movieDetails.posterPath != null) {
            _paletteGenerated = true; // Устанавливаем флаг
            _generatePalette(state.movieDetails.posterPath!);
          }
        }
        final bool isLightColor = isColorLight(_dominantColor);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: _dominantColor,
            centerTitle: true,
            title: state is MovieDetailsLoadSuccess
                ? Text(
                    state.movieDetails.title,
                    style: isLightColor
                        ? AppTextStyle.middleBlackTextStyle
                        : AppTextStyle.middleWhiteTextStyle,
                  )
                : Text(
                    S.of(context).loading,
                    style: AppTextStyle.middleWhiteTextStyle,
                  ),
            leading: BackButton(
              color: isLightColor ? Colors.black : Colors.white,
            ),
            actions: state is MovieDetailsLoadSuccess
                ? [
                    LikeButton(
                      isLiked: isMovieFavorite,
                      onTap: (isLiked) => onLikeButtonTapped(isLiked, movieId),
                      padding: const EdgeInsets.only(right: 10),
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.favorite,
                          size: 30,
                          color: isLiked ? Colors.red : Colors.black87,
                        );
                      },
                    ),
                  ]
                : [
                    const SizedBox.shrink(),
                  ],
          ),
          body: Container(
            color: _dominantColor,
            child: state is MovieDetailsLoadFailure
                ? Center(
                    child: Text(
                      S.of(context).somethingWentWrong,
                      style: AppTextStyle.middleWhiteTextStyle,
                    ),
                  )
                : state is MovieDetailsLoadSuccess
                    ? ListView(
                        children: [
                          MovieDetailsMainInfoWidget(movieDetails: state.movieDetails),
                          MovieDetailsMainScreenCastWidget(
                              movieDetailsCredits: state.movieDetails.credits),
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
