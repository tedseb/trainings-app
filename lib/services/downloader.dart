import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:higym/models/firebase_files.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:developer' as dev;

import '../models/goal.dart';

class Downloader {
  // final Plans? selectedPlan;

  // Downloader({this.selectedPlan});

  final fireBaseInstance = FirebaseStorage.instance;

  static Future<List<FirebaseFiles>> listAll(String path) async {
    final ref = FirebaseStorage.instance.ref(path);
    final result = await ref.listAll();

    final urls = await _getDownloadLinks(result.items);

    return urls
        .asMap()
        .map((index, url) {
          final ref = result.items[index];

          final name = ref.name;

          final file = FirebaseFiles(ref: ref, category: 'image', name: name, url: url);
          return MapEntry(index, file);
        })
        .values
        .toList();
  }

  static Future<List<String>> _getDownloadLinks(List<Reference> refs) {
    return Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());
  }

  static Future downloadAndSaveSingle(Reference ref) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/${ref.name}');
    dev.log(ref.name.toString());

    await ref.writeToFile(file);
  }

  // static Future getImageAndVideo(){

  // }

  static Future checkAndDownload(Plans myPlan) async {
    final dir = await getApplicationDocumentsDirectory();
    // List allImages = [];
    // List allVideos = [];

    final imagesDir = Directory('${dir.path}/images');
    final videosDir = Directory('${dir.path}/videos');

    /// Check Images Path and get all Images in it
    if (imagesDir.existsSync()) {
      // imagesDir.deleteSync(recursive: true);
      // allImages = Directory('${dir.path}/images').listSync();
    }

    /// Check Videos Path and get all Videos in it
    if (videosDir.existsSync()) {
      // videosDir.deleteSync(recursive: true);
      // allVideos = Directory('${dir.path}/videos').listSync();
    }
    await imagesDir.create();
    await videosDir.create();

    for (Exercises exe in myPlan.exercises) {
      _downloadAndSave('images/${exe.media}.png', videosDir);
      _downloadAndSave('videos/${exe.media}.mp4', videosDir);
    }
  }

  static Future _downloadAndSave(String refDir, Directory dir) async {
    Reference ref = FirebaseStorage.instance.ref(refDir);

    final file = File('${dir.path}/${ref.name}');
    dev.log(file.path);
    await ref.writeToFile(file);
  }
}
