import 'package:fhoto_editor/fhoto_editor.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    final colorGen = ColorFilterGenerator.getInstance();

    /// Apply multi filter on Image

    ColorMultiFilterGenerator myFilter = ColorMultiFilterGenerator(filters: [
      colorGen.getContrastMatrix(value: .5),
      colorGen.getBrightnessMatrix(value: _brightnessValue / 20),
    ]);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Color Filter Example'),
        ),
        body: Stack(
          children: [
            Center(
                child: ColorFiltered(
                    colorFilter: ColorFilter.matrix(myFilter.matrix),
                    child: Image.asset('assets/shahid.jpeg'))),
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
                  max: 20,
                  min: 0,
                  value: _brightnessValue,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
