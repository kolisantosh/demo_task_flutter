import 'package:flutter/material.dart';

class BirjWidget extends StatefulWidget {
  var size;
  BirjWidget(this.size);

  @override
  _BirjWidgetState createState() => _BirjWidgetState();
}

class _BirjWidgetState extends State<BirjWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15,
      child: Container(
        height: 50,
        width: widget.size,
        color: Colors.green,

      ),
    );
  }
}
class CustomClipperImage extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    // path.arcToPoint(Offset(size.width, size.height),
    //     radius: Radius.elliptical(30, 10));
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
  }