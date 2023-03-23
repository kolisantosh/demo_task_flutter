import 'package:flutter/material.dart';

class ImageSliderWidget extends StatefulWidget {
  const ImageSliderWidget({Key? key}) : super(key: key);

  @override
  State<ImageSliderWidget> createState() => _ImageSliderWidgetState();
}

class _ImageSliderWidgetState extends State<ImageSliderWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        child: ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: List.generate(4, (index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  decoration:BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Image.network(
                      "https://soliloquywp.com/wp-content/uploads/2019/02/nb_pss_2.jpg")),
            );
          }),
        ));
  }
}
