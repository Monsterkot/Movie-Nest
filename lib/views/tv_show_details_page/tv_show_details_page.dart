import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:like_button/like_button.dart';
import 'package:movie_nest_app/blocs/tv_show_details_bloc/tv_show_details_bloc.dart';
import 'package:movie_nest_app/repositories/tv_show_repository.dart';
import 'package:movie_nest_app/theme/app_text_style.dart';
import 'package:movie_nest_app/views/tv_show_details_page/widgets/tv_show_details_main_info_widget.dart';
import 'package:movie_nest_app/views/tv_show_details_page/widgets/tv_show_details_screen_cast_widget.dart';
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
    _tvShowDetailsBloc = TvShowDetailsBloc()..add(LoadTvShowDetails(tvShowId: widget.tvShowId));
  }

  Future<bool> onLikeButtonTapped(bool isLiked, int tvShowId) async {
    await GetIt.I<TvShowRepository>().toggleFavorite(tvShowId: tvShowId, isLiked: !isLiked);
    return !isLiked;
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
        }
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
                          color: isLiked ? Colors.red : Colors.black,
                        );
                      },
                    ),
                  ]
                : [
                    const SizedBox.shrink(),
                  ],
          ),
          body: Container(
            color: AppColors.mainColor,
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
