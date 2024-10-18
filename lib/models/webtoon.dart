class Webtoon {
  final String title;
  final String thumbnail;
  final String description;
  double averageRating;
  int ratingCount;

  Webtoon({
    required this.title,
    required this.thumbnail,
    required this.description,
    this.averageRating = 0.0,
    this.ratingCount = 0,
  });

  // Convert Webtoon to Map for storage
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'thumbnail': thumbnail,
      'description': description,
      'averageRating': averageRating,
      'ratingCount': ratingCount,
    };
  }

  // Create Webtoon from Map
  factory Webtoon.fromMap(Map<String, dynamic> map) {
    return Webtoon(
      title: map['title'],
      thumbnail: map['thumbnail'],
      description: map['description'],
      averageRating: map['averageRating'] ?? 0.0,
      ratingCount: map['ratingCount'] ?? 0,
    );
  }
}
