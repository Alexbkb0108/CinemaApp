
import 'package:isar/isar.dart';

part 'movie.g.dart';

@collection
class Movie {

  Id? idIsar;

  final bool adult;
  final String backdropPath;
  final List<String> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final DateTime releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  Movie({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount
  });
}
//Las entidades en la capa de dominio nos ayuda a saber como va a lucir la data a lo largo
// de nuestra aplicacion, esto es muy importante ya que a nosotros no nos importa como venga la 
// informacion del exterior nosotros mapearemos la data para que lusca de esta manera, esto nos ayuda
// a la expancion de nuestra aplicacion, ya que si en algun momento requerimos implementar alguna
// ora API no sera problema ya que mapearemos la data para que lusca como esta entidad y se siga manejando
// igual

// otra ventaja que tiene DDD