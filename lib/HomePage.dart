import 'package:application/BackgroundImageWidget.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatelessWidget {
  final List<String> imageList = [
    'assets/images/UNZ.png',
    'assets/images/unz.jpeg',
    'assets/images/UOHG.png',
    'assets/images/UTS.jpeg',
    'assets/images/UV-BF.png',
    'assets/images/USDAO.jpeg',
    // Ajoutez autant d'images que nécessaire
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundImageWidget(
            child:
                Container(), // You can remove this Container if it's not necessary
          ),
          Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 300,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    // Gestionnaire de page changée
                  },
                  scrollDirection: Axis.horizontal,
                ),
                items: imageList.map((imagePath) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                        ),
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(8.0),
                  children: [
                    ListTile(
                      tileColor: Colors.black.withOpacity(0.8),
                      title: const Text(
                        "Veuillez explorer les filières de formations et les différentes IES à partir des onglets dans la barre de tâches.",
                        style:
                            TextStyle(color: Color.fromARGB(255, 89, 255, 191)),
                      ),
                    ),
                    // Ajoutez d'autres ListTiles ou widgets ici
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
