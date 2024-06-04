

import 'package:cinemapedia/domain/entities/video.dart';
import 'package:cinemapedia/infrastructure/models/movieDb/moviedb_videos.dart';

class VideosMapeer {
 static Video videoMapper( Result video ) => Video
 (
  id: video.id, 
  name: video.name, 
  youtubeKey: video.key, 
  publishedAt: video.publishedAt
  );
}