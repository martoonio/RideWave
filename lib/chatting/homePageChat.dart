import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ridewave/chatting/chat.dart';
import 'package:ridewave/constants.dart';

class MapPageChatScreen extends StatefulWidget {
  const MapPageChatScreen({super.key});

  @override
  State<MapPageChatScreen> createState() => _MapPageScreenState();
}

class _MapPageScreenState extends State<MapPageChatScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(
          "Chat",
          style: GoogleFonts.poppins(
            color: whiteColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: whiteColor,
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc) => _buildUserListItem(doc))
                .toList(),
          );
        });
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    if (_auth.currentUser!.email != data['email']) {
      //can add validation for rider & waver
      return Column(
        children: [
          const SizedBox(height: 13),
          Container(
              width: 351,
              decoration: ShapeDecoration(
                color: Color(0x9E82A5B3),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0xFF054C67)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 0,
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 25,
                ),
                title: Text(
                  data['name'],
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  data['phone'],
                  style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(
                        receivedUserEmail: data['name'],
                        receivedUserId: data['id'],
                      ),
                    ),
                  );
                },
              )),
        ],
      );
    } else {
      return Container();
    }
  }
}
