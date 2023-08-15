import 'dart:io';
import 'package:camera/camera.dart';
import 'package:camera_app/ImageScreen.dart';
import 'package:camera_app/functions.dart';
import 'package:camera_app/gallery_scrn.dart';
import 'package:flutter/material.dart';


late List<CameraDescription> cameras;

class CameraApp extends StatefulWidget {
  const CameraApp({super.key});

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController _controller;
  @override
  void initState() {
    super.initState();
    getImages();
    _controller = CameraController(cameras[0], ResolutionPreset.max);
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccesDenied':
            break;
          default:
            break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              child: CameraPreview(_controller),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: InkWell(
                      onTap: () async {
                        if (!_controller.value.isInitialized) {
                          return ;
                        }
                        if (_controller.value.isTakingPicture) {
                          return ;
                        }

                        try {
                          await _controller.setFlashMode(FlashMode.auto);
                          XFile file = await _controller.takePicture();
                          await storeImage(file);
                          setState(() {});
                          if (context.mounted) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ImagePreview(file)));
                          }
                        } on CameraException catch (e) {
                          debugPrint('Error Occured While Taking Picture : $e');
                          return ;
                        }
                      },
                      child: const CircleAvatar(
                        radius: 32,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        floatingActionButton: imageNotifier.isNotEmpty
            ? FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MyWidget(),
                  ));
                },
                child: CircleAvatar(
                  radius: 26,
                  backgroundImage:
                      FileImage(File(imageNotifier[imageNotifier.length - 1])),
                ),
              )
            : const SizedBox());
  }
}
