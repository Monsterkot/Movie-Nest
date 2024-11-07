import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_nest_app/blocs/movie_bloc/movie_bloc.dart';
import 'package:movie_nest_app/constants/app_constants.dart';
import 'package:movie_nest_app/theme/app_box_decoration_style.dart';
import 'package:movie_nest_app/theme/app_text_style.dart';
import 'package:movie_nest_app/utils/date_formatter.dart';
import '../../../blocs/Search_bloc/search_bloc.dart';
import '../../../router/router.gr.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key, required this.movieBloc});
  final MovieBloc movieBloc;
  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final ScrollController _scrollController = ScrollController();
  var _isSearching = false;
  //late SearchBloc _searchBloc;
  void _onMovieTap(int movieId) {
    AutoRouter.of(context).push(MovieDetailsRoute(movieId: movieId));
  }

  @override
  void initState() {
    super.initState();
    //_searchBloc = SearchBloc()..add();
    _scrollController.addListener(() {
      const threshold =
          3; // Количество элементов до конца списка для начала загрузки
      const itemExtent = 163; //высота одного элемента
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - threshold * itemExtent) {
        // Если достигнут конец списка с запасом, загружаем следующую страницу
        if (!widget.movieBloc.isLoadingInProgress && !_isSearching) {
          widget.movieBloc.add(LoadMovies());
        } else if (_isSearching) {
          context.read<SearchBloc>().add(LoadNextPage());
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
    return BlocBuilder<MovieBloc, MovieState>(
      bloc: widget.movieBloc,
      builder: (context, movieState) {
        if (movieState is MovieLoadFailure) {
          return Center(
            child: Text(
              movieState.message,
              style: AppTextStyle.middleWhiteTextStyle,
            ),
          );
        } else if (movieState is MovieLoadSuccess) {
          var movies = movieState.movies;

          return BlocBuilder<SearchBloc, SearchState>(
            builder: (context, searchState) {
              if (searchState is ResultsLoadSuccess) {
                movies = searchState.movies;
                _isSearching = true;
              }
              if (searchState is SearchQueryCleared) {
                movies = movieState.movies;
                _isSearching = false;
                WidgetsBinding.instance.addPostFrameCallback(
                  (_) {
                    _scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  },
                );
                context.read<SearchBloc>().add(ReturnToInitial());
              }
              if (searchState is SearchResultsIsLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                );
              }

              return ListView.builder(
                controller: _scrollController,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                itemCount: movies.length,
                itemExtent: 163,
                itemBuilder: (context, index) {
                  final movie = movies[index];
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
                                  ? Image(
                                      image: NetworkImage(
                                          '$imageUrl${movie.posterPath}'),
                                    )
                                  : Container(
                                      height: 210,
                                      width: 95,
                                      color: Colors.grey,
                                      child: const Icon(
                                        Icons.local_movies,
                                        color: Colors.white,
                                        size: 50,
                                      ),
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
                                      DateFormatter.stringFromDate(
                                          movie.releaseDate),
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            highlightColor:
                                Colors.blueGrey.shade400.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
        }
      },
    );
  }
}