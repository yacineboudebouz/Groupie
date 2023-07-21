import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groupie/pages/group_info.dart';
import 'package:groupie/service/database_service.dart';
import 'package:groupie/widgets/widgets.dart';

class ChatPage extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String userName;
  const ChatPage(
      {Key? key,
      required this.groupId,
      required this.groupName,
      required this.userName})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Stream<QuerySnapshot>? chats;
  String admin = '';

  @override
  void initState() {
    getChatAndAdmin();
    super.initState();
  }

  getChatAndAdmin() {
    DatabaseService().getChat(widget.groupId).then((val) {
      setState(() {
        chats = val;
      });
    });
    DatabaseService().getGroupAdmin(widget.groupId).then((value) {
      setState(() {
        admin = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                nextScreenNotReplace(
                    context,
                    GroupPage(
                      groupId: widget.groupId,
                      groupName: widget.groupName,
                      adminName: admin,
                    ));
              },
              icon: const Icon(Icons.info))
        ],
        centerTitle: true,
        elevation: 1.0,
        title: Text(
          widget.groupName,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Text(widget.groupName),
      ),
    );
  }
}
