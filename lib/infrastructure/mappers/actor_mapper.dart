import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/models/movieDb/credits_response.dart';

class ActorMapper {
  static Actor mapperActor(Cast actor) => Actor(
      id: actor.id,
      name: actor.originalName,
      profilePath: actor.profilePath != '' 
      ? 'https://image.tmdb.org/t/p/w500/${actor.profilePath}' 
      : 'https://linnea.com.ar/wp-content/uploads/2018/09/404PosterNotFound.jpg',
      character: actor.character
    );
}
