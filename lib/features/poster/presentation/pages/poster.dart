import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:poster_app/features/poster/presentation/widgets/button.dart';
import 'package:screenshot/screenshot.dart';

class GeneratePosterScreen extends StatefulWidget {
  final File? file;
  final String name;
  final String phoneNo;
  final String imageUrl;

  GeneratePosterScreen({
    required this.file,
    required this.name,
    required this.phoneNo,
    required this.imageUrl,
  });

  @override
  _GeneratePosterScreenState createState() => _GeneratePosterScreenState();
}

class _GeneratePosterScreenState extends State<GeneratePosterScreen> {

  // Offset _offsetPhoto = Offset(0, 0); // Offset(((MediaQuery.of(context).size.width) / 2) - 40, ((MediaQuery.of(context).size.width) / 10));
  // Offset _offsetText = Offset(0, 0); // Offset(((MediaQuery.of(context).size.width) / 2) - 35, ((MediaQuery.of(context).size.width) / 3));

  late Offset _offsetPhoto;
  late Offset _offsetText;
  final GlobalKey _stackKey = GlobalKey();

  File? _image;
  final ScreenshotController _screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateInitialOffsets(context);
    });
    _loadImageFromUrl(widget.imageUrl);
  }

  void _calculateInitialOffsets(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    setState(() {
      _offsetPhoto = Offset(((width) / 2) - 40, ((width) / 10));
      _offsetText = Offset(((width) / 2) - 50, ((width) / 3));
    });
  }

  Future<void> _loadImageFromUrl(String imageUrl) async {
    try {
      final response = await HttpClient().getUrl(Uri.parse(imageUrl));
      final imageStream = await response.close();
      final bytes = await consolidateHttpClientResponseBytes(imageStream);
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/temp_image.jpg');
      await tempFile.writeAsBytes(bytes);
      setState(() {
        _image = tempFile;
      });
    } catch (e) {
      print('Error loading image from URL: $e');
    }
  }

  Future<void> _saveImage() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    final status = await Permission.storage.status;
    if (status.isGranted) {
      final directory = await getExternalStorageDirectory();
      final fileName = DateTime.now().toIso8601String() + '.png';
      final path = '${directory?.path}/$fileName';

      _screenshotController.captureAndSave(directory!.path, fileName: fileName).then((value) {

        // Save image to the gallery
        ImageGallerySaver.saveFile(path).then((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Poster saved to gallery')),
          );
        });

        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Poster saved to $path')),
        // );
      }).catchError((onError) {
        print(onError);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Storage permission is required to save poster')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Builder(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Generate Poster'),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _image != null
                      ? Screenshot(
                    controller: _screenshotController,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.network(widget.imageUrl),
                        Positioned(
                          left: _offsetText.dx,
                          top: _offsetText.dy,
                          bottom: 20,
                          child: GestureDetector(
                            onPanUpdate: (details) {
                              setState(() {
                                _offsetText += details.delta;
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  widget.name,
                                  style: TextStyle(
                                    fontFamily: 'DancingScript',
                                    fontSize: 24,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  widget.phoneNo,
                                  style: TextStyle(
                                    fontFamily: 'EBGaramond',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: _offsetPhoto.dx,
                          top: _offsetPhoto.dy,
                          child: GestureDetector(
                            onPanUpdate: (details) {
                              setState(() {
                                _offsetPhoto += details.delta;
                              });
                            },
                            child: widget.file != null
                                ? CircleAvatar(
                                                          backgroundImage:
                                                          FileImage(widget.file!),
                                                          radius: 40,
                                                        ) : SizedBox(),
                          ),
                        ),
                      ],
                    ),
                  )
                      : CircularProgressIndicator(),
                  SizedBox(height: 20),
                  _image != null
                      ? Container(
                    margin: EdgeInsets.only(left: 40, right: 40, top: 50),
                    height: 60,
                    width: double.infinity,
                        child: CustomButton(
                            label: 'Download Poster',
                            onPress: () { _saveImage(); },
                                      ),
                      )
                      : Container(),
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}