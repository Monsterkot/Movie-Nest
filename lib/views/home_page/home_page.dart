import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_nest_app/blocs/Search_bloc/search_bloc.dart';
import 'package:movie_nest_app/blocs/tv_show_bloc/tv_show_bloc.dart';
import 'package:movie_nest_app/router/router.gr.dart';
import 'package:movie_nest_app/theme/app_colors.dart';
import 'package:movie_nest_app/theme/app_text_style.dart';
import 'package:movie_nest_app/views/home_page/widgets/movie_list.dart';
import 'package:movie_nest_app/views/home_page/widgets/tv_shows_list.dart';
import 'package:movie_nest_app/views/widgets/custom_background.dart';

import '../../blocs/movie_bloc/movie_bloc.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0;
  bool _isSearching = false;
  final _searchController = TextEditingController();
  final _tvShowBloc = TvShowBloc();
  final _movieBloc = MovieBloc();

  void _loadMovies() {
    _movieBloc.add(LoadMovies());
  }

  void _loadTvShows() {
    _tvShowBloc.add(LoadTvShows());
  }

  void onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
    loadInfo(index);
    if (_isSearching) {
      _isSearching = false; // Сбрасываем состояние поиска
      _searchController.clear(); // Очищаем текстовое поле поиска
      context.read<SearchBloc>().add(ClearSearchQuery()); // Сбрасываем поиск
    }
  }

  void loadInfo(int index) {
    switch (index) {
      case 0:
        break;
      case 1:
        _loadMovies();
        break;
      case 2:
        _loadTvShows();
        break;
      default:
        break;
    }
  }

  void _openUserAccount() {
    AutoRouter.of(context).push(const AccountRoute());
  }

  void _searchMovie(String query) {
    if (_searchController.text.isNotEmpty) {
      context.read<SearchBloc>().add(SearchMovies(query: query));
    }
  }

  @override
  void initState() {
    super.initState();
    loadInfo(_selectedTab);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        title: _isSearching
            ? TextField(
                // onChanged: (query) {
                //   _searchMovie(query);
                // },
                onChanged: (query) {
                  _searchMovie(query);
                },
                controller: _searchController,
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.white60),
                  border: InputBorder.none,
                ),
              )
            : const Text(
                'MovieNest',
                style: AppTextStyle.middleWhiteTextStyle,
              ),
        leading: _isSearching
            ? null
            : IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
              ),
        actions: _isSearching
            ? [
                IconButton(
                  onPressed: () {
                    context.read<SearchBloc>().add(ClearSearchQuery());
                    setState(() {
                      _isSearching = false; // завершение поиска
                      _searchController.clear(); // очистка поля поиска
                    });
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ]
            : [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isSearching = true; // переключение в режим поиска
                    });
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _openUserAccount();
                  },
                  icon: const Icon(
                    Icons.account_circle,
                    color: Colors.white,
                  ),
                ),
              ],
      ),
      body: CustomPaint(
        size: Size.infinite,
        painter: BackgroundPainter(),
        child: IndexedStack(
          index: _selectedTab,
          children: [
            const Text(
              'News',
            ),
            MovieList(movieBloc: _movieBloc),
            TvShowsList(
              tvShowBloc: _tvShowBloc,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt),
            label: 'People',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_filter),
            label: 'Movies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv),
            label: 'TV series',
          ),
        ],
        onTap: onSelectTab,
      ),
    );
  }
}
