import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:higym/models/firebase_files.dart';
import 'package:higym/services/downloader.dart';
import 'package:higym/widgets/general_widgets/loading_widget.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:developer' as dev;

class Achievement extends StatefulWidget {
  const Achievement({Key? key}) : super(key: key);

  @override
  State<Achievement> createState() => _AchievementState();
}

class _AchievementState extends State<Achievement> {
  late Future<List<FirebaseFiles>> futureFiles;
  late String dir;
  final ref = FirebaseStorage.instance.ref('images/deadlifts.png');
  @override
  void initState() {
    super.initState();
    futureFiles = Downloader.listAll('images/');
    getDir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<FirebaseFiles>>(
      future: futureFiles,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: LoadingWidget());
          default:
            if (snapshot.hasError) {
              return const Center(child: Text('ERROR!'));
            } else {
              final files = snapshot.data!;
              return ListView.builder(
                  itemCount: files.length,
                  itemBuilder: (context, index) {
                    final file = files[index];
                    return buildFile(context, file);
                  });
            }
        }
      },
    ));
  }

  Widget buildFile(BuildContext context, FirebaseFiles file) {
    // Downloader.checkAndDownload( Plans());

    return Container(
      child: Row(
        children: [
          Text(file.name),
          SizedBox(
            height: 100,
            child: File('$dir/${file.name}').existsSync() ? Image.file(File('$dir/${file.name}')) : const Icon(Icons.image_rounded),
          ),
          IconButton(
            onPressed: () {
              Downloader.downloadAndSaveSingle(file.ref);
              setState(() {});
            },
            icon: const Icon(Icons.save_rounded),
          ),
          IconButton(
            onPressed: () {
              deleteFile('$dir/images/${file.name}');
              setState(() {});
            },
            icon: const Icon(Icons.delete_rounded),
          ),
        ],
      ),
    );
  }

  Future<void> getDir() async {
    dir = (await getApplicationDocumentsDirectory()).path;
  }

  Future<void> deleteFile(String myPath) async {
    if (File(myPath).existsSync()) {
      File(myPath).delete();
    }
  }
}
