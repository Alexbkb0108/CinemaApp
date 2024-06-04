import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/entities/video.dart';

abstract class MoviesRepository {

  Future<List<Movie>> getNowPlaying({int page = 1});

  Future<List<Movie>> getPopular({int page = 1});

  Future<List<Movie>> getTopRated({int page = 1});

  Future<List<Movie>> getUpcoming({int page = 1});

  Future<Movie> getMovieForId({ String? id });

  Future<List<Movie>> searchMovies( String query );

  Future<List<Movie>> getSimilarMovies( int movieId );

  Future<List<Video>> getYoutubeVideosById( int movieId );

}

//los repositorios se podria decir que es un puente entre la capa de presentacion y el acceso
// a los datos aqui definimos la interfaz o clase abstracta que nos ayuda a definir los metodos
// que seran mostrados a nuestra presentacion

//el objetivo del repositorio es permitirmos a nosotros poder cambiar de datasource 