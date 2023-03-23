import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallpaperDownloader/pages/downloadphotos.dart';

class Photosview extends StatefulWidget {
  const Photosview({Key? key}) : super(key: key);

  @override
  _PhotosviewState createState() => _PhotosviewState();
}

class _PhotosviewState extends State<Photosview> {
  List<String> list = [
    "https://i.pinimg.com/236x/7b/39/f5/7b39f5ca865f3c1d3dd1d0f7b2424072.jpg",
    "https://i.pinimg.com/236x/fd/ce/67/fdce67a3d3fbf6f525a9558e99a4dd94.jpg",
    "https://i.pinimg.com/236x/86/95/b8/8695b8271c92288ca1cb57738cea9a5e.jpg",
    "https://i.pinimg.com/236x/06/c9/f3/06c9f3d8be1fb22676fbbcb550561436.jpg",
    "https://i.pinimg.com/236x/3d/40/17/3d4017ec37998b07df88cf5b033addbd.jpg",
    "https://cdn.wallpapersafari.com/1/17/ZMBC10.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wallpaper Downloader"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: GridView.count(
            shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              crossAxisCount: 2,
              children: List.generate(
                  list.length,
                  (index) => Expanded(
                        child: InkWell(
                          onTap: (){
                            Get.to(DownloadPhotos(list[index]));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              list[index],
                              height: 250,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ))),
        ),
      ),
    );
  }
}
