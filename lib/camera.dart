import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

class CameraApp extends StatefulWidget {
  final List<CameraDescription> cameras;

  CameraApp(this.cameras);

  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  CameraController controller;

  _CameraAppState();

  @override
  void initState() {
    super.initState();
    widget.cameras.forEach((camera) {
      if (camera.lensDirection == CameraLensDirection.front) {
        controller = CameraController(camera, ResolutionPreset.high);
      }
    });
    if (controller == null)
      controller = CameraController(widget.cameras[0], ResolutionPreset.high);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return ListView(
      children: <Widget>[
        AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: CameraPreview(controller)),
        GestureDetector(
            onTap: () async {
              Directory dir = await getExternalStorageDirectory();
              var path = dir.path +
                  "/" +
                  DateTime.now().millisecondsSinceEpoch.toString() +
                  ".jpg";
              print(path);
              controller.takePicture(path);
            },
            child: Icon(
              Icons.camera_alt,
              size: 50.0,
              color: Colors.white,
            ))
      ],
    );
  }
}
