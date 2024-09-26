import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GalleryTab extends StatefulWidget {
  const GalleryTab({super.key});

  @override
  _GalleryTabState createState() => _GalleryTabState();
}

class _GalleryTabState extends State<GalleryTab> {
  late Future<List<dynamic>> _galleryList;

  @override
  void initState() {
    super.initState();
    _galleryList = fetchGallery();
  }

  Future<List<dynamic>> fetchGallery() async {
    final response = await http.get(
        Uri.parse('https://praktikum-cpanel-unbin.com/API_praktikum_TEGARRR/galeri.php'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load gallery');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _galleryList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No gallery available'));
        } else {
          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Adjusting the height to avoid overflow
                    Flexible(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: SizedBox.expand(
                          child: Image.network(
                            snapshot.data![index]['img_galeri'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        snapshot.data![index]['judul_galeri'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
