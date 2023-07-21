import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.adminName),
      ),
    );
  }
}
