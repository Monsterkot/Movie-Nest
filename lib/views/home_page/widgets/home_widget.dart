import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_nest_app/blocs/movie_bloc/movie_bloc.dart';
import 'package:movie_nest_app/blocs/trending_bloc/trending_bloc.dart';
import 'package:movie_nest_app/blocs/tv_show_bloc/tv_show_bloc.dart';
import 'package:movie_nest_app/constants/app_constants.dart';
import 'package:movie_nest_app/models/trending_content/trending_item.dart';
import 'package:movie_nest_app/router/router.gr.dart';
import 'package:movie_nest_app/theme/app_colors.dart';
import 'package:movie_nest_app/views/widgets/loading_indicator.dart';
import '../../../generated/l10n.dart';
import '../../../models/movie/movie.dart';
import '../../../models/tv_show/tv_show.dart';
import '../../../theme/app_box_decoration_style.dart';
import '../../../theme/app_text_style.dart';
import '../../../utils/date_formatter.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  String? _trendingSelectedValue;
  String? _moviesSelectedValue;
  String? _tvSeriesSelectedValue;

  late MovieBloc _movieBloc;
  late TrendingBloc _trendingBloc;
  late TvShowBloc _tvShowBloc;
  String _currentTimeWindow = 'day';
  String _curentMovieFilter = 'Popular';
  String _curentTvShowFilter = 'Popular';

  @override
  void initState() {
    super.initState();

    _trendingBloc = TrendingBloc();
    _trendingBloc.add(LoadTrendings(timeWindow: _currentTimeWindow));
    _movieBloc = MovieBloc();
    _movieBloc.add(LoadMovieLists(filter: _curentMovieFilter));
    _tvShowBloc = TvShowBloc();
    _tvShowBloc.add(LoadTvShowLists(filter: _curentTvShowFilter));
  }

  @override
  void dispose() {
    _movieBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> trendingItems = [
      S.of(context).today,
      S.of(context).thisWeek,
    ];
    final List<String> movieListsItems = [
      S.of(context).popular,
      S.of(context).nowPlaying,
      S.of(context).topRated,
      S.of(context).upcoming,
    ];
    final List<String> tvSeriesItems = [
      S.of(context).popular,
      S.of(context).airingToday,
      S.of(context).onTheAir,
      S.of(context).topRated,
    ];
    _trendingSelectedValue ??= trendingItems.first;
    _moviesSelectedValue ??= movieListsItems.first;
    _tvSeriesSelectedValue ??= tvSeriesItems.first;
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieBloc>(
          create: (context) => _movieBloc,
        ),
        BlocProvider<TrendingBloc>(
          create: (context) => _trendingBloc,
        ),
        BlocProvider<TvShowBloc>(
          create: (context) => _tvShowBloc,
        ),
      ],
      child: RefreshIndicator(
        color: AppColors.mainColor,
        onRefresh: () async {
          _trendingBloc.add(LoadTrendings(timeWindow: _currentTimeWindow));
          _movieBloc.add(LoadMovieLists(filter: _curentMovieFilter));
          _tvShowBloc.add(LoadTvShowLists(filter: _curentTvShowFilter));
        },
        child: ListView(
          children: [
            _trendingContent(trendingItems),
            _movieLists(movieListsItems),
            _tvSeriesLists(tvSeriesItems),
          ],
        ),
      ),
    );
  }

  Widget _trendingContent(List<String> trendingItems) {
    final boxDecoration = AppBoxDecorationStyle.boxDecoration;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Container(
        decoration: boxDecoration,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).trending,
                    style: AppTextStyle.middleWhiteTextStyle,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: AppBoxDecorationStyle.dropDownBoxDecoration,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _trendingSelectedValue,
                        items: trendingItems.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _trendingSelectedValue = newValue;
                          });
                          if (newValue == 'Today' || newValue == 'Сегодня') {
                            _currentTimeWindow = 'day';
                          } else {
                            _currentTimeWindow = 'week';
                          }
                          _trendingBloc.add(LoadTrendings(timeWindow: _currentTimeWindow));
                        },
                        iconEnabledColor: Colors.blue,
                        iconSize: 30,
                        dropdownColor: Colors.black.withValues(alpha: 0.5),
                        style: AppTextStyle.small18WhiteTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 301,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: BlocBuilder<TrendingBloc, TrendingState>(
                  builder: (context, state) {
                    if (state is LoadTrendingSuccess) {
                      return Scrollbar(
                        radius: const Radius.circular(10),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.trendings.length,
                          itemExtent: 170,
                          itemBuilder: (BuildContext context, int index) {
                            final item = state.trendings[index];
                            return _trendingItem(item);
                          },
                        ),
                      );
                    } else if (state is LoadTrendingFailure) {
                      return Center(
                        child: Text(
                          S.of(context).somethingWentWrong,
                          style: AppTextStyle.middleWhiteTextStyle,
                        ),
                      );
                    } else {
                      return const LoadingIndicator();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _trendingItem(TrendingItem item) {
    String title;
    String releaseDate;
    String? posterPath;
    int? id;

    String mediaType = item.mediaType!;

    if (mediaType == 'movie') {
      // Кастуем item к типу Movie и извлекаем данные
      final movie = item as Movie;
      title = movie.title;
      releaseDate = DateFormatter.stringFromDate(movie.releaseDate);
      posterPath = movie.posterPath ?? 'lib/images/no_poster_avalible.png';
      id = movie.id;
    } else if (mediaType == 'tv') {
      // Кастуем item к типу TVShow и извлекаем данные
      final tvShow = item as TvShow;
      title = tvShow.name;
      releaseDate = DateFormatter.stringFromDate(tvShow.firstAirDate);
      posterPath = tvShow.posterPath ?? 'lib/images/no_poster_avalible.png';
      id = tvShow.id;
    } else {
      // Если тип неизвестен
      title = 'Unknown Media';
      releaseDate = 'Unknown';
      posterPath = 'lib/images/no_poster_avalible.png';
    }

    void openDetailsRoute(int id) {
      switch (mediaType) {
        case 'movie':
          AutoRouter.of(context).push(MovieDetailsRoute(movieId: id));
          break;
        case 'tv':
          AutoRouter.of(context).push(TvShowDetailsRoute(tvShowId: id));
          break;
        default:
          //AutoRouter.of(context).push(const ActorInfoRoute());
          break;
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          DecoratedBox(
            decoration: AppBoxDecorationStyle.boxDecoration,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              clipBehavior: Clip.hardEdge,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInImage(
                    placeholder: const AssetImage('lib/images/placeholder.png'),
                    image: NetworkImage('$imageUrl$posterPath'),
                    imageErrorBuilder: (context, error, stackTrace) {
                      return const Image(
                        image: AssetImage('lib/images/no_poster_avalible.png'),
                      );
                    },
                  ),
                  const SizedBox(height: 2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: AppTextStyle.small16WhiteTextStyle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          releaseDate,
                          style: AppTextStyle.small14White70TextStyle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                openDetailsRoute(id!);
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _movieLists(List<String> movieListsItems) {
    final boxDecoration = AppBoxDecorationStyle.boxDecoration;
    final filtersList = ['Popular', 'Now Playing', 'Top Rated', 'Upcoming'];
    final filtersMap = Map.fromIterables(movieListsItems, filtersList);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Container(
        decoration: boxDecoration,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).movies,
                    style: AppTextStyle.middleWhiteTextStyle,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: AppBoxDecorationStyle.dropDownBoxDecoration,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _moviesSelectedValue,
                        items: movieListsItems.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? movieFilter) {
                          setState(() {
                            _moviesSelectedValue = movieFilter;
                            _curentMovieFilter = filtersMap[movieFilter]!;
                          });
                          _movieBloc.add(LoadMovieLists(filter: _curentMovieFilter));
                        },
                        iconEnabledColor: Colors.blue,
                        iconSize: 30,
                        dropdownColor: Colors.black.withValues(alpha: 0.5),
                        style: AppTextStyle.small18WhiteTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 301,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: BlocBuilder<MovieBloc, MovieState>(
                  builder: (context, state) {
                    if (state is MovieLoadSuccess) {
                      final movies = state.movies;
                      return Scrollbar(
                        radius: const Radius.circular(10),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: movies.length,
                          itemExtent: 170,
                          itemBuilder: (BuildContext context, int index) {
                            final movie = movies[index];
                            return _movieItem(movie);
                          },
                        ),
                      );
                    } else if (state is MovieLoadFailure) {
                      return Center(
                        child: Text(
                          S.of(context).somethingWentWrong,
                          style: AppTextStyle.middleWhiteTextStyle,
                        ),
                      );
                    } else {
                      return const LoadingIndicator();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _movieItem(Movie movie) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          DecoratedBox(
            decoration: AppBoxDecorationStyle.boxDecoration,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              clipBehavior: Clip.hardEdge,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInImage(
                    placeholder: const AssetImage('lib/images/placeholder.png'),
                    image: NetworkImage('$imageUrl${movie.posterPath}'),
                    imageErrorBuilder: (context, error, stackTrace) {
                      return const Image(
                        image: AssetImage('lib/images/no_poster_avalible.png'),
                      );
                    },
                  ),
                  const SizedBox(height: 2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: AppTextStyle.small16WhiteTextStyle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          DateFormatter.stringFromDate(movie.releaseDate),
                          style: AppTextStyle.small14White70TextStyle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                AutoRouter.of(context).push(MovieDetailsRoute(movieId: movie.id));
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tvSeriesLists(List<String> tvSeriesItems) {
    final boxDecoration = AppBoxDecorationStyle.boxDecoration;
    final filtersList = ['Popular', 'Airing Today', 'On The Air', 'Top Rated'];
    final filtersMap = Map.fromIterables(tvSeriesItems, filtersList);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Container(
        decoration: boxDecoration,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.of(context).tvSeries,
                    style: AppTextStyle.middleWhiteTextStyle,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: AppBoxDecorationStyle.dropDownBoxDecoration,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _tvSeriesSelectedValue,
                        items: tvSeriesItems.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? tvShowFilter) {
                          setState(() {
                            _tvSeriesSelectedValue = tvShowFilter;
                            _curentTvShowFilter = filtersMap[tvShowFilter]!;
                          });
                          _tvShowBloc.add(LoadTvShowLists(filter: _curentTvShowFilter));
                        },
                        iconEnabledColor: Colors.blue,
                        iconSize: 30,
                        dropdownColor: Colors.black.withValues(alpha: 0.5),
                        style: AppTextStyle.small18WhiteTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 304,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: BlocBuilder<TvShowBloc, TvShowState>(
                  builder: (context, state) {
                    if (state is TvShowLoadSuccess) {
                      final tvShows = state.tvShows;
                      return Scrollbar(
                        radius: const Radius.circular(10),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: tvShows.length,
                          itemExtent: 170,
                          itemBuilder: (BuildContext context, int index) {
                            final tvShow = tvShows[index];
                            return _tvSeriesItem(tvShow);
                          },
                        ),
                      );
                    } else if (state is TvShowLoadFailure) {
                      return Center(
                        child: Text(
                          S.of(context).somethingWentWrong,
                          style: AppTextStyle.middleWhiteTextStyle,
                        ),
                      );
                    } else {
                      return const LoadingIndicator();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tvSeriesItem(TvShow tvShow) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          DecoratedBox(
            decoration: AppBoxDecorationStyle.boxDecoration,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              clipBehavior: Clip.hardEdge,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInImage(
                    height: 230,
                    placeholder: const AssetImage('lib/images/placeholder.png'),
                    image: NetworkImage('$imageUrl${tvShow.posterPath}'),
                    imageErrorBuilder: (context, error, stackTrace) {
                      return const Image(
                        image: AssetImage('lib/images/no_poster_avalible.png'),
                      );
                    },
                  ),
                  const SizedBox(height: 2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tvShow.name,
                          style: AppTextStyle.small18WhiteTextStyle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Text(
                          DateFormatter.stringFromDate(tvShow.firstAirDate),
                          style: AppTextStyle.small14White70TextStyle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                AutoRouter.of(context).push(TvShowDetailsRoute(tvShowId: tvShow.id));
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ],
      ),
    );
  }
}
