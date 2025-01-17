import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:like_button/like_button.dart';
import 'package:movie_nest_app/blocs/tv_show_details_bloc/tv_show_details_bloc.dart';
import 'package:movie_nest_app/generated/l10n.dart';
import 'package:movie_nest_app/repositories/tv_show_repository.dart';
import 'package:movie_nest_app/theme/app_text_style.dart';
import 'package:movie_nest_app/views/tv_show_details_page/widgets/tv_show_details_main_info_widget.dart';
import 'package:movie_nest_app/views/tv_show_details_page/widgets/tv_show_details_screen_cast_widget.dart';
import 'package:palette_generator/palette_generator.dart';
import '../../constants/app_constants.dart';
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
  Color _dominantColor = AppColors.mainColor;
  bool _paletteGenerated = false;
  @override
  void initState() {
    super.initState();
    _tvShowDetailsBloc = TvShowDetailsBloc()..add(LoadTvShowDetails(tvShowId: widget.tvShowId));
  }

  Future<bool> onLikeButtonTapped(bool isLiked, int tvShowId) async {
    await GetIt.I<TvShowRepository>().toggleFavorite(tvShowId: tvShowId, isLiked: !isLiked);
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
    return BlocBuilder<TvShowDetailsBloc, TvShowDetailsState>(
      bloc: _tvShowDetailsBloc,
      builder: (context, state) {
        bool isTvShowFavorite = false;
        late int tvShowId;
        if (state is TvShowDetailsLoadSuccess) {
          isTvShowFavorite = state.isTvShowFavorite;
          tvShowId = state.tvShowDetails.id;

          // Генерация палитры только один раз
          if (!_paletteGenerated && state.tvShowDetails.posterPath != null) {
            _paletteGenerated = true; // Устанавливаем флаг
            _generatePalette(state.tvShowDetails.posterPath!);
          }
        }
        final bool isLightColor = isColorLight(_dominantColor);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: _dominantColor,
            centerTitle: true,
            title: state is TvShowDetailsLoadSuccess
                ? Text(
                    state.tvShowDetails.name, // Используем название фильма
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
            actions: state is TvShowDetailsLoadSuccess
                ? [
                    LikeButton(
                      isLiked: isTvShowFavorite,
                      onTap: (isLiked) => onLikeButtonTapped(isLiked, tvShowId),
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
            child: state is TvShowDetailsLoadFailure
                ? Center(
                    child: Text(
                      S.of(context).somethingWentWrong,
                      style: AppTextStyle.middleWhiteTextStyle,
                    ),
                  )
                : state is TvShowDetailsLoadSuccess
                    ? ListView(
                        children: [
                          TvShowDetailsMainInfoWidget(tvShowDetails: state.tvShowDetails),
                          TvShowDetailsMainScreenCastWidget(
                              tvShowCredits: state.tvShowDetails.credits),
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
