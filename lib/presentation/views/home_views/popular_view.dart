import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_masonry_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PopularView extends ConsumerStatefulWidget {
  const PopularView({super.key});

  @override
  PopularViewState createState() => PopularViewState();
}

class PopularViewState extends ConsumerState<PopularView>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final movies = ref.watch(popularMoviesProvider);
    super.build(context);

    if (movies.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(
          strokeAlign: 2,
        ),
      );
    }

    return MovieMasonry(
      movies: movies,
      loadNextPage: ref.read(popularMoviesProvider.notifier).loadNextPage,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
