import 'package:flutter/material.dart';

class InfoHeader extends StatelessWidget {
  const InfoHeader({
    super.key,
    required this.groupId,
    required this.groupName,
    required this.adminName,
  });

  final String groupId;
  final String groupName;
  final String adminName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Theme.of(context).primaryColor.withOpacity(0.3)),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              groupName.substring(0, 1).toUpperCase(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Group : $groupName ',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('Admin : $adminName ')
            ],
          )
        ],
      ),
    );
  }
}
