import 'package:fhoto_editor/fhoto_editor.dart';
import 'package:flutter/foundation.dart';
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

  double _seekbarValue = 0;

  @override
  Widget build(BuildContext context) {
    final colorGen = ColorFilterGenerator.getInstance();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Color Filter Example'),
        ),
        body: Stack(
          children: [
            Center(
                child: ColorFiltered(
              colorFilter: ColorFilter.matrix(colorGen.getVibrancyMatrix(value: _seekbarValue)),
              child: Image.asset('assets/shahid.jpeg'),
            )),
            Column(
              children: [
                Slider(
                  divisions: 100,
                  label: 'Hue',
                  onChanged: (value) {
                    setState(() {
                      _seekbarValue = value ;
                    });
                  },
                  max: 100,
                  min: -100,
                  value: _seekbarValue,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
