import 'package:cinemapedia/domain/entities/movie.dart';

abstract class MovieDataSource {
  Future<List<Movie>> getNowPlaying({int page = 1});
  Future<List<Movie>> getPopular({int page = 1});
  Future<List<Movie>> getTopRated({int page = 1});
  Future<List<Movie>> getUpcoming({int page = 1});
  Future<Movie> getMovieForId({String? id});
  Future<List<Movie>> searchMovies( String query );
}


//Los datasources en la capa de dominio representan interfaces o clases abstractas que
//definen las implementaciones de los metodos que seran utilizados por la aplicacion
//de esta manera aplicamos la arquitectura DDD Domain Driver Design (diceño guiado poe el dominio)
//utilizamos el principio de responsabilidad unica, que consiste en delegar responsabilidades
//unicas a clases, funciones etc. esto fortalece el mantenimiento, escalabilidad de nuestro codigo