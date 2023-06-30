import 'package:chat_app/chat/messages.dart';
import 'package:chat_app/chat/new_message.dart';
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
      body: Container(
        child: Column(
          children: <Widget>[
             Expanded(
              child: Messages()
              ),
              NewMessage()
          ],
        ),
      ),
     
    );
  }
}
