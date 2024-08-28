import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:saglik_asistani/database_service.dart';
import 'package:saglik_asistani/media_service.dart';
import 'package:saglik_asistani/model/chat.dart';
import 'package:saglik_asistani/model/doktor.dart';
import 'package:saglik_asistani/model/kullanici.dart';
import 'package:saglik_asistani/model/message.dart';
import 'package:saglik_asistani/storage_service.dart';
import 'package:saglik_asistani/utils.dart';

class chatEkrani extends StatefulWidget {
  final Doktor chatUser;
  const chatEkrani({
    super.key,
    required this.chatUser,
  });

  @override
  State<chatEkrani> createState() => _chatEkraniState();
}

class _chatEkraniState extends State<chatEkrani> {
  final GetIt get_It = GetIt.instance;
  late DatabaseService _databaseService;
  late MediaService _mediaService;
  late StorageService _storageService;
  ChatUser? currentUser, otherUser;
  @override
  void initState() {
    super.initState();
    _databaseService = get_It.get<DatabaseService>();
    _mediaService = get_It.get<MediaService>();
    _storageService = get_It.get<StorageService>();
    currentUser = ChatUser(
        id: FirebaseAuth.instance.currentUser!.uid,
        firstName: FirebaseAuth.instance.currentUser!.displayName);
    otherUser = ChatUser(
      id: widget.chatUser.id,
      firstName: widget.chatUser.ad,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatUser.ad!),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return StreamBuilder(
        stream: _databaseService.getChatData(currentUser!.id, otherUser!.id),
        builder: (context, snapshot) {
          Chat? chat = snapshot.data?.data();
          List<ChatMessage> messages = [];
          if (chat != null && chat.messages != null) {
            messages = _generateChatMessagesList(
              chat.messages!,
            );
          }
          return DashChat(
            messageOptions: const MessageOptions(
              showOtherUsersAvatar: true,
              showTime: true,
            ),
            inputOptions: InputOptions(
              alwaysShowSend: true,
              trailing: [
                _mediaMessageButton(),
              ],
            ),
            currentUser: currentUser!,
            onSend: _sendMessage,
            messages: messages,
          );
        });
  }

  Future<void> _sendMessage(ChatMessage chatMessage) async {
    if (chatMessage.medias?.isNotEmpty ?? false) {
      if (chatMessage.medias!.first.type == MediaType.image) {
        Message message = Message(
          senderID: chatMessage.user.id,
          content: chatMessage.medias!.first.url,
          messageType: MessageType.Image,
          sentAt: Timestamp.fromDate(chatMessage.createdAt),
        );
        await _databaseService.sendChatMessage(
            currentUser!.id, otherUser!.id, message);
      }
    } else {
      Message message = Message(
        senderID: currentUser!.id,
        content: chatMessage.text,
        messageType: MessageType.Text,
        sentAt: Timestamp.fromDate(chatMessage.createdAt),
      );
      await _databaseService.sendChatMessage(
        currentUser!.id,
        otherUser!.id,
        message,
      );
    }
  }

  List<ChatMessage> _generateChatMessagesList(List<Message> messages) {
    List<ChatMessage> chatMessages = messages.map((m) {
      if (m.messageType == MessageType.Image) {
        return ChatMessage(
            user: m.senderID == currentUser!.id ? currentUser! : otherUser!,
            createdAt: m.sentAt!.toDate(),
            medias: [
              ChatMedia(url: m.content!, fileName: "", type: MediaType.image),
            ]);
      } else {
        return ChatMessage(
          user: m.senderID == currentUser!.id ? currentUser! : otherUser!,
          text: m.content!,
          createdAt: m.sentAt!.toDate(),
        );
      }
    }).toList();
    chatMessages.sort(
      (a, b) {
        return b.createdAt.compareTo(a.createdAt);
      },
    );
    return chatMessages;
  }

  Widget _mediaMessageButton() {
    return IconButton(
      onPressed: () async {
        File? file = await _mediaService.getImageFromGallery();
        if (file != null) {
          String chatID =
              generateChatID(uid1: currentUser!.id, uid2: otherUser!.id);
          String? dowloadURL = await _storageService.uploadImageToChat(
              file: file, chatID: chatID);
          if (dowloadURL != null) {
            ChatMessage chatMessage = ChatMessage(
                user: currentUser!,
                createdAt: DateTime.now(),
                medias: [
                  ChatMedia(
                      url: dowloadURL, fileName: "", type: MediaType.image)
                ]);
            _sendMessage(chatMessage);
          }
        }
      },
      icon: Icon(
        Icons.image,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
