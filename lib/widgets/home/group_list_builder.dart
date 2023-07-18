import 'package:flutter/material.dart';
import 'package:groupie/widgets/home/group_tile.dart';

import 'no_groups.dart';

class GroupListBuilder extends StatelessWidget {
  const GroupListBuilder({
    super.key,
    required this.groups,
  });

  final Stream? groups;
  String getId(String res) {
    return res.substring(0, res.indexOf('_'));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: groups,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data['groups'] != null) {
            if (snapshot.data['groups'].length != 0) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return GroupTile(
                    groupId: getId(snapshot.data['groups'][index]),
                    groupName: getName(snapshot.data['groups'][index]),
                    userName: snapshot.data['fullName'],
                  );
                },
                itemCount: snapshot.data['groups'].length,
              );
            } else {
              return const Center(child: NoGroups());
            }
          } else {
            return const Center(
              child: NoGroups(),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          );
        }
      },
    );
  }
}
