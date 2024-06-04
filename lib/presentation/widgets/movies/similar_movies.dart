import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repositoy_provider.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_horizontal_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final similarMoviesProvider = FutureProvider.family((ref, int movieId) {
  final repositoryProvider =
      ref.watch(movieRepositoryProvider).getSimilarMovies(movieId);
  return repositoryProvider;
});

class SimilarMovies extends ConsumerWidget {
  final int movieId;
  const SimilarMovies({required this.movieId, super.key});

  @override
  Widget build(BuildContext context, ref) {
    final movies = ref.watch(similarMoviesProvider(movieId));
    return movies.when(
        data: (movies) => _OrderSimilarMovies(
              movies: movies,
            ),
        error: (_, __) => const Center(
              child: Text('No hay videos para mostrar'),
            ),
        loading: () => const Center(
              child: CircularProgressIndicator(
                strokeAlign: 2,
              ),
            ));
  }
}

class _OrderSimilarMovies extends StatelessWidget {
  final List<Movie> movies;
  const _OrderSimilarMovies({required this.movies});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleLarge;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Center(child: Text('Recomendaciones', style: textStyle,)),
      MovieHorizontalListView(movies: movies)
    ]
    );
  }
}
