import 'dart:typed_data';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:fhoto_editor/fhoto_editor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

/// RenderRepaintBoundary class is used to capture the screenshot of child widget

class SaveColourFilterImageExample extends StatefulWidget {
  const SaveColourFilterImageExample({Key? key}) : super(key: key);

  @override
  State<SaveColourFilterImageExample> createState() => _SaveColourFilterImageExampleState();
}

class _SaveColourFilterImageExampleState extends State<SaveColourFilterImageExample> {
  final GlobalKey _key = GlobalKey();
  final colorGen = ColorFilterGenerator.getInstance();


  void saveImage(ui.Image image) async {
    // Create a ByteData buffer to hold the image data.
    final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();

    // Get the device's default directory for storing files.
    final directory = await getTemporaryDirectory();

    // Create a file to write the image data to.
    final File file = File('${directory.path}/filtered_image.png');

    // Write the image data to the file.
    await file.writeAsBytes(pngBytes);

    if (kDebugMode) {
      print("File Saved:${file.path}");
    }
  }

  @override
  Widget build(BuildContext context) {

    /// Apply saturation and brightness filter together

    ColorMultiFilterGenerator myFilter = ColorMultiFilterGenerator(
        filters: [
          colorGen.getSaturationMatrix(value: .2),
          colorGen.getBrightnessMatrix(value: 0),

        ]
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Save ColorFiltered Image'),
      ),
      body: Center(
        child: RepaintBoundary(
          key: _key,
          child: ColorFiltered(
            colorFilter: ColorFilter.matrix(myFilter.matrix),
            child:  Image.asset("assets/shahid.jpeg"),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Get the rendered image from the RepaintBoundary.
          final image = await _getImageFromRepaintBoundary();

          // Save the image to disk.
          saveImage(image);
        },
        tooltip: 'Save Image',
        child: const Icon(Icons.save),
      ),
    );
  }

  /// RenderRepaintBoundary widget to capture a snapshot of a specific area of
  /// the screen and converts it into a ui.Image object.

  Future<ui.Image> _getImageFromRepaintBoundary() async {
    RenderRepaintBoundary boundary =
    _key.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    return image;
  }
}