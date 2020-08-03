
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:time_tracker_application/widgets/platform_widget.dart';

class PlatformAlertDialog extends PlatformWidget {
  @required final String title;
  @required final String content;
  final String cancelActiontext;
  @required final String defaultActionText;

  Future<bool> show(BuildContext context)
  async {
    return Platform.isIOS ? await showCupertinoDialog<bool>(context: context, builder:(context)=>this):await showDialog<bool>(
      context: context,builder: (context) => this,
      barrierDismissible: true,
    );
  }

  PlatformAlertDialog({this.cancelActiontext,this.title, this.content, this.defaultActionText})
  : assert (title!=null),
        assert (content!=null),
        assert (defaultActionText!=null);

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    // TODO: implement buildCupertinoWidget
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: _buildActions(context),
    );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    // TODO: implement buildMaterialWidget
   return AlertDialog(
     title: Text(title),
     content: Text(content),
     actions: _buildActions(context),
   );
  }

  List<Widget> _buildActions(BuildContext context){

    return [ PlatformAlertDialogAction(
     Text(defaultActionText),
      () => Navigator.of(context).pop(),
    )];
  }

}

class PlatformAlertDialogAction extends PlatformWidget {
  final Widget child;
  final VoidCallback onPressed;

  PlatformAlertDialogAction(this.child, this.onPressed);

  @override
  Widget buildCupertinoWidget(BuildContext context) {
    // TODO: implement buildCupertinoWidget
   return CupertinoDialogAction(
     child: child,
     onPressed: onPressed,
   );
  }

  @override
  Widget buildMaterialWidget(BuildContext context) {
    // TODO: implement buildMaterialWidget
    return FlatButton(
      child: child,
      onPressed: onPressed,
    );
  }
}