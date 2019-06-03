import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_playerlisting/bloc/player_listing_bloc.dart';
import 'package:football_playerlisting/pages/player_listing.dart';
import 'package:football_playerlisting/services/repository.dart';
import 'package:football_playerlisting/themes/themes.dart';
import 'package:football_playerlisting/widgets/horizontal_bar.dart';
import 'package:football_playerlisting/widgets/search_bar.dart';

class HomePage extends StatefulWidget {
  final PlayerRepository playerRepository;

  HomePage({this.playerRepository});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PlayerListingBloc _playerListingBloc;
  @override
  void initState() {
    super.initState();
    _playerListingBloc =
        PlayerListingBloc(playerRepository: widget.playerRepository);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _playerListingBloc,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              "Football Players",
              style: appBarTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            HorizontalBar(),
            SizedBox(height: 10.0),
            SearchBar(),
            SizedBox(height: 10.0),
            PlayerListing()
          ],
        ),
      ),
    );
  }
}
