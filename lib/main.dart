import 'package:flutter/material.dart';
import 'package:football_playerlisting/pages/home_page.dart';
import 'package:football_playerlisting/services/repository.dart';

void main() {
  PlayerRepository _repository = PlayerRepository();
  runApp(MyApp(
    playerRepository: _repository,
  ));
}

class MyApp extends StatelessWidget {
  final PlayerRepository playerRepository;
  MyApp({this.playerRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Football Player Listing',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(playerRepository:playerRepository),
    );
  }
}
