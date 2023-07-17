import 'package:flutter/material.dart';

class NoGroups extends StatelessWidget {
  const NoGroups({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.add_circle,
            color: Colors.grey[700],
            size: 75,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text('you have not joined any group')
        ],
      ),
    );
  }
}
