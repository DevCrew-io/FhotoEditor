import 'package:fhoto_editor/image_crop.dart';
import 'package:flutter/material.dart';

class ColorFilterExample extends StatefulWidget {
  const ColorFilterExample({Key? key}) : super(key: key);

  @override
  State<ColorFilterExample> createState() => _ColorFilterExampleState();
}

class _ColorFilterExampleState extends State<ColorFilterExample> {
  @override
  void initState() {
    super.initState();
  }

  double _hueValue = 0;
  double _brightnessValue = 0;
  double _saturationValue = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Color Filter Example'),
        ),
        body: Stack(
          children: [
            Center(
              child: imageColorFilter(
                  hue: _hueValue / 200,
                  brightness: _brightnessValue / 200,
                  saturation: _saturationValue / 200,
                  child: Container(
                      decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "https://www.gstatic.com/webp/gallery/1.jpg"),
                    ),
                  ))),
            ),
            Column(
              children: [
                Slider(
                  divisions: 100,
                  label: 'Brightness',
                  onChanged: (value) {
                    setState(() {
                      _brightnessValue = value;
                    });
                  },
                  max: 200,
                  min: -200,
                  value: _brightnessValue,
                ),
                const SizedBox(
                  height: 10,
                ),
                Slider(
                  divisions: 100,
                  label: 'Hue',
                  onChanged: (value) {
                    setState(() {
                      _hueValue = value;
                    });
                  },
                  max: 200,
                  min: -200,
                  value: _hueValue,
                ),
                const SizedBox(
                  height: 10,
                ),
                Slider(
                  divisions: 100,
                  label: 'Saturation',
                  onChanged: (value) {
                    setState(() {
                      _saturationValue = value;
                    });
                  },
                  max: 200,
                  min: -200,
                  value: _saturationValue,
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
