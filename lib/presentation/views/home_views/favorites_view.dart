import 'package:cinemapedia/presentation/providers/storage/favorite_movies_provider.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_masonry_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  FavoritesViewState createState() => FavoritesViewState();
}

class FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLoading = false;
  bool isLastPage = false;
  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;
    isLoading = true;
    await Future.delayed(const Duration(seconds: 1));
    final movies =
        await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;
    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final movies = ref.watch(favoriteMoviesProvider).values.toList();

    if (movies.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.favorite_outline_sharp, size: 60, color: colors.primary,),
            Text('Ohhh no!!!', style: TextStyle( fontSize: 30, color: colors.primary),),
            const Text('No tienes peliculas favoritas', style: TextStyle(fontSize: 20, color: Colors.black),),

            const SizedBox(height: 20,),

            FilledButton.tonal(onPressed: () => context.go('/'), child: const Text('ver peliculas'))
          ],
        ),
      );
    }

    return Scaffold(
        body: MovieMasonry(
          movies: movies,
          loadNextPage: loadNextPage,
        )
      );
  }
}
