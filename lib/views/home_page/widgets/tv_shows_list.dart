import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_nest_app/blocs/tv_show_bloc/tv_show_bloc.dart';
import 'package:movie_nest_app/constants/app_constants.dart';
import 'package:movie_nest_app/theme/app_box_decoration_style.dart';
import 'package:movie_nest_app/theme/app_text_style.dart';
import 'package:movie_nest_app/utils/date_formatter.dart';
import '../../../models/tv_show/tv_show.dart';
import '../../../router/router.gr.dart';

class TvShowsList extends StatefulWidget {
  const TvShowsList({super.key, required this.tvShowBloc});
  final TvShowBloc tvShowBloc;
  @override
  State<TvShowsList> createState() => _TvShowsListState();
}

class _TvShowsListState extends State<TvShowsList> {
  final ScrollController _scrollController = ScrollController();

  void _onTvShowTap(int tvShowId) {
    AutoRouter.of(context).push(TvShowDetailsRoute(tvShowId: tvShowId));
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      const threshold =
          3; // Количество элементов до конца списка для начала загрузки
      const itemExtent = 163; // Высота одного элемента
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - threshold * itemExtent) {
        // Если достигнут конец списка с запасом, загружаем следующую страницу
        if (!widget.tvShowBloc.isLoadingInProgress) {
          widget.tvShowBloc.add(LoadTvShows());
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvShowBloc, TvShowState>(
      bloc: widget.tvShowBloc,
      builder: (context, movieState) {
        if (movieState is TvShowLoadFailure) {
          return Center(
            child: Text(
              movieState.message,
              style: AppTextStyle.middleWhiteTextStyle,
            ),
          );
        } else if (movieState is TvShowLoading) {
          return _circularProgressIndicator();
        } else if (movieState is TvShowsByQueryLoadSuccess) {
          var movies = movieState.tvShows;
          return _tvShowList(movies);
        } else if (movieState is TvShowLoadSuccess) {
          var movies = movieState.tvShows;
          return _tvShowList(movies);
        } else {
          return _circularProgressIndicator();
        }
      },
    );
  }

  Widget _tvShowList(List<TvShow> tvShows) {
    return ListView.builder(
      controller: _scrollController,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: tvShows.length,
      itemExtent: 163,
      itemBuilder: (context, index) {
        final movie = tvShows[index];
        return _buildTvShowItem(movie);
      },
    );
  }

  Widget _circularProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.blue,
      ),
    );
  }

  Widget _buildTvShowItem(TvShow tvShow) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      child: Stack(
        children: [
          Container(
            decoration: AppBoxDecorationStyle.boxDecoration,
            clipBehavior: Clip.hardEdge,
            child: Row(
              children: [
                tvShow.posterPath != null
                    ? FadeInImage(
                        placeholder: const AssetImage('lib/images/placeholder.png'),
                        image: NetworkImage('$imageUrl${tvShow.posterPath}'),
                      )
                    : const Image(
                        image: AssetImage('lib/images/no_poster_avalible.png'),
                      ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 15),
                      Text(
                        tvShow.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        DateFormatter.stringFromDate(tvShow.firstAirDate),
                        style: TextStyle(
                          color: Colors.blueGrey.shade300,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        tvShow.overview ?? '',//TODO
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                _onTvShowTap(tvShow.id);
              },
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              highlightColor: Colors.blueGrey.shade400.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}
