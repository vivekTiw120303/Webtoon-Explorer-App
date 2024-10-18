import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'detail_screen.dart';
import '../providers/favorites_provider.dart';
import '../models/webtoon.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesProvider>(
      builder: (context, favoritesProvider, child) {
        List<Webtoon> favorites = favoritesProvider.favorites;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Favorites'),
            centerTitle: true,
            backgroundColor: Colors.blue.shade100,
          ),
          body: favorites.isEmpty
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.favorite_border,
                  size: 100,
                  color: Colors.grey,
                ),
                SizedBox(height: 16),
                Text(
                  'No favorites added yet!',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          )
              : Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final webtoon = favorites[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          webtoon.thumbnail,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(webtoon.title),
                      subtitle: Text(
                          'Average Rating: ${webtoon.averageRating.toStringAsFixed(1)}'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailScreen(webtoon: webtoon),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
