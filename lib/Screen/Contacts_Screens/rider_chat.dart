import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class RiderChat extends StatefulWidget {
  const RiderChat({super.key});

  @override
  State<RiderChat> createState() => _RiderChatState();
}

class _RiderChatState extends State<RiderChat> {
   final List<types.Message> _messages = [];
  final _user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
       
        title: Text(
          'chat'.tr,
          textAlign: TextAlign.center,
          style: GoogleFonts.raleway(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            height: 1.175,
            color: const Color(0xFF1272D3),
          ),
        ),
        centerTitle: true,
      ),
      body: Chat(messages:_messages, onSendPressed: _handleSendPressed, user: _user,),
    );
  }
   void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: "id",
      text: message.text,
    );

    _addMessage(textMessage);
  }
   void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }
}