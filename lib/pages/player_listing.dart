import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_playerlisting/bloc/player_listing_bloc.dart';
import 'package:football_playerlisting/bloc/player_listing_state.dart';
import 'package:football_playerlisting/models/api_models.dart';
import 'package:football_playerlisting/themes/themes.dart';
import 'package:football_playerlisting/widgets/message.dart';

class PlayerListing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<PlayerListingBloc>(context),
      builder: (context, state) {
        if (state is PlayerUnInitializedState) {
          return Message(
              message: "Please select a country flag to fetch players from");
        } else if (state is PlayerEmptyState) {
          return Message(message: "No Players found.");
        } else if (state is PlayerErrorState) {
          return Message(message: "Something went wrong.");
        } else if (state is PlayerFetchingState) {
          return Expanded(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          final stateAsPlayerFetchedState = state as PlayerFetchedState;
          final players = stateAsPlayerFetchedState.players;
          return buildPlayerList(players);
        }
      },
    );
  }

  Widget buildPlayerList(List<Players> players) {
    return Expanded(
        child: ListView.separated(
      itemBuilder: (BuildContext context, index) {
        var player = players[index];
        return ListTile(
          leading: Image.network(
            player.headshot.imgUrl,
            width: 70.0,
            height: 70.0,
          ),
          title: Text(
            player.name,
            style: titleStyle,
          ),
          subtitle: Text(player.club.name, style: subTitleStyle),
        );
      },
      separatorBuilder: (BuildContext context, index) {
        return Divider(height: 8.0);
      },
      itemCount: players.length,
    ));
  }
}
