import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:poster_app/features/poster/presentation/pages/poster.dart';
import 'package:poster_app/features/poster/presentation/widgets/button.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../utils/methods.dart';

class TemplateScreen extends StatefulWidget {
  final File? file;
  final String name;
  final String phoneNo;

  TemplateScreen({
    required this.file,
    required this.name,
    required this.phoneNo,
  });

  @override
  _TemplateScreenState createState() => _TemplateScreenState();
}

class _TemplateScreenState extends State<TemplateScreen> {

  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref("imageurl");
  List<String> _imageUrls = [];

  @override
  void initState() {
    super.initState();
    _fetchImageUrls();
  }

  Future<void> _fetchImageUrls() async {
    _databaseRef.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      setState(() {
        _imageUrls = data.values.map((url) => url.toString()).toList();
      });
    });

    _imageUrls = removeDuplicates(_imageUrls);
  }

  @override
  Widget build(BuildContext context) {

    return Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Select Template'),
            ),
            body: _imageUrls.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: _imageUrls.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GeneratePosterScreen(
                          name: widget.name,
                          phoneNo: widget.phoneNo,
                          file: widget.file,
                          imageUrl: _imageUrls[index],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1.5,
                              ),
                            ),
                            child: Image.network(_imageUrls[index])),
                        SizedBox(height: 10)
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
    );
  }
}