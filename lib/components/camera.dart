import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraButton extends StatefulWidget {
  const CameraButton({super.key});

  @override
  CameraButtonState createState() => CameraButtonState();
}

class CameraButtonState extends State<CameraButton> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      const CameraDescription(
        name: '0',
        lensDirection: CameraLensDirection.back,
        sensorOrientation: 0,
      ),
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        try {
          await _initializeControllerFuture;
          final image = await _controller.takePicture();
        } catch (e) {
          print('Error taking picture: $e');
        }
      },
      child: const Icon(Icons.camera),
    );
  }
}
