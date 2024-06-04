

import 'package:cinemapedia/domain/entities/movie.dart';

abstract class LocalStorageRepository {

  Future<void> toggleFavorite(Movie movie);

  Future<bool> isMovieFavorite(int movieId);

  Future<List<Movie>> loadMovies({int limit = 15, int offset = 0});
}

//el objetivo del repositorio es permitirmos a nosotros poder cambiar de datasource 