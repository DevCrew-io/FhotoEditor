import 'dart:math';
import 'package:fhoto_editor/fhoto_editor.dart';
import 'package:flutter/material.dart';

class FlipImage extends StatefulWidget {
  const FlipImage({Key? key}) : super(key: key);

  @override
  State<FlipImage> createState() => _FlipImageState();
}

class _FlipImageState extends State<FlipImage> {
  double _rotation = 0.0;
  bool _isVerticalFlip = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              children: <Widget>[
                flipImage(
                    Image.network("https://www.gstatic.com/webp/gallery/1.jpg"),
                    _rotation,
                    _isVerticalFlip),
                const Expanded(
                  child: Text("Bottom"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        onPressed: () {
                          _isVerticalFlip = true;
                          setState(() {
                            _rotation == 0.0?  _rotation = pi: _rotation = 0.0;
                          });
                        },
                        child: const Text("Flip Horizontal")),
                    TextButton(
                        onPressed: () {
                          _isVerticalFlip = false;
                          setState(() {
                            _rotation == 0.0?  _rotation = pi: _rotation = 0.0;
                          });
                        },
                        child: const Text("Flip Vertical"))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
