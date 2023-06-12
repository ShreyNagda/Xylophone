import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    windowManager.setTitle("Xylophone");
    windowManager.setMinimumSize(Size(800, 600));
  }
  runApp(XylophoneApp());
}

class XylophoneApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LayoutBuilder(builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    xylophone_Button(1, constraints, Colors.red),
                    xylophone_Button(2, constraints, Colors.orange),
                    xylophone_Button(3, constraints, Colors.yellow),
                    xylophone_Button(4, constraints, Colors.green),
                    xylophone_Button(5, constraints, Colors.blue),
                    xylophone_Button(6, constraints, Colors.indigo),
                    xylophone_Button(7, constraints, Colors.purple),
                    Spacer(),
                  ]),
            ),
          ),
        );
      }),
    );
  }

  Widget xylophone_Button(
    int note_number,
    BoxConstraints constraints,
    Color color,
  ) {
    double padding = 0;
    double height = 0;
    if (constraints.maxHeight > constraints.maxWidth) {
      height = constraints.maxHeight / 10;
      padding = padding / 5;
    } else {
      height = constraints.maxHeight / 10;
      padding = height / 10;
    }
    return ElevatedButton(
      onPressed: () => playAudio(note_number),
      child: Text(""),
      style: _style(
        color,
        constraints.maxHeight / 10,
      ),
    );
  }

  ButtonStyle _style(Color color, double height) {
    return ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(height),
        backgroundColor: color,
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)
    );
  }

  void playAudio(int note_number) {
    final player = AudioPlayer();
    player.play(AssetSource('note$note_number.wav'));
  }
}
