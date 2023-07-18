import 'package:flutter/material.dart';

import 'no_groups.dart';

class GroupListBuilder extends StatelessWidget {
  const GroupListBuilder({
    super.key,
    required this.groups,
  });

  final Stream? groups;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: groups,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data['groups'] != null) {
            if (snapshot.data['groups'].length != 0) {
              return Text('Hellooooooooo');
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
