
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gallary_task/controller/gallery_controller.dart';
import 'package:get/get.dart';

import 'fullScreen_page.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  final controller = Get.put(GalleryController());
  final List<dynamic> _images = [];
  int _page = 1;
  bool _loading = false;
  final int _limit = 20;

  @override
  void initState() {
    super.initState();
    _fetchImages();
  }

  Future<void> _fetchImages() async {
    if (_loading) return;

    setState(() {
      _loading = true;
    });

    final response = await controller.getImages();
    debugPrint("resp::: $response");
    for (int i = 0; i < response['hits'].length; i++) {
      // final List<String> fetchedImages = List<String>.from(response);

      _images.add(response['hits'][i]);
    }
    setState(() {
      _page++;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final crossAxisCount =
        (width / 100).floor(); // Adjust the divisor for column size

    return Scaffold(
      appBar: AppBar(title: const Text('Image Gallery')),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!scrollInfo.metrics.outOfRange &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            _fetchImages();
          }
          return true;
        },
        child: GridView.builder(
          padding: const EdgeInsets.all(5),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 1,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
          ),
          itemCount: _images.length +
              (_loading ? 1 : 0), // Show loading indicator if loading
          itemBuilder: (context, index) {
            if (index == _images.length) {
              return const Center(child: CircularProgressIndicator());
            }
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        FullScreenImage(image: _images[index]),
                  ),
                );
              },
              child: Column(
                children: [
                  SizedBox(
                    height: 65,
                    child: CachedNetworkImage(
                      imageUrl: _images[index]['previewURL'],
                      placeholder: (context, url) => Container(
                        color: Colors.grey[300],
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    color: Colors.grey.withOpacity(0.2),
                    height: 20,
                    child: Text(
                      _images[index]['tags'],
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

