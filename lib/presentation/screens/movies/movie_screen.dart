import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/actor/actor_provider.dart';
import 'package:cinemapedia/presentation/providers/movies/movie_info_provider.dart';
import 'package:cinemapedia/presentation/providers/storage/favorite_movies_provider.dart';
import 'package:cinemapedia/presentation/providers/storage/local_storege_provider.dart';
import 'package:cinemapedia/presentation/videos/videos_from_movie.dart';
import 'package:cinemapedia/presentation/widgets/movies/similar_movies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends ConsumerStatefulWidget {

  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(getMovieProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsProvider.notifier).loadActors(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(getMovieProvider)[widget.movieId];
    final List<Actor> actors = ref.watch(actorsProvider);

    if (movie == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppbar(movie: movie),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) => _MovieDetails(
              movie: movie,
              actor: actors,
            ),
            childCount: 1,
          ))
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;
  final List<Actor> actor;

  const _MovieDetails({required this.movie, required this.actor});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStiles = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleAndOverview(movie: movie, size: size, textStiles: textStiles),

        Genders(movie: movie),

        const SizedBox(height: 10,),

        Center(
          child: Text(
            'Reparto',
            style: textStiles.titleLarge,
          ),
        ),

        ActorsByMovie(actor: actor),

        VideosFromMovieState(movieId: movie.id),

        SimilarMovies(movieId: movie.id),

        // const SizedBox(height: 50,)
      ],
    );
  }
}

class ActorsByMovie extends StatelessWidget {
  const ActorsByMovie({
    super.key,
    required this.actor,
  });

  final List<Actor> actor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 5),
      child: SizedBox(
        height: 260,
        child: Expanded(
          child: ListView.builder(
            itemCount: actor.length,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final oneActor = actor[index];
              return FadeInRight(
                child: _ShowActorsList(
                  actor: oneActor,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class Genders extends StatelessWidget {
  const Genders({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Wrap(
        children: [
          ...movie.genreIds.map((gender) => Container(
                margin: const EdgeInsets.only(right: 10),
                child: Chip(
                  label: Text(gender),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ))
        ],
      ),
    );
  }
}

class TitleAndOverview extends StatelessWidget {
  const TitleAndOverview({
    super.key,
    required this.movie,
    required this.size,
    required this.textStiles,
  });

  final Movie movie;
  final Size size;
  final TextTheme textStiles;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              movie.posterPath,
              width: size.width * 0.3,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress != null) return const SizedBox();
                return FadeIn(child: child);
              },
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: (size.width - 40) * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: textStiles.titleLarge,
                ),
                Text(
                  movie.overview == '' ? 'Sin descripción' : movie.overview,
                  style: textStiles.titleSmall,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _ShowActorsList extends StatelessWidget {
  final Actor actor;
  const _ShowActorsList({required this.actor});

  @override
  Widget build(BuildContext context) {
    final textStiles = Theme.of(context).textTheme;
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        width: 125,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            actor.profilePath,
            fit: BoxFit.cover,
            width: 150,
          ),
        ),
      ),
      Text(
        actor.name,
        style: textStiles.bodyMedium,
      ),
      SizedBox(
          width: 125,
          child: Text(
            actor.character ?? '',
            style: textStiles.bodySmall,
            softWrap: true,
            textAlign: TextAlign.center,
          )),
    ]);
  }
}

final isFavoriteProvider =
    FutureProvider.family.autoDispose((ref, int movieId) {
  final localStorageRepository =
      ref.watch(localStorageRepositoryProvider).isMovieFavorite(movieId);
  return localStorageRepository;
});

class _CustomSliverAppbar extends ConsumerWidget {
  final Movie movie;
  const _CustomSliverAppbar({required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final isFavorite = ref.watch(isFavoriteProvider(movie.id));
    //ref.watch(localStorageRepositoryProvider).isMovieFavorite(movie.id);
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () async{
            await ref.read(favoriteMoviesProvider.notifier).toggleFavorite(movie);
            ref.invalidate(isFavoriteProvider(movie.id));
          },
          icon: isFavorite.when(
              loading: () => const CircularProgressIndicator(strokeWidth: 2),
              error: (_, __) => throw UnimplementedError(),
              data: (isFavorite) => isFavorite
                  ? const Icon(
                      Icons.favorite_rounded,
                      color: Colors.red,
                    )
                  : const Icon(Icons.favorite_border_outlined)),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        title: Text(
          movie.title,
          style: const TextStyle(fontSize: 20),
        ),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
              ),
            ),
            const _CustomGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.7, 1.0],
                colors: [Colors.transparent, Colors.black87]),
            const _CustomGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [0.0, 0.2],
                colors: [Colors.black87, Colors.transparent]),
            const _CustomGradient(
                begin: Alignment.topLeft,
                end: Alignment.center,
                stops: [0.0, 0.3],
                colors: [Colors.black87, Colors.transparent]),
          ],
        ),
      ),
    );
  }
}

class _CustomGradient extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final List<Color> colors;

  const _CustomGradient(
      {required this.begin,
      required this.end,
      required this.stops,
      required this.colors});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: begin, end: end, stops: stops, colors: colors),
        ),
      ),
    );
  }
}
