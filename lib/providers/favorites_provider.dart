import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/webtoon.dart';

class FavoritesProvider with ChangeNotifier {
  List<Webtoon> _favorites = [];

  List<Webtoon> get favorites => _favorites;

  FavoritesProvider() {
    loadFavorites();
  }

  // Load favorites from SharedPreferences
  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? favoritesString = prefs.getString('favorites');

    if (favoritesString != null) {
      List<dynamic> decoded = jsonDecode(favoritesString);
      _favorites = decoded.map((item) => Webtoon.fromMap(item)).toList();
      notifyListeners();
    }
  }

  // Save favorites to SharedPreferences
  Future<void> saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> favoritesMap =
    _favorites.map((webtoon) => webtoon.toMap()).toList();
    prefs.setString('favorites', jsonEncode(favoritesMap));
  }

  // Add or remove favorite
  void toggleFavorite(Webtoon webtoon) {
    if (isFavorite(webtoon.title)) {
      _favorites.removeWhere((item) => item.title == webtoon.title);
    } else {
      _favorites.add(webtoon);
    }
    saveFavorites();
    notifyListeners();
  }

  bool isFavorite(String title) {
    return _favorites.any((webtoon) => webtoon.title == title);
  }

  // Rate a webtoon
  void rateWebtoon(String title, double rating) {
    for (var webtoon in _favorites) {
      if (webtoon.title == title) {
        webtoon.averageRating =
            ((webtoon.averageRating * webtoon.ratingCount) + rating) /
                (webtoon.ratingCount + 1);
        webtoon.ratingCount += 1;
        break;
      }
    }
    saveFavorites();
    notifyListeners();
  }

  // Get rating for a webtoon
  double getRating(String title) {
    var webtoon = _favorites.firstWhere(
          (element) => element.title == title,
      orElse: () => Webtoon(
        title: '',
        thumbnail: '',
        description: '',
      ),
    );
    return webtoon.averageRating;
  }
}
