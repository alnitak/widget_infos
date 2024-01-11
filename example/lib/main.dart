import 'package:flutter/material.dart';
import 'package:widget_infos/widget_infos.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  double _size = 100;
  Offset position = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Positioned(
              left: position.dx,
              top: position.dy,
              child: NotificationListener<InfosReporterNotification>(
                onNotification: (notification) {
                  debugPrint('position: ${notification.position}   size: ${notification.size}');
                  return true;
                },
                child: GestureDetector(
                  onTap: () => setState(() => _size = _size == 100 ? 200 : 100),
                  onPanUpdate: (details) {
                    position += details.delta;
                    setState(() {});
                  },
                  child: InfosReporter(
                    child: AnimatedSize(
                      duration: const Duration(milliseconds: 250),
                      child: Container(
                        width: _size,
                        height: _size,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
