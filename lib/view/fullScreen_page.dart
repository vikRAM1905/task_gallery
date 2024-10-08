import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  final dynamic image;

  const FullScreenImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(image['tags'].toString()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Hero(
                tag: image['largeImageURL'],
                child: CachedNetworkImage(
                  imageUrl: image['largeImageURL'],
                  fit: BoxFit.contain,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 5.0),
                      child: Icon(
                        Icons.remove_red_eye_rounded,
                        color: Colors.orange,
                      ),
                    ),
                    Text(
                      image['views'].toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 5.0),
                      child: Icon(
                        Icons.save_alt,
                        color: Colors.orange,
                      ),
                    ),
                    Text(image['downloads'].toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14))
                  ],
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 5.0),
                      child: Icon(
                        Icons.comment,
                        color: Colors.orange,
                      ),
                    ),
                    Text(image['comments'].toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14))
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
