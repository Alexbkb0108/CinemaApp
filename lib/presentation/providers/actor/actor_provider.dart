import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/presentation/providers/actor/actor_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsProvider = StateNotifierProvider<ActorNotifier, List<Actor>>((ref) {
  final actorRepository = ref.watch(actorRepositoryProvider);
  return ActorNotifier(actorsList: actorRepository.getActorsByMovie);
});

typedef ActorsList = Future<List<Actor>> Function(String movieId);

class ActorNotifier extends StateNotifier<List<Actor>> {
  final ActorsList actorsList;

  ActorNotifier({required this.actorsList}) : super([]);

  Future<void> loadActors(String movieId) async {
    final List<Actor> actors = await actorsList(movieId);
    state = [...actors];
  }
}
