import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {

  final Widget child;
  final Color color;
  final double borderRadius;
  final VoidCallback onPressed;
  final double height;
  const CustomRaisedButton({ this.height:50.0,this.color, this.borderRadius:2.0, this.onPressed, this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:height,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
        onPressed: onPressed,
        disabledColor: color,
        child: child,
        color: color,
      ),
    );
  }
}
