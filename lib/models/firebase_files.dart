import 'package:firebase_storage/firebase_storage.dart';

class FirebaseFiles{

  final Reference ref;
  final String category;
  final String name;
  final String url;

  const FirebaseFiles({
    required this.ref,
    required this.category,
    required this.name,
    required this.url,
  });

}