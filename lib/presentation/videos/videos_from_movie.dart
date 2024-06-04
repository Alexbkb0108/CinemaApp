import 'package:cinemapedia/domain/entities/video.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repositoy_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

final FutureProviderFamily<List<Video>, int> videoByMovieProvider =
    FutureProvider.family((ref, int movieId) {
  final moviesProviderRepository = ref.watch(movieRepositoryProvider);
  return moviesProviderRepository.getYoutubeVideosById(movieId);
});

class VideosFromMovieState extends ConsumerWidget {
  final int movieId;

  const VideosFromMovieState({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videos = ref.watch(videoByMovieProvider(movieId));

    return videos.when(
      data: (video) => _VideosList(videos: video),
      loading: () =>
          const Center(child: CircularProgressIndicator(strokeAlign: 2)),
      error: (_, __) => const Center(child: Text('No hay videos para mostrar')),
    );
  }
}

class _VideosList extends StatelessWidget {
  final List<Video> videos;

  const _VideosList({required this.videos});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleLarge;
    if (videos.isEmpty) {
      return const SizedBox(
        height: 0,
      );
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            'Video',
            style: textStyle,
          ),
        ),
        _YouTubeVideoPlayer(
          youtubeId: videos.first.youtubeKey,
          name: videos.first.name,
        )
      ],
    );
  }
}

class _YouTubeVideoPlayer extends StatefulWidget {
  final String youtubeId;
  final String name;

  const _YouTubeVideoPlayer({
    required this.youtubeId,
    required this.name,
  });

  @override
  State<_YouTubeVideoPlayer> createState() => _YouTubeVideoPlayerState();
}

class _YouTubeVideoPlayerState extends State<_YouTubeVideoPlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
        initialVideoId: widget.youtubeId,
        flags: const YoutubePlayerFlags(
          hideThumbnail: true,
          showLiveFullscreenButton: false,
          mute: false,
          autoPlay: false,
          disableDragSeek: true,
          loop: false,
          isLive: false,
          forceHD: false,
          enableCaption: false,
        ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.name), YoutubePlayer(controller: _controller),
          const SizedBox(height: 20,)
          ],
      ),
    );
  }
}
