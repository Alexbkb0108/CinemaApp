import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repositoy_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getMovieProvider =
    StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final repositoryProvider = ref.watch(movieRepositoryProvider);
  return MovieMapNotifier(getMovie: repositoryProvider.getMovieForId);
});

typedef GetMovieCallback = Future<Movie> Function({String? id});

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {
  final GetMovieCallback getMovie;
  MovieMapNotifier({required this.getMovie}) : super({});

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) return;
    print('Realizando peticion http');
    final movie = await getMovie(id: movieId);

    state = {...state, movieId: movie};
  }
}
