import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/move_mapper.dart';
import 'package:cinemapedia/infrastructure/models/movieDb/movie_details.dart';
import 'package:cinemapedia/infrastructure/models/movieDb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MovieDataSource {
  final dio = Dio(
      BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
    'api-key': Enviroment.moviedbKey,
    'language': 'es-MX',
  }, headers: {
    'Authorization': Enviroment.token,
  }));

  Future<List<Movie>> _requestBase(
      {required int page, required String getRequest}) async {
    final response =
        await dio.get('/movie/$getRequest', queryParameters: {'page': page});

    return responseMovies(response);
  }

  List<Movie> responseMovies(Response<dynamic> response) {
    final movieDBResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDBResponse.results
        .where((element) => element.posterPath != 'no-poster')
        .map((e) => MovieMapper.movieDBToEntity(e))
        .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    return _requestBase(page: page, getRequest: 'now_playing');
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    return _requestBase(page: page, getRequest: 'popular');
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    return _requestBase(page: page, getRequest: 'top_rated');
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    return _requestBase(page: page, getRequest: 'upcoming');
  }

  @override
  Future<Movie> getMovieForId({String? id}) async {
    final response = await dio.get('/movie/$id');
    final moviebdmovie = MovieDetails.fromJson(response.data);
    final movie = MovieMapper.movieDetailsToEntity(moviebdmovie);

    return movie;
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    if (query.isEmpty) return [];
    final response =
        await dio.get('/search/movie', queryParameters: {'query': query});

    return responseMovies(response);
  }
}

//Esta es la implementacion del datasource como podemos observar aqui se realizan las peticiones
//get http a la API de cinema
