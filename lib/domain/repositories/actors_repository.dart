import 'package:cinemapedia/domain/entities/actor.dart';

abstract class ActorsRepository {
  Future<List<Actor>> getActorsByMovie(String movieId);
}
//el objetivo del repositorio es permitirmos a nosotros poder cambiar de datasource 