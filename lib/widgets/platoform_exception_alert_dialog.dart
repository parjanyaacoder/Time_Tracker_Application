
import 'package:flutter/services.dart';
import 'package:time_tracker_application/widgets/platform_alert_dialog.dart';

class PlatformExceptionAlertDialog extends PlatformAlertDialog {
  PlatformExceptionAlertDialog({String title,PlatformException exception})
  :super (
    title:title,
    content:exception.message,
    defaultActionText:'Ok',
  );
}