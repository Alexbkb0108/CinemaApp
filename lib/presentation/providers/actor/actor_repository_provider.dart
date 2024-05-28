import 'package:cinemapedia/infrastructure/datasources/actors_db_datasources.dart';
import 'package:cinemapedia/infrastructure/repositories/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorRepositoryProvider = Provider((ref) {
  return ActorRepositoryImpl(datasource: ActorsDBDatasource());
});
