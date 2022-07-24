import 'package:flutter/material.dart';
import 'package:themoviedb/Library/Widget/Inherited/provider.dart';
import 'package:themoviedb/widgets/main_screen/main_screen_model.dart';
import 'package:themoviedb/widgets/movie_details/movie_details_model.dart';
import 'package:themoviedb/widgets/movie_trailer/movie_trailer_widget.dart';

import '../../widgets/auth/auth_model.dart';
import '../../widgets/auth/auth_widget.dart';
import '../../widgets/main_screen/main_screen_widget.dart';
import '../../widgets/movie_details/movie_details_widget.dart';

abstract class MainNavigatorRoutesName {
  static const auth = 'auth';
  static const mainScreen = '/';
  static const movieDetails = '/movie_details';
  static const movieTrailerWidget = '/movie_details/trailer';
}

class MainNavigator {
  String initialRoute(bool isAuth) => isAuth
      ? MainNavigatorRoutesName.mainScreen
      : MainNavigatorRoutesName.auth;

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigatorRoutesName.auth: (context) => NotifierProvider(
          create: () => AuthModel(),
          child: const AuthWidget(),
        ),
    MainNavigatorRoutesName.mainScreen: (context) => NotifierProvider(
          create: () => MainScreenModel(),
          child: const MainScreenWidget(),
        )
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigatorRoutesName.movieDetails:
        final arguments = settings.arguments;
        final movieId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
          builder: (context) => NotifierProvider(
            create: () => MovieDetaislModel(movieId),
            child: const MovieDetailsWidget(),
          ),
        );

      case MainNavigatorRoutesName.movieTrailerWidget:
        final arguments = settings.arguments;
        final youtubeKey = arguments is String ? arguments : '';
        return MaterialPageRoute(
          builder: (context) => MovieTrailerWidget(youtubeKey: youtubeKey),
        );

      default:
        const widget = Text('Navigation error!!!');
        return MaterialPageRoute(builder: ((context) => widget));
    }
  }
}
