import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class InfosReporterNotification extends Notification {
  const InfosReporterNotification(this.position, this.size);

  /// Notification data.
  final Offset position;

  /// Notification data.
  final Size size;
}

/// A widget that reports its child's size & position to the notification system.
class InfosReporter extends SingleChildRenderObjectWidget {
  const InfosReporter({super.key, required super.child});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderInfosReporter(context: context);
  }

}

class RenderInfosReporter extends RenderProxyBox {
  RenderInfosReporter({
    required BuildContext context,
    RenderBox? child,
  })  : _context = context,
        super(child);

  /// Required to access the [BuildContext] to dispatch the notification.
  final BuildContext _context;

  /// The previous bounds of the child.
  Offset? oldPosition;

  /// The previous size of the child.
  Size? oldSize;

  @override
  void performLayout() {
    /// Takes care of laying out the child and making sure its size is usable.
    super.performLayout();

    final newPosition = child!.localToGlobal(Offset.zero);
    final newSize = child!.size;

    /// Only dispatch the notification if the size has changed.
    if (oldPosition != newPosition || oldSize != newSize) {
      oldPosition = newPosition;
      InfosReporterNotification(newPosition, newSize).dispatch(_context);
    }
  }
}
