
import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadPhotos extends StatefulWidget {
  var link;

  DownloadPhotos(this.link);


  @override
  _PhotosviewState createState() => _PhotosviewState();
}

class _PhotosviewState extends State<DownloadPhotos> {

  _save() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      var response = await Dio().get(widget.link, options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 60,
          // name:"${File(widget.link).name}"
          name: "${Random().nextInt(10)}"
      );
      print(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    widget.link,
                    // height: 300,
                  ),
                  fit: BoxFit.fitHeight,
                ),
              ),
              // alignment: Alignment.center,

            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _save();
          },
          label: Icon(Icons.download)),
    );
  }

}
