import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Smiinfotech extends StatefulWidget {
  const Smiinfotech({Key? key}) : super(key: key);

  @override
  _SmiinfotechState createState() => _SmiinfotechState();
}

class _SmiinfotechState extends State<Smiinfotech> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedText(
              text: Text('𝗦',
                style: TextStyle(fontSize: 300,fontWeight: FontWeight.bold,color: Colors.white,),
              ),
              strokes: [

                OutlinedTextStroke(
                    color: Colors.black,
                    width: 8
                ),
              ],
            ),
            OutlinedText(
              text: Text('𝗠',
                style: TextStyle(fontSize: 300,fontWeight: FontWeight.bold,color: Colors.white,),
              ),
              strokes: [

                OutlinedTextStroke(
                    color: Colors.black,
                    width: 8
                ),

              ],
            ),
            OutlinedText(
              text: Text('𝗜',
                style: TextStyle(fontSize: 300,fontWeight: FontWeight.bold,color: Colors.white,),
              ),
              strokes: [

                OutlinedTextStroke(
                    color: Colors.black,
                    width: 8
                ),

              ],
            )
            ],
        ),
      ),
    );
  }
}

class OutlinedTextStroke {
  final Color? color;
  final double? width;

  OutlinedTextStroke({this.color, this.width});
}

class OutlinedText extends StatelessWidget {
  final Text? text;
  final List<OutlinedTextStroke>? strokes;

  const OutlinedText({Key? key, this.text, this.strokes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];
    final list = strokes ?? [];
    double widthSum = 0;
    for (var i = 0; i < list.length; i++) {
      widthSum += list[i].width ?? 0;
      children.add(Text(text?.data ?? '',
          textAlign: text?.textAlign,
          style: (text?.style ?? TextStyle()).copyWith(
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = widthSum
                ..color = list[i].color ?? Colors.transparent)));
    }

    return Stack(
      children: [...children.reversed, text ?? SizedBox.shrink()],
    );
  }
}
