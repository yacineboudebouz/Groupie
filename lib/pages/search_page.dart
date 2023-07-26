import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:groupie/service/database_service.dart';
import 'package:groupie/widgets/widgets.dart';

import '../helper/helper_function.dart';
import 'chat_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  QuerySnapshot? searchSnapshot;
  bool hasUserSearch = false;
  String email = '';
  String userName = '';
  bool isJoined = false;

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettingUserData();
  }

  gettingUserData() async {
    await HelperFunctions.getUserEmail().then((value) {
      setState(() {
        email = value!;
      });
    });
    await HelperFunctions.getUserName().then((value) {
      setState(() {
        userName = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Search',
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: searchController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search groups ... ',
                    hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                )),
                GestureDetector(
                  onTap: () {
                    initiateSearchMethod();
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(40)),
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                )
              : hasUserSearch
                  ? ListView.builder(
                      itemBuilder: (context, index) {
                        return groupTile(
                            userName,
                            searchSnapshot!.docs[index]['groupId'],
                            searchSnapshot!.docs[index]['groupName'],
                            searchSnapshot!.docs[index]['admin']);
                      },
                      shrinkWrap: true,
                      itemCount: searchSnapshot!.docs.length,
                    )
                  : Container(),
        ],
      ),
    );
  }

  joinedOrNot(String userName, String groupId, String groupName) async {
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .isUserJoined(groupName, groupId, userName)
        .then((value) {
      setState(() {
        isJoined = value;
      });
    });
  }

  initiateSearchMethod() async {
    if (searchController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
    }
    await DatabaseService()
        .searchGroupByName(searchController.text)
        .then((snapshot) {
      setState(() {
        searchSnapshot = snapshot;
        isLoading = false;
        hasUserSearch = true;
      });
    });
  }

  Widget groupTile(
    String userName,
    String groupId,
    String groupName,
    String admin,
  ) {
    joinedOrNot(userName, groupId, groupName);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: Theme.of(context).primaryColor,
        child: Text(
          groupName.substring(0, 1).toUpperCase(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      subtitle: Text('Admin : ${getName(admin)}'),
      title: Text(
        groupName,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: InkWell(
          onTap: () async {
            await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                .toggleGroupJoin(groupId, userName, groupName);
            if (!isJoined) {
              setState(() {
                isJoined = !isJoined;
              });
              showSnackBar(
                  context, Colors.green, "Successfully joined he group");
              Future.delayed(const Duration(seconds: 2), () {
                nextScreen(
                    context,
                    ChatPage(
                        groupId: groupId,
                        groupName: groupName,
                        userName: userName));
              });
            } else {
              setState(() {
                isJoined = !isJoined;
                showSnackBar(context, Colors.red, "Left the group $groupName");
              });
            }
          },
          child: isJoined
              ? Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: const Text(
                    "Joined",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColor,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: const Text("Join Now",
                      style: TextStyle(color: Colors.white)),
                )),
    );
  }
}
