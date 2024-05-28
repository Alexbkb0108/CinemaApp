import 'package:cinemapedia/presentation/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: NameRoutes.homeScreen,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
        path: 'movie/:id',
        name: NameRoutes.movieScreen,
        builder: (context, state) => MovieScreen( movieId: state.pathParameters['id'] ?? 'no-id'),
      )
      ]
    ),
    
  ]
);

class NameRoutes {
  static String homeScreen = 'homeScreen';
  static String movieScreen = 'movie-screen';
}

//El paquete que utilizo para poder mostrar otras pantallas, es decir manejar diferentes rutas es:
//go_router
