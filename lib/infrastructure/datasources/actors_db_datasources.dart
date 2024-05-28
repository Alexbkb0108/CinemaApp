import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastructure/models/movieDb/credits_response.dart';
import 'package:dio/dio.dart';

class ActorsDBDatasource extends ActorsDataSource {
  final dio = Dio(
      BaseOptions(baseUrl: 'https://api.themoviedb.org/3', queryParameters: {
    'api-key': Enviroment.moviedbKey,
    'language': 'es-MX',
  }, headers: {
    'Authorization': Enviroment.token,
  }));

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');

    final parseResponse = ActorsResponse.fromJson(response.data);

    final actors1 =
        parseResponse.cast.map((e) => ActorMapper.mapperActor(e)).toList();
    final actors2 =
        parseResponse.crew.map((e) => ActorMapper.mapperActor(e)).toList();

    return [ ...actors1, ...actors2 ];
  }
}
