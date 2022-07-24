import 'package:flutter/material.dart';
import 'package:themoviedb/Library/Widget/Inherited/provider.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/widgets/movie_details/movie_details_model.dart';

import '../../domain/entity/movie_details_credits.dart';
import '../../ui/navigator/main_navigator.dart';
import '../elements/radial_percen_widget.dart';

class MovieDetailsMainInfoWidget extends StatelessWidget {
  const MovieDetailsMainInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _TopPoserWidget(),
        const SizedBox(height: 10),
        const _MivieNamedWidget(),
        const _SummeryWidget(),
        Padding(padding: const EdgeInsets.all(10.0), child: _OverviewWidget()),
        const _ScoreWidget(),
        Padding(
            padding: const EdgeInsets.all(10.0), child: _DescriptionWidget()),
        const SizedBox(height: 30),
        const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: _PeopleWidgets()),
      ],
    );
  }
}

class _DescriptionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetaislModel>(context);

    return Text(
      model?.movieDetails?.overview ?? '',
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.white,
        fontSize: 16,
      ),
    );
  }
}

class _OverviewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text(
      'Overview',
      style: TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.white,
        fontSize: 17,
      ),
    );
  }
}

class _TopPoserWidget extends StatelessWidget {
  const _TopPoserWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetaislModel>(context);
    final backdropPath = model?.movieDetails?.backdropPath;
    final posterPath = model?.movieDetails?.posterPath;

    return AspectRatio(
      aspectRatio: 411 / 231,
      child: Stack(
        children: [
          backdropPath != null
              ? Image.network(ApiClient.imageUrl(backdropPath))
              : const SizedBox.shrink(),
          Positioned(
            top: 20,
            left: 20,
            bottom: 20,
            child: posterPath != null
                ? Image.network(ApiClient.imageUrl(posterPath))
                : const SizedBox.shrink(),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: IconButton(
              icon: Icon(model?.isFavorite == true
                  ? Icons.favorite
                  : Icons.favorite_outline),
              color: Colors.white,
              onPressed: () => model?.toggleFavorite(),
            ),
          )
        ],
      ),
    );
  }
}

class _MivieNamedWidget extends StatelessWidget {
  const _MivieNamedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetaislModel>(context);
    return Center(
      child: RichText(
          textAlign: TextAlign.center,
          maxLines: 3,
          text: TextSpan(children: [
            TextSpan(
                text: model?.movieDetails?.title ?? '',
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 17)),
            TextSpan(
                text: ' (${model?.movieDetails?.releaseDate?.year ?? ''})',
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ))
          ])),
    );
  }
}

class _ScoreWidget extends StatelessWidget {
  const _ScoreWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var movieDetails =
        NotifierProvider.watch<MovieDetaislModel>(context)?.movieDetails;

    var voteAverage = movieDetails?.voteAverage ?? 0;

    final videos = movieDetails?.videos.results
        .where((video) => video.type == 'Trailer' && video.site == 'YouTube');
    final trailerKey = videos?.isNotEmpty == true ? videos?.first.key : null;
    voteAverage = voteAverage * 10;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
            onPressed: () => SessionDataProvider().setSessionId(null),
            child: Row(
              children: [
                SizedBox(
                  height: 40,
                  width: 40,
                  child: RadialPercentWidget(
                    percent: voteAverage / 100,
                    fillColor: const Color.fromARGB(255, 10, 23, 25),
                    lineColor: const Color.fromARGB(255, 34, 203, 103),
                    freeColor: const Color.fromARGB(255, 25, 54, 31),
                    lineWidth: 3,
                    child: Text(voteAverage.toStringAsFixed(0)),
                  ),
                ),
                const SizedBox(width: 10),
                const Text('User Score'),
              ],
            )),
        Container(width: 1, height: 15, color: Colors.grey),
        trailerKey != null
            ? TextButton(
                onPressed: () => Navigator.of(context).pushNamed(
                    MainNavigatorRoutesName.movieTrailerWidget,
                    arguments: trailerKey),
                child: Row(
                  children: const [
                    Icon(Icons.play_arrow),
                    SizedBox(width: 5),
                    Text('Play Trailer'),
                  ],
                ))
            : const SizedBox.shrink(),
      ],
    );
  }
}

class _SummeryWidget extends StatelessWidget {
  const _SummeryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetaislModel>(context);
    if (model == null) return const SizedBox.shrink();
    var texts = <String>[];
    final releaseDate = model.movieDetails?.releaseDate;
    if (releaseDate != null) {
      texts.add(model.stringFromDate(releaseDate));
    }

    final productionCountries = model.movieDetails?.productionCountries;
    if (productionCountries != null && productionCountries.isNotEmpty) {
      texts.add('(${productionCountries.first.iso})');
    }

    final runtime = model.movieDetails?.runtime ?? 0;
    final duration = Duration(minutes: runtime);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    texts.add('${hours}h ${minutes}m');
    final genres = model.movieDetails?.genres;
    if (genres != null && genres.isNotEmpty) {
      var genresName = <String>[];
      for (var genr in genres) {
        genresName.add(genr.name);
      }
      texts.add(genresName.join(', '));
    }

    // 'PG-13, 04/01/2022 (US) 1h 45m Action, Science Fiction, Fantasy'
    return ColoredBox(
      color: const Color.fromRGBO(22, 21, 25, 1),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Center(
          child: Text(
            texts.join(' '),
            maxLines: 3,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

class _PeopleWidgets extends StatelessWidget {
  const _PeopleWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetaislModel>(context);
    var crew = model?.movieDetails?.credits.crew;
    if (crew == null || crew.isEmpty) return const SizedBox.shrink();
    crew = crew.length >= 4 ? crew.sublist(0, 4) : crew;

    var crewChunks = <List<Employee>>[];
    for (var i = 0; i < crew.length; i += 2) {
      crewChunks.add(
        crew.sublist(i, i + 2 > crew.length ? crew.length : i + 2),
      );
    }
    return Column(
        children: crewChunks
            .map((chunk) => Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: _PeopleWidgetsRow(
                    emloyes: chunk,
                  ),
                ))
            .toList());
  }
}

class _PeopleWidgetsRow extends StatelessWidget {
  final List<Employee> emloyes;

  const _PeopleWidgetsRow({Key? key, required this.emloyes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.max,
        children: emloyes
            .map((employee) => _PeopleWidgetsRowItem(
                  empoyee: employee,
                ))
            .toList());
  }
}

class _PeopleWidgetsRowItem extends StatelessWidget {
  final Employee empoyee;
  const _PeopleWidgetsRowItem({Key? key, required this.empoyee})
      : super(key: key);

  final _nameStyle = const TextStyle(
    fontWeight: FontWeight.w400,
    color: Colors.white,
    fontSize: 16,
  );
  final _jobTitleStyle = const TextStyle(
    fontWeight: FontWeight.w400,
    color: Colors.white,
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(empoyee.name, style: _nameStyle),
          Text(empoyee.job, style: _jobTitleStyle),
        ],
      ),
    );
  }
}
