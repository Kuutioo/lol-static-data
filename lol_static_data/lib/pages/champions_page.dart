import 'package:flutter/material.dart';

class ChampionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Champions'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150,
          childAspectRatio: 1,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemCount: 140,
        itemBuilder: ((context, index) {
          return GridTile(
            child: IconButton(
              icon: Image.network(
                'https://uning.es/wp-content/uploads/2016/08/ef3-placeholder-image.jpg',
                fit: BoxFit.cover,
              ),
              onPressed: () {},
            ),
            footer: const Text(
              'lol',
              textAlign: TextAlign.center,
            ),
          );
        }),
      ),
    );
  }
}
