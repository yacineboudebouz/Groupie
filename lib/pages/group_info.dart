import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groupie/service/database_service.dart';

import '../widgets/group_info/group_members.dart';
import '../widgets/group_info/header.dart';

class GroupPage extends StatefulWidget {
  GroupPage(
      {required this.groupId,
      required this.groupName,
      required this.adminName,
      super.key});

  final String groupId;
  final String groupName;
  final String adminName;

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  Stream? members;
  @override
  void initState() {
    getMembers();
    super.initState();
  }

  getMembers() async {
    DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getGroupMembers(widget.groupId)
        .then((value) {
      setState(() {
        members = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        title: const Text('Group Info'),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            InfoHeader(
              adminName: widget.adminName,
              groupId: widget.groupId,
              groupName: widget.groupName,
            ),
            GroupMembers(members: members)
          ],
        ),
      ),
    );
  }
}
