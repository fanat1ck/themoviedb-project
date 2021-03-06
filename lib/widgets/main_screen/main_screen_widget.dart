import 'package:flutter/material.dart';
import 'package:themoviedb/Library/Widget/Inherited/provider.dart';
import 'package:themoviedb/widgets/movie_list/movie_list_model.dart';

import '../movie_list/movie_list_widget.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({Key? key}) : super(key: key);

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {
  int _selectedTab = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final modelMovieList = MovieListModel();

  void onSelectTab(int index) {
    if (_selectedTab != index) {
      _selectedTab = index;
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    modelMovieList.setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    // final model = NotifierProvider.read<MainScreenModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('TMDB'),
          centerTitle: true,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedTab,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Новини'),
            BottomNavigationBarItem(
                icon: Icon(Icons.movie_filter_outlined), label: 'Фільми'),
            BottomNavigationBarItem(icon: Icon(Icons.tv), label: 'Серіали')
          ],
          onTap: onSelectTab,
        ),
        body: IndexedStack(
          index: _selectedTab,
          children: [
            const Center(child: Text('Новини', style: optionStyle)),
            NotifierProvider(
              create: () => modelMovieList,
              isManagingModel: false,
              child: const MovieListWidget(),
            ),
            const Center(child: Text('Серіали', style: optionStyle)),
          ],
        ));
  }
}
