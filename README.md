Widget to listen to size and position changes of its child

```dart
NotificationListener<InfosReporterNotification>(
    onNotification: (notification) {
        debugPrint('position: ${notification.position}   size: ${notification.size}');
        return true;
    },
    child: InfosReporter(
        child: Container(
        /// The UniqueKey is needed here to rebuild this
        /// Container and notify [InfosReporter] that
        /// something changed 
        key: UniqueKey(),
        width: _size,
        height: _size,
        color: Colors.red,
        ),
    ),
),
```