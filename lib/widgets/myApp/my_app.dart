import 'package:flutter/material.dart';
import 'package:themoviedb/Library/Widget/Inherited/provider.dart';
import 'package:themoviedb/widgets/myApp/my_app_modal.dart';

import '../../Theme/app_colors.dart';
import '../../ui/navigator/main_navigator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatelessWidget {
  static final mainNavigation = MainNavigator();

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.read<MyAppModel>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            backgroundColor: AppColors.mainDarkBlue,
          ),
          appBarTheme:
              const AppBarTheme(backgroundColor: AppColors.mainDarkBlue)),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('uk'),
        Locale.fromSubtags(languageCode: 'zh'),
      ],
      routes: mainNavigation.routes,
      onGenerateRoute: mainNavigation.onGenerateRoute,
      initialRoute: mainNavigation.initialRoute(model?.isAuth == true),
      // onGenerateRoute: (RouteSettings settings) {
      //   return MaterialPageRoute(builder: (context) {
      //     return const Scaffold(
      //       body: Center(child: Text('Помилка навігації')),
      //     );
      //   });
      // },
    );
  }
}
