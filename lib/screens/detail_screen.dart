import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../models/webtoon.dart';
import '../providers/favorites_provider.dart';

class DetailScreen extends StatelessWidget {
  final Webtoon webtoon;

  DetailScreen({required this.webtoon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(webtoon.title),
        backgroundColor: Colors.blue.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<FavoritesProvider>(
          builder: (context, favoritesProvider, child) {
            bool isFavorited = favoritesProvider.isFavorite(webtoon.title);
            double averageRating = favoritesProvider.getRating(webtoon.title);

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      webtoon.thumbnail,
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    webtoon.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    webtoon.description,
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      favoritesProvider.toggleFavorite(webtoon);
                    },
                    icon: Icon(
                      isFavorited ? Icons.favorite : Icons.favorite_border,
                      color: Colors.white,
                    ),
                    label: Text(
                      isFavorited ? 'Remove from Favorites' : 'Add to Favorites',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isFavorited ? Colors.red : Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Rate this Webtoon:',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  RatingBar.builder(
                    initialRating: averageRating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      favoritesProvider.rateWebtoon(webtoon.title, rating);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('You rated this webtoon $rating stars!'),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Average Rating: ${averageRating.toStringAsFixed(1)}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
