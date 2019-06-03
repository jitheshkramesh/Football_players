import 'package:football_playerlisting/models/nation.dart';
import 'package:meta/meta.dart';

abstract class PlayerListingEvents {}

class CountrySelectedEvent extends PlayerListingEvents {
  final NationModel nationModel;

  CountrySelectedEvent({@required this.nationModel})
      : assert(nationModel != null);
}

class SearchTextChangedEvent extends PlayerListingEvents {
  final String searchTerm;
  SearchTextChangedEvent({this.searchTerm}) : assert(searchTerm != null);
}
