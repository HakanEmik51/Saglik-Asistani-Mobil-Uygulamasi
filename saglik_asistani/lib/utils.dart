import 'dart:async';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:saglik_asistani/database_service.dart';
import 'package:saglik_asistani/firebase_options.dart';
import 'package:saglik_asistani/media_service.dart';
import 'package:saglik_asistani/navigation_service.dart';
import 'package:saglik_asistani/storage_service.dart';

Future<void> setupFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> registerService() async {
  final GetIt getIt = GetIt.instance;
  getIt.registerSingleton<DatabaseService>(
    DatabaseService(),
  );
  getIt.registerSingleton<NavigationService>(
    NavigationService(),
  );
  getIt.registerSingleton<MediaService>(
    MediaService(),
  );
  getIt.registerSingleton<StorageService>(
    StorageService(),
  );
}

String generateChatID({required String uid1, required String uid2}) {
  List uids = [uid1, uid2];
  uids.sort();
  String chatID = uids.fold("", (id, uid) => "$id$uid");
  return chatID;
}
