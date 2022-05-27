enum SearchType { users, issues, repositories, unknown }

class Constant {
  static const int limit = 30;
  static const double cardRadius = 15;
  static const double listTileHeight = 100;
  static const throttleDuration = Duration(milliseconds: 100); // TODO
}
