import 'package:flutter/material.dart';
import '../../../theme/app_box_decoration_style.dart';
import '../../../theme/app_text_style.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? _trendingSelectedValue;
  String? _moviesSelectedValue;
  String? _tvSeriesSelectedValue;
  final List<String> _trendingItems = ['Today', 'This Week'];
  final List<String> _movieListsItems = [
    'Popular',
    'Now Playing',
    'Top rated',
    'Upcoming'
  ];
  final List<String> _tvSeriesItems = [
    'Popular',
    'Airing Today',
    'On The Air',
    'Top Rated'
  ];

  @override
  void initState() {
    super.initState();
    _trendingSelectedValue = _trendingItems.first;
    _moviesSelectedValue = _movieListsItems.first;
    _tvSeriesSelectedValue = _tvSeriesItems.first;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _trendingContent(),
        _movieLists(),
        _tvSeriesLists(),
      ],
    );
  }

  Widget _trendingContent() {
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
                  const Text(
                    'Trending',
                    style: AppTextStyle.middleWhiteTextStyle,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: AppBoxDecorationStyle.dropDownBoxDecoration,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _trendingSelectedValue,
                        items: _trendingItems.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _trendingSelectedValue = newValue;
                          });
                        },
                        iconEnabledColor: Colors.blue,
                        iconSize: 30,
                        dropdownColor: Colors.black.withOpacity(0.5),
                        style: AppTextStyle.small18WhiteTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 330,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Scrollbar(
                  radius: const Radius.circular(10),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 20,
                    itemExtent: 170,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            DecoratedBox(
                              decoration: AppBoxDecorationStyle.boxDecoration,
                              child: const ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                clipBehavior: Clip.hardEdge,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image(
                                      image:
                                          AssetImage('lib/images/poster.png'),
                                    ),
                                    SizedBox(height: 2),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'The Day of the Jackal',
                                            style: AppTextStyle
                                                .small18WhiteTextStyle,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                          Text(
                                            "Pam's Man",
                                            style: AppTextStyle
                                                .small14White70TextStyle,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          SizedBox(
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
                                  //AutoRouter.of(context).push(const ActorInfoRoute());
                                },
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _movieLists() {
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
                  const Text(
                    'Movies',
                    style: AppTextStyle.middleWhiteTextStyle,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: AppBoxDecorationStyle.dropDownBoxDecoration,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _moviesSelectedValue,
                        items: _movieListsItems.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _moviesSelectedValue = newValue;
                          });
                        },
                        iconEnabledColor: Colors.blue,
                        iconSize: 30,
                        dropdownColor: Colors.black.withOpacity(0.5),
                        style: AppTextStyle.small18WhiteTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 330,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Scrollbar(
                  radius: const Radius.circular(10),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 20,
                    itemExtent: 170,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            DecoratedBox(
                              decoration: AppBoxDecorationStyle.boxDecoration,
                              child: const ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                clipBehavior: Clip.hardEdge,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image(
                                      image:
                                          AssetImage('lib/images/poster.png'),
                                    ),
                                    SizedBox(height: 2),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'The Day of the Jackal',
                                            style: AppTextStyle
                                                .small18WhiteTextStyle,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                          Text(
                                            "Pam's Man",
                                            style: AppTextStyle
                                                .small14White70TextStyle,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          SizedBox(
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
                                  //AutoRouter.of(context).push(const ActorInfoRoute());
                                },
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tvSeriesLists() {
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
                  const Text(
                    'TV Series',
                    style: AppTextStyle.middleWhiteTextStyle,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: AppBoxDecorationStyle.dropDownBoxDecoration,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _tvSeriesSelectedValue,
                        items: _tvSeriesItems.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _tvSeriesSelectedValue = newValue;
                          });
                        },
                        iconEnabledColor: Colors.blue,
                        iconSize: 30,
                        dropdownColor: Colors.black.withOpacity(0.5),
                        style: AppTextStyle.small18WhiteTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 330,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Scrollbar(
                  radius: const Radius.circular(10),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 20,
                    itemExtent: 170,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            DecoratedBox(
                              decoration: AppBoxDecorationStyle.boxDecoration,
                              child: const ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                clipBehavior: Clip.hardEdge,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image(
                                      image:
                                          AssetImage('lib/images/poster.png'),
                                    ),
                                    SizedBox(height: 2),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'The Day of the Jackal',
                                            style: AppTextStyle
                                                .small18WhiteTextStyle,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                          Text(
                                            "Pam's Man",
                                            style: AppTextStyle
                                                .small14White70TextStyle,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          SizedBox(
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
                                  //AutoRouter.of(context).push(const ActorInfoRoute());
                                },
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
