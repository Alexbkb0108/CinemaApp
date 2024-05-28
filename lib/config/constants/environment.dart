import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroment {
  static String moviedbKey = dotenv.env['THE_MOVIEDB_KEY'] ?? 'No hay';
  static String token = dotenv.env['TOKEN'] ?? 'No hay';
}//Para poder obtener los valores de mis variables de entorno hice la instalacion de:
//flutter_dotenv
