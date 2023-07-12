import 'package:fhoto_editor/fhoto_editor.dart';
import 'package:fhoto_editor_example/features/cropping/cropping.dart';
import 'package:fhoto_editor_example/features/transformation/flip.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../transformation/rotate.dart';

class MultiColorFilterExample extends StatefulWidget {
  const MultiColorFilterExample({Key? key}) : super(key: key);

  @override
  State<MultiColorFilterExample> createState() =>
      _MultiColorFilterExampleState();
}

class _MultiColorFilterExampleState extends State<MultiColorFilterExample> {
  @override
  void initState() {
    super.initState();
  }

  double _brightnessValue = 0;
  double _hueSeekbarValue = 0;
  double _contrastSeekbarValue = 0;
  double _saturationSeekbarValue = 0.7;
  double _exposureSeekbarValue = .3;
  double _shadowSeekbarValue = .5;
  double _highlightedSeekbarValue = 0.1;
  double _fadedSeekbarValue = .1;
  double _vibrancySeekbarValue = 0;
  double _temperatureSeekbarValue = .1;

  bool _isCropClicked = false;
  bool _isRotateClicked = false;
  bool _isFlip = false;

  @override
  Widget build(BuildContext context) {
    final colorGen = ColorFilterGenerator.getInstance();

    /// Apply multi filter on Image

    ColorMultiFilterGenerator myFilter = ColorMultiFilterGenerator(filters: [
       colorGen.getHueMatrix(value: _hueSeekbarValue),
       colorGen.getContrastMatrix(value: _contrastSeekbarValue),
       colorGen.getBrightnessMatrix(value: _brightnessValue),
       colorGen.getSaturationMatrix(value: _saturationSeekbarValue),
       colorGen.getExposureMatrix(value: _exposureSeekbarValue),
       colorGen.getShadowMatrix(value: _shadowSeekbarValue),
       colorGen.getHighlightedMatrix(value: _highlightedSeekbarValue),
       colorGen.getFadedMatrix(value: _fadedSeekbarValue),
       colorGen.getVibrancyMatrix(value: _vibrancySeekbarValue),
       colorGen.getTemperatureMatrix(value: _temperatureSeekbarValue),
    ]);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Color Filter Example'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                  child: ColorFiltered(
                      colorFilter: ColorFilter.matrix(myFilter.matrix),
                      child: Image.asset('assets/shahid.jpeg'))),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("Hue"),
                      Slider(
                        divisions: 100,
                        label: 'Hue',
                        onChanged: (value) {
                          setState(() {
                            _hueSeekbarValue = value;
                          });
                        },
                        max: 1,
                        min: 0,
                        value: _hueSeekbarValue,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("Contrast"),
                      Slider(
                        divisions: 100,
                        label: 'Contrast',
                        onChanged: (value) {
                          setState(() {
                            _contrastSeekbarValue = value;
                            // _contrastSeekbarValue=_contrastSeekbarValue/100;
                          });
                        },
                        max: 1,
                        min: 0,
                        value: _contrastSeekbarValue,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("Brightness"),
                      Slider(
                        divisions: 100,
                        label: 'Brightness',
                        onChanged: (value) {
                          setState(() {
                            _brightnessValue = value;
                          });
                        },
                        max: 1,
                        min: 0,
                        value: _brightnessValue,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("Saturation"),
                      Slider(
                        divisions: 100,
                        label: 'Saturation',
                        onChanged: (value) {
                          setState(() {
                            _saturationSeekbarValue = value;
                          });
                        },
                        max: 1,
                        min: 0,
                        value: _saturationSeekbarValue,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("Exposure"),
                      Slider(
                        divisions: 100,
                        label: 'Exposure',
                        onChanged: (value) {
                          setState(() {
                            _exposureSeekbarValue = value;
                          });
                        },
                        max: 1,
                        min: 0,
                        value: _exposureSeekbarValue,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("Shadow"),
                      Slider(
                        divisions: 100,
                        label: 'Shadow',
                        onChanged: (value) {
                          setState(() {
                            _shadowSeekbarValue = value;
                          });
                        },
                        max: 1,
                        min: 0,
                        value: _shadowSeekbarValue,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("Highlighted"),
                      Slider(
                        divisions: 100,
                        label: 'Highlighted',
                        onChanged: (value) {
                          setState(() {
                            _highlightedSeekbarValue = value;
                          });
                        },
                        max: 1,
                        min: 0,
                        value: _highlightedSeekbarValue,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("Faded"),
                      Slider(
                        divisions: 100,
                        label: 'Faded',
                        onChanged: (value) {
                          setState(() {
                            _fadedSeekbarValue = value;
                          });
                        },
                        max: 1,
                        min: 0,
                        value: _fadedSeekbarValue,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("Vibrancy"),
                      Slider(
                        divisions: 100,
                        label: 'Vibrancy',
                        onChanged: (value) {
                          setState(() {
                            _vibrancySeekbarValue = value;
                          });
                        },
                        max: 1,
                        min: 0,
                        value: _vibrancySeekbarValue,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text("Temperature"),
                      Slider(
                        divisions: 100,
                        label: 'Temperature',
                        onChanged: (value) {
                          setState(() {
                            _temperatureSeekbarValue = value;
                          });
                        },
                        max: 1,
                        min: 0,
                        value: _temperatureSeekbarValue,
                      ),
                    ],
                  ),
                ],
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RotateImage()),
                    );
                  },
                  child: const Text("Rotate Image")),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FlipImage()),
                    );
                  },
                  child: const Text("Flip Image")),
        if(!kIsWeb)   TextButton(
                  onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Cropping()),
                      );
                  },
                  child: const Text("Crop Image"))
            ],
          ),
        ),
      ),
    );
  }
}
