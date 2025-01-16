import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_nest_app/blocs/movie_bloc/movie_bloc.dart';
import 'package:movie_nest_app/blocs/tv_show_bloc/tv_show_bloc.dart';
import 'package:movie_nest_app/models/tv_show/tv_show.dart';
import 'package:movie_nest_app/theme/app_colors.dart';
import 'package:movie_nest_app/theme/app_text_style.dart';

import '../../constants/app_constants.dart';
import '../../models/movie/movie.dart';
import '../../router/router.gr.dart';
import '../../theme/app_box_decoration_style.dart';
import '../../utils/date_formatter.dart';

@RoutePage()
class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});
  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final ScrollController _movieScrollController = ScrollController();
  final ScrollController _tvShowScrollController = ScrollController();
  final List<String> _items = ['Movies', 'TV Shows'];
  String? _selectedItem;
  late MovieBloc _movieBloc;
  late TvShowBloc _tvShowBloc;
  @override
  void initState() {
    super.initState();
    _selectedItem = _items.first;
    _movieBloc = MovieBloc();
    _tvShowBloc = TvShowBloc();
    _movieBloc.add(LoadFavoriteMovies());
    _movieScrollController.addListener(() {
      const threshold = 3; // Количество элементов до конца списка для начала загрузки
      const itemExtent = 163; // Высота одного элемента
      if (_movieScrollController.position.pixels >=
          _movieScrollController.position.maxScrollExtent - threshold * itemExtent) {
        // Если достигнут конец списка с запасом, загружаем следующую страницу
        if (_movieBloc.isLoadingInProgress) {
          _movieBloc.add(LoadFavoriteMovies());
        }
      }
    });
    _tvShowScrollController.addListener(() {
      const threshold = 3; // Количество элементов до конца списка для начала загрузки
      const itemExtent = 163; // Высота одного элемента
      if (_tvShowScrollController.position.pixels >=
          _tvShowScrollController.position.maxScrollExtent - threshold * itemExtent) {
        // Если достигнут конец списка с запасом, загружаем следующую страницу
        if (_tvShowBloc.isLoadingInProgress) {
          _tvShowBloc.add(LoadFavoriteTvShows());
        }
      }
    });
  }

  @override
  void dispose() {
    _movieScrollController.dispose();
    _tvShowScrollController.dispose();
    super.dispose();
  }

  void _onMovieTap(int movieId) {
    AutoRouter.of(context).push(MovieDetailsRoute(movieId: movieId));
  }

  void _onTvShowTap(int tvShowId) {
    AutoRouter.of(context).push(TvShowDetailsRoute(tvShowId: tvShowId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        title: const Text(
          'Favorites',
          style: AppTextStyle.middleWhiteTextStyle,
        ),
        leading: const BackButton(),
      ),
      body: Container(
        color: AppColors.mainColor,
        child: Column(
          children: [
            _dropdownButton(),
            Expanded(
              child: _selectedItem == _items.first ? _favoriteMovieList() : _favoriteTvShowList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dropdownButton() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: AppBoxDecorationStyle.dropDownBoxDecoration,
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _selectedItem,
            items: _items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedItem = newValue;
              });
              _selectedItem == 'Movies'
                  ? _movieBloc.add(LoadFavoriteMovies())
                  : _tvShowBloc.add(LoadFavoriteTvShows());
            },
            iconEnabledColor: Colors.blue,
            iconSize: 30,
            dropdownColor: Colors.black.withValues(alpha: 0.5),
            style: AppTextStyle.small18WhiteTextStyle,
          ),
        ),
      ),
    );
  }

  Widget _circularProgressIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.blue,
      ),
    );
  }

  Widget _favoriteMovieList() {
    return BlocBuilder<MovieBloc, MovieState>(
      bloc: _movieBloc,
      builder: (context, movieState) {
        if (movieState is MovieLoadFailure) {
          return Center(
            child: Text(
              movieState.message,
              style: AppTextStyle.middleWhiteTextStyle,
            ),
          );
        } else if (movieState is MovieLoading) {
          return _circularProgressIndicator();
        } else if (movieState is MovieLoadSuccess) {
          var movies = movieState.movies;
          return _movieList(movies);
        } else {
          return _circularProgressIndicator();
        }
      },
    );
  }

  Widget _favoriteTvShowList() {
    return BlocBuilder<TvShowBloc, TvShowState>(
      bloc: _tvShowBloc,
      builder: (context, tvShowState) {
        if (tvShowState is TvShowLoadFailure) {
          return Center(
            child: Text(
              tvShowState.message,
              style: AppTextStyle.middleWhiteTextStyle,
            ),
          );
        } else if (tvShowState is TvShowLoading) {
          return _circularProgressIndicator();
        } else if (tvShowState is TvShowLoadSuccess) {
          var tvShows = tvShowState.tvShows;
          return _tvShowList(tvShows);
        } else {
          return _circularProgressIndicator();
        }
      },
    );
  }

  Widget _movieList(List<Movie> movies) {
    return ListView.builder(
      controller: _movieScrollController,
      itemCount: movies.length,
      itemExtent: 163,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return _buildMovieItem(movie);
      },
    );
  }

  Widget _tvShowList(List<TvShow> tvShows) {
    return ListView.builder(
      controller: _tvShowScrollController,
      itemCount: tvShows.length,
      itemExtent: 163,
      itemBuilder: (context, index) {
        final tvShow = tvShows[index];
        return _buildTvShowItem(tvShow);
      },
    );
  }

  Widget _buildMovieItem(Movie movie) {
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
                movie.posterPath != null
                    ? FadeInImage(
                        placeholder: const AssetImage('lib/images/placeholder.png'),
                        image: NetworkImage('$imageUrl${movie.posterPath}'),
                        imageErrorBuilder: (context, error, stackTrace) {
                          return const Image(
                            image: AssetImage('lib/images/no_poster_avalible.png'),
                          );
                        },
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
                        movie.title,
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
                        DateFormatter.stringFromDate(movie.releaseDate),
                        style: TextStyle(
                          color: Colors.blueGrey.shade300,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        movie.overview,
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
                _onMovieTap(movie.id);
              },
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              highlightColor: Colors.blueGrey.shade400.withValues(alpha: 0.5),
            ),
          ),
        ],
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
                        imageErrorBuilder: (context, error, stackTrace) {
                          return const Image(
                            image: AssetImage('lib/images/no_poster_avalible.png'),
                          );
                        },
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
                      tvShow.overview != null
                          ? Text(
                              tvShow.overview!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            )
                          : const SizedBox.shrink(),
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
              highlightColor: Colors.blueGrey.shade400.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}
