import 'package:flutter/material.dart';
import 'package:movie_nest_app/blocs/tv_show_bloc/tv_show_bloc.dart' as tv_show_block;
import 'package:movie_nest_app/theme/app_colors.dart';
import 'package:movie_nest_app/theme/app_text_style.dart';
import 'package:movie_nest_app/views/home_page/widgets/home_widget.dart';
import 'package:movie_nest_app/views/home_page/widgets/movie_list.dart';
import 'package:movie_nest_app/views/home_page/widgets/tv_shows_list.dart';
import '../../blocs/movie_bloc/movie_bloc.dart' as movie_block;
import '../../generated/l10n.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0;
  bool _isSearching = false;
  final _searchController = TextEditingController();
  final _tvShowBloc = tv_show_block.TvShowBloc();
  final _movieBloc = movie_block.MovieBloc();
  double xOffset = 0;
  double yOffset = 0;
  bool isDrawerOpen = false;

  void _loadMovies() {
    _movieBloc.add(movie_block.LoadPopularMovies());
  }

  void _loadTvShows() {
    _tvShowBloc.add(tv_show_block.LoadTvShows());
  }

  void _onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
    if (_isSearching) {
      _isSearching = false; // Сбрасываем состояние поиска
      _searchController.clear(); // Очищаем текстовое поле поиска
      _clearQuery();
    }
    _loadInfo(index);
  }

  void _loadInfo(int index) {
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

  void _searchContent(String query) {
    switch (_selectedTab) {
      case 0:
        break;
      case 1:
        _movieBloc.add(movie_block.SearchMovies(query: query));
        break;
      case 2:
        _tvShowBloc.add(tv_show_block.SearchTvShows(query: query));
        break;
      default:
        break;
    }
  }

  void _clearQuery() {
    switch (_selectedTab) {
      case 0:
        break;
      case 1:
        _movieBloc.add(movie_block.ClearSearchQuery());
        break;
      case 2:
        _tvShowBloc.add(tv_show_block.ClearSearchQuery());
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _loadInfo(_selectedTab);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(isDrawerOpen ? 0.85 : 1.00)
        ..rotateZ(isDrawerOpen ? -50 : 0),
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: isDrawerOpen ? BorderRadius.circular(40) : BorderRadius.circular(0),
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          centerTitle: true,
          title: _isSearching
              ? TextField(
                  onSubmitted: (query) {
                    _searchContent(query);
                  },
                  onChanged: (query) {
                    _searchContent(query);
                  },
                  controller: _searchController,
                  autofocus: true,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: S.of(context).search,
                    hintStyle: const TextStyle(color: Colors.white60),
                    border: InputBorder.none,
                  ),
                )
              : Text(
                  S.of(context).welcome,
                  style: AppTextStyle.middleWhiteTextStyle,
                ),
          leading: _isSearching
              ? null
              : isDrawerOpen
                  ? GestureDetector(
                      child: const Icon(Icons.arrow_back),
                      onTap: () {
                        setState(() {
                          xOffset = 0;
                          yOffset = 0;
                          isDrawerOpen = false;
                        });
                      },
                    )
                  : GestureDetector(
                      child: const Icon(Icons.menu),
                      onTap: () {
                        setState(() {
                          xOffset = 290;
                          yOffset = 80;
                          isDrawerOpen = true;
                        });
                      },
                    ),
          actions: _isSearching
              ? [
                  IconButton(
                    onPressed: () {
                      _clearQuery();
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
                  _selectedTab != 0
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _isSearching = true; // переключение в режим поиска
                            });
                          },
                          icon: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
        ),
        body: Container(
          color: AppColors.mainColor,
          child: IndexedStack(
            index: _selectedTab,
            children: [
              const HomeWidget(),
              MovieList(movieBloc: _movieBloc),
              TvShowsList(
                tvShowBloc: _tvShowBloc,
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColors.mainColor,
          currentIndex: _selectedTab,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: S.of(context).home,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.movie_filter),
              label: S.of(context).movies,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.tv),
              label: S.of(context).tvSeries,
            ),
          ],
          onTap: _onSelectTab,
        ),
      ),
    );
  }
}
