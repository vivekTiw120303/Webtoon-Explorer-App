import 'package:flutter/material.dart';

import 'detail_screen.dart';
import '../models/webtoon.dart';

class HomeScreen extends StatelessWidget {
  final List<Webtoon> webtoons = [
    Webtoon(
      title: 'Lore Olympus',
      thumbnail: 'assets/images/lore_olympus.jpg',
      description:
      'Lore Olympus: Jaw Dropping Seen on Media. A modern retelling of the myth of Hades and Persephone.',
    ),
    Webtoon(
      title: 'Tower of God',
      thumbnail: 'assets/images/tower_of_god.jpg',
      description:
      'Tower of God: An epic adventure where Bam climbs the mysterious Tower to find his friend Rachel.',
    ),
    Webtoon(
      title: 'Attack on Titan',
      thumbnail: 'assets/images/attack_on_titan.jpg',
      description:
      'Attack on Titan: Eren Yeager, his adopted sister Mikasa Ackerman, and their friend Armin Arlert as they join the Scout Regiment, an elite group of soldiers who fight Titans outside the walls',
    ),
    Webtoon(
      title: 'Jujutsu Kaisen',
      thumbnail: 'assets/images/jujutsu_kaisen.jpg',
      description: 'Jujutsu Kaisen: the story of Yuji Itadori, a high school student who becomes involved with the world of jujutsu sorcery after swallowing the finger of Sukuna Ryoumen, the Curse King',
    ),
    Webtoon(
      title: 'Death Note',
      thumbnail: 'assets/images/deathnote.jpg',
      description: 'Light Yagami, a 17-year-old high school student who discovers a supernatural notebook called the Death Note.',
    ),
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: const Text('Webtoon Explorer'),
        backgroundColor: Colors.blue.shade100,
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(

          itemCount: webtoons.length,

          itemBuilder: (context, index) {
            final webtoon = webtoons[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),

                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(webtoon: webtoon),
                      ),
                    );
                  },

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                        child: Image.asset(
                          webtoon.thumbnail,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                              webtoon.title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              webtoon.description,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
