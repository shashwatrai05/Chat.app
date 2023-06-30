import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Flutter Chat'),
        actions: <Widget>[
          DropdownButton(
            items: [
              DropdownMenuItem(
                child:Container(
                  child: Row(
                    children: const <Widget>[
                      Icon(Icons.logout),
                      SizedBox(width: 8,),
                      Text('Logout')
                    ],
                  ),
                ),
                value: 'logout',
                )
            ], 
            onChanged: (itemIdentifier){
              if(itemIdentifier== 'logout'){
                FirebaseAuth.instance.signOut();
              }
            },
            icon: Icon(Icons.more_vert,
            color: Theme.of(context).primaryIconTheme.color,
            ),
          
            )
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chats/CBotOHFI90tP1wiKiKkL/messages')
              .snapshots(),
          builder: (ctx, streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final mydocuments = streamSnapshot.data?.docs;
            return ListView.builder(
                itemCount: mydocuments!.length,
                itemBuilder: (ctx, index) {
                  final reverseIndex = mydocuments.length - 1 - index;
                  return Container(
                    padding: const EdgeInsets.all(8),
                    child: Text(mydocuments[reverseIndex]['text']),
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            FirebaseFirestore.instance
                .collection('chats/CBotOHFI90tP1wiKiKkL/messages')
                .add({'text': 'This was added by clicking the button'});
          }),
    );
  }
}
