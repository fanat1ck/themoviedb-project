import 'package:flutter/material.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';

import '../../Library/Widget/Inherited/provider.dart';
import 'movie_details_model.dart';

class MovieDetailsMainScreenCastWidget extends StatelessWidget {
  const MovieDetailsMainScreenCastWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Top Billed Cast',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              height: 250,
              child: Scrollbar(
                child: _ActorListWidget(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: TextButton(
                  onPressed: () {}, child: const Text('Full Cast & Crew')),
            )
          ],
        ));
  }
}

class _ActorListWidget extends StatelessWidget {
  const _ActorListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.watch<MovieDetaislModel>(context);
    var cast = model?.movieDetails?.credits.cast;
    if (cast == null || cast.isEmpty) return const SizedBox.shrink();
    return ListView.builder(
        itemCount: 20,
        itemExtent: 120,
        scrollDirection: Axis.horizontal,
        itemBuilder: ((context, index) {
          return _ActorIteWidget(actorIndex: index);
        }));
  }
}

class _ActorIteWidget extends StatelessWidget {
  final int actorIndex;
  const _ActorIteWidget({Key? key, required this.actorIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = NotifierProvider.read<MovieDetaislModel>(context);
    var actor = model!.movieDetails!.credits.cast[actorIndex];
    final profilPath = actor.profilePath;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.black.withOpacity(0.2),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2))
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          clipBehavior: Clip.hardEdge,
          child: Column(
            children: [
              profilPath != null
                  ? Image.network(ApiClient.imageUrl(profilPath),
                      height: 120, width: 120, fit: BoxFit.fitWidth)
                  : const SizedBox.shrink(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(actor.name, maxLines: 1),
                      const SizedBox(height: 7),
                      Text(
                        actor.character,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
