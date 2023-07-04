import 'package:fhoto_editor/fhoto_editor.dart';
import 'package:flutter/material.dart';

class RotateImage extends StatefulWidget {
  const RotateImage({Key? key}) : super(key: key);

  @override
  State<RotateImage> createState() => _RotateImageState();
}

class _RotateImageState extends State<RotateImage> {
  final kInnerDecoration = BoxDecoration(
    color: Colors.white,
    border: Border.all(color: Colors.white),
    borderRadius: BorderRadius.circular(32),
  );
  double _rotation = 0.0;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              children: <Widget>[
                rotateWidget(
                    Image.asset("assets/shahid.jpeg"),
                    _rotation),
                Slider(
                  divisions: 100,
                  label: 'Rotate',
                  onChanged: (value) {
                    setState(() {
                      _rotation = value;
                    });
                  },
                  max: 10,
                  min: -20,
                  value: _rotation,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
