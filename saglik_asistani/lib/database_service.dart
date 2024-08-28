import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saglik_asistani/model/chat.dart';
import 'package:saglik_asistani/model/kullanici.dart';
import 'package:saglik_asistani/model/message.dart';
import 'package:saglik_asistani/utils.dart';

class DatabaseService {
  DatabaseService() {
    _setupCollectionReferences();
  }
  CollectionReference? _chatsCollection;
  // CollectionReference? _userCollection;

  void _setupCollectionReferences() {
    // _userCollection = FirebaseFirestore.instance
    //     .collection('kullaniciler')
    //     .withConverter<Kullanici>(
    //       fromFirestore: (snapshots, _) => Kullanici.fromJson(
    //         snapshots.data()!,
    //       ),
    //       toFirestore: (userProfile, _) => userProfile.toJson(),
    //     );
    _chatsCollection = FirebaseFirestore.instance
        .collection('chats')
        .withConverter<Chat>(
            fromFirestore: (Snapshot, _) => Chat.fromJson(Snapshot.data()!),
            toFirestore: (Chat, _) => Chat.toJson());
  }

  Future<bool> chatSec(String uid1, String uid2) async {
    String chatID = generateChatID(uid1: uid1, uid2: uid2);
    final result = await _chatsCollection?.doc(chatID).get();
    if (result != null) {
      return result.exists;
    }
    return false;
  }

  Future<void> createNewChat(String uid1, String uid2) async {
    String chatID = generateChatID(uid1: uid1, uid2: uid2);
    final docRef = _chatsCollection!.doc(chatID);
    final chat = Chat(
      id: chatID,
      participants: [uid1, uid2],
      messages: [],
    );
    await docRef.set(chat);
  }

  Future<void> sendChatMessage(
      String uid1, String uid2, Message message) async {
    String chatID = generateChatID(uid1: uid1, uid2: uid2);
    final docRef = _chatsCollection!.doc(chatID);
    await docRef.update(
      {
        "messages": FieldValue.arrayUnion(
          [
            message.toJson(),
          ],
        ),
      },
    );
  }

  Stream getChatData(String uid1, String uid2) {
    String chatID = generateChatID(uid1: uid1, uid2: uid2);
    return _chatsCollection?.doc(chatID).snapshots()
        as Stream<DocumentSnapshot<Chat>>;
  }
}
