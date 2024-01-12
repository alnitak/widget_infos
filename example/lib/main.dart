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
  double size = 100;
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
                child: InfosReporter(
                  child: GestureDetector(
                    onTap: () => setState(() => size = size == 100 ? 200 : 100),
                    onPanUpdate: (details) {
                      position += details.delta;
                      setState(() {});
                    },
                    child: AnimatedSize(
                      duration: const Duration(milliseconds: 250),
                      child: Container(
                        /// The UniqueKey is needed here to rebuild this
                        /// Container and notify [InfosReporter] that
                        /// something changed 
                        key: UniqueKey(),
                        width: size,
                        height: size,
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
