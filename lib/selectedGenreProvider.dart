import 'package:flutter/material.dart';

class SelectedGenres with ChangeNotifier {
  List<dynamic> _genres = [];

  List<dynamic> get genres => _genres;

  void setGenres(List<dynamic> genres) {
    _genres = genres;
    notifyListeners();
  }

  void removeGenre(dynamic genre) {
    _genres.remove(genre);
    notifyListeners();
  }
}