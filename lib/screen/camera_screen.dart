import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  List<File> pics = [];
  List<bool> picIsLandscapes = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Camera Screen")),
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Column(children: [
          ElevatedButton(onPressed: ambilFoto, child: const Text("Ambil Foto")),
          const Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                spacing: 10,
                children: pics.map((pic) {
                  var lebarLayar = MediaQuery.of(context).size.width;
                  var lebarContainer = lebarLayar - 32;
                  int idx = pics.indexOf(pic);
                  var lebarImgPortrait = (picIsLandscapes[idx])
                      ? lebarContainer
                      : (lebarContainer - 20) / 3;

                  return Image.file(pic, width: lebarImgPortrait);
                }).toList(),
              ),
            ),
          )
          // Expanded(
          //     child: ListView.builder(
          //   itemCount: pics.length,
          //   itemBuilder: (ctx, idx) {
          //     var img = pics[idx];
          //     return Image.file(img);
          //   },
          // ))
        ]),
      ),
    );
  }

  void ambilFoto() async {
    final pic = await ImagePicker().pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
        imageQuality: 20);

    if (pic == null) return;
    var decodedImage = await decodeImageFromList(await pic.readAsBytes());

    picIsLandscapes.add(decodedImage.width > decodedImage.height);
    pics.add(File(pic.path));
    setState(() {});
  }
}
