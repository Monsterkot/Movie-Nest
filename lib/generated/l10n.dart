// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome!`
  String get welcome {
    return Intl.message(
      'Welcome!',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Search...`
  String get search {
    return Intl.message(
      'Search...',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Movies`
  String get movies {
    return Intl.message(
      'Movies',
      name: 'movies',
      desc: '',
      args: [],
    );
  }

  /// `TV series`
  String get tvSeries {
    return Intl.message(
      'TV series',
      name: 'tvSeries',
      desc: '',
      args: [],
    );
  }

  /// `Trending`
  String get trending {
    return Intl.message(
      'Trending',
      name: 'trending',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get favorites {
    return Intl.message(
      'Favorites',
      name: 'favorites',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get logOut {
    return Intl.message(
      'Log out',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Route error`
  String get routeError {
    return Intl.message(
      'Route error',
      name: 'routeError',
      desc: '',
      args: [],
    );
  }

  /// `Log in to your account`
  String get logInToYourAccount {
    return Intl.message(
      'Log in to your account',
      name: 'logInToYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `To use the editing and rating features of TMDB, as well as to receive personal recommendations, you must log in to your account. If you don\'t have an account, registering it is free and easy. `
  String get loginInstructions {
    return Intl.message(
      'To use the editing and rating features of TMDB, as well as to receive personal recommendations, you must log in to your account. If you don\\\'t have an account, registering it is free and easy. ',
      name: 'loginInstructions',
      desc: '',
      args: [],
    );
  }

  /// `Click here to register.`
  String get clickHereToRegister {
    return Intl.message(
      'Click here to register.',
      name: 'clickHereToRegister',
      desc: '',
      args: [],
    );
  }

  /// `If you have registered but have not received a confirmation email. `
  String get confirmEmailText {
    return Intl.message(
      'If you have registered but have not received a confirmation email. ',
      name: 'confirmEmailText',
      desc: '',
      args: [],
    );
  }

  /// `Click here to confirm email.`
  String get clickHereToConfirmEmail {
    return Intl.message(
      'Click here to confirm email.',
      name: 'clickHereToConfirmEmail',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Reset password`
  String get resetPassword {
    return Intl.message(
      'Reset password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Your Profile`
  String get yourProfile {
    return Intl.message(
      'Your Profile',
      name: 'yourProfile',
      desc: '',
      args: [],
    );
  }

  /// `View full profile`
  String get viewFullProfile {
    return Intl.message(
      'View full profile',
      name: 'viewFullProfile',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to log out?`
  String get areYouSureYouWantToLogOut {
    return Intl.message(
      'Are you sure you want to log out?',
      name: 'areYouSureYouWantToLogOut',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message(
      'Loading...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `User Score`
  String get userScore {
    return Intl.message(
      'User Score',
      name: 'userScore',
      desc: '',
      args: [],
    );
  }

  /// `Play Trailer`
  String get playTrailer {
    return Intl.message(
      'Play Trailer',
      name: 'playTrailer',
      desc: '',
      args: [],
    );
  }

  /// `Overview`
  String get overview {
    return Intl.message(
      'Overview',
      name: 'overview',
      desc: '',
      args: [],
    );
  }

  /// `Series Cast`
  String get seriesCast {
    return Intl.message(
      'Series Cast',
      name: 'seriesCast',
      desc: '',
      args: [],
    );
  }

  /// `Full Cast & Crew`
  String get fullCastCrew {
    return Intl.message(
      'Full Cast & Crew',
      name: 'fullCastCrew',
      desc: '',
      args: [],
    );
  }

  /// `Biography`
  String get biography {
    return Intl.message(
      'Biography',
      name: 'biography',
      desc: '',
      args: [],
    );
  }

  /// `Show Less`
  String get showLess {
    return Intl.message(
      'Show Less',
      name: 'showLess',
      desc: '',
      args: [],
    );
  }

  /// `Show More`
  String get showMore {
    return Intl.message(
      'Show More',
      name: 'showMore',
      desc: '',
      args: [],
    );
  }

  /// `Known For`
  String get knownFor {
    return Intl.message(
      'Known For',
      name: 'knownFor',
      desc: '',
      args: [],
    );
  }

  /// `Personal info`
  String get personalInfo {
    return Intl.message(
      'Personal info',
      name: 'personalInfo',
      desc: '',
      args: [],
    );
  }

  /// `Stage Name`
  String get stageName {
    return Intl.message(
      'Stage Name',
      name: 'stageName',
      desc: '',
      args: [],
    );
  }

  /// `Known Credits`
  String get knownCredits {
    return Intl.message(
      'Known Credits',
      name: 'knownCredits',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Birthday`
  String get birthday {
    return Intl.message(
      'Birthday',
      name: 'birthday',
      desc: '',
      args: [],
    );
  }

  /// `Deathday`
  String get deathday {
    return Intl.message(
      'Deathday',
      name: 'deathday',
      desc: '',
      args: [],
    );
  }

  /// `years`
  String get years {
    return Intl.message(
      'years',
      name: 'years',
      desc: '',
      args: [],
    );
  }

  /// `Place of Birth`
  String get placeOfBirth {
    return Intl.message(
      'Place of Birth',
      name: 'placeOfBirth',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong, check your internet connection`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong, check your internet connection',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Username and password fields must be filled in`
  String get usernameAndPasswordFieldsMustBeFilledIn {
    return Intl.message(
      'Username and password fields must be filled in',
      name: 'usernameAndPasswordFieldsMustBeFilledIn',
      desc: '',
      args: [],
    );
  }

  /// `Unknown error, try again later`
  String get unknownErrorTryAgainLater {
    return Intl.message(
      'Unknown error, try again later',
      name: 'unknownErrorTryAgainLater',
      desc: '',
      args: [],
    );
  }

  /// `Invalid username or password`
  String get invalidUsernameOrPassword {
    return Intl.message(
      'Invalid username or password',
      name: 'invalidUsernameOrPassword',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `This Week`
  String get thisWeek {
    return Intl.message(
      'This Week',
      name: 'thisWeek',
      desc: '',
      args: [],
    );
  }

  /// `Popular`
  String get popular {
    return Intl.message(
      'Popular',
      name: 'popular',
      desc: '',
      args: [],
    );
  }

  /// `Now Playing`
  String get nowPlaying {
    return Intl.message(
      'Now Playing',
      name: 'nowPlaying',
      desc: '',
      args: [],
    );
  }

  /// `Top Rated`
  String get topRated {
    return Intl.message(
      'Top Rated',
      name: 'topRated',
      desc: '',
      args: [],
    );
  }

  /// `Upcoming`
  String get upcoming {
    return Intl.message(
      'Upcoming',
      name: 'upcoming',
      desc: '',
      args: [],
    );
  }

  /// `Airing Today`
  String get airingToday {
    return Intl.message(
      'Airing Today',
      name: 'airingToday',
      desc: '',
      args: [],
    );
  }

  /// `On The Air`
  String get onTheAir {
    return Intl.message(
      'On The Air',
      name: 'onTheAir',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
