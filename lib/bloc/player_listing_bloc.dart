import 'package:bloc/bloc.dart';
import 'dart:core';
import 'dart:async';
import 'package:football_playerlisting/bloc/player_listing_events.dart';
import 'package:football_playerlisting/bloc/player_listing_state.dart';
import 'package:football_playerlisting/models/api_models.dart';
import 'package:football_playerlisting/services/repository.dart';
import 'package:rxdart/rxdart.dart';

class PlayerListingBloc extends Bloc<PlayerListingEvents, PlayerListingState> {
  final PlayerRepository playerRepository;

  PlayerListingBloc({this.playerRepository}) : assert(playerRepository != null);

  @override
  Stream<PlayerListingEvents> transform(Stream<PlayerListingEvents> events) {
    return (events as PublishSubject<PlayerListingEvents>)
        .transform(DebounceStreamTransformer(Duration(milliseconds: 250)));
  }

  @override
  void onTransition(
      Transition<PlayerListingEvents, PlayerListingState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  PlayerListingState get initialState => PlayerUnInitializedState();

  @override
  Stream<PlayerListingState> mapEventToState(
      PlayerListingState currentState, PlayerListingEvents event) async* {
    print("mapEventToState");
    yield PlayerFetchingState();
    try {
      List<Players> players;
      if (event is CountrySelectedEvent) {
        players = await playerRepository
            .fetchPlayersByCountry(event.nationModel.countryId);
      } else if (event is SearchTextChangedEvent) {
        players = await playerRepository.fetchPlayersByName(event.searchTerm);
      }

      if (players.length == 0) {
        yield PlayerEmptyState();
      } else {
        yield PlayerFetchedState(players: players);
      }
    } catch (_) {
      yield PlayerErrorState();
    }
  }
}
