import 'package:saglik_asistani/model/message.dart';

class Chat {
  String? id;
  List<String>? participants;
  List<Message>? messages;

  Chat({
    required this.id,
    required this.participants,
    required this.messages,
  });

  // JSON'dan Chat nesnesine dönüşüm
  Chat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    participants = List<String>.from(json['participants']);
    messages =
        List<Message>.from(json['messages'].map((m) => Message.fromJson(m)));
  }

  // Chat nesnesinden JSON'a dönüşüm
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['participants'] = participants;
    data['messages'] = messages?.map((m) => m.toJson()).toList() ?? [];
    return data;
  }
}
