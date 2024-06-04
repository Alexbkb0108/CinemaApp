import 'package:cinemapedia/presentation/screens.dart';
import 'package:cinemapedia/presentation/views/home_views/favorites_view.dart';
import 'package:cinemapedia/presentation/views/home_views/home_view.dart';
import 'package:cinemapedia/presentation/views/home_views/popular_view.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  StatefulShellRoute.indexedStack(
    builder: (context, state, child) {
      return HomeScreen(childView: child);
    },
    branches: [
      StatefulShellBranch(routes: [
        GoRoute(
          path: '/',
          builder: (context, state) {
            return const HomeView();
          },
          routes: [
            GoRoute(
              path: 'movie/:id',
              name: NameRoutes.movieScreen,
              builder: (context, state) => MovieScreen( movieId: state.pathParameters['id'] ?? 'no-id'),
            ),
          ]
        ),
      ]
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: '/favorites',
            builder: (context, state) {
              return const FavoritesView();
            },
          ),
        ]
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
              path: '/popular',
              builder: (context, state) => const PopularView(),
          ),
        ]
      )
    ])
]);

//Rutas padre/Hijo
// final appRouter = GoRouter(
//   initialLocation: '/',
//   routes: [
//     GoRoute(
//       path: '/',
//       name: NameRoutes.homeScreen,
//       builder: (context, state) => const HomeScreen( childView: HomeView(),),
//       routes: [
//         GoRoute(
//         path: 'movie/:id',
//         name: NameRoutes.movieScreen,
//         builder: (context, state) => MovieScreen( movieId: state.pathParameters['id'] ?? 'no-id'),
//       )
//       ]
//     ),

//   ]
// );

class NameRoutes {
  static String homeScreen = 'homeScreen';
  static String movieScreen = 'movie-screen';
  static String popularScreen = 'popular-screen';
}

//El paquete que utilizo para poder mostrar otras pantallas, es decir manejar diferentes rutas es:
//go_router
