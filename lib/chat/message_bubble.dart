import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble(
    this.message, 
    this.userName,
    this.isMe,
    {this.key}
    );
    final Key? key;
    final String userName;
  final String message;
  final bool isMe;
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe? MainAxisAlignment.end: MainAxisAlignment.start,
      children: <Widget>[
        Container(
        decoration: BoxDecoration(
          color:isMe? Colors.grey[300]: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: !isMe? const Radius.circular(0): const Radius.circular(12),
            bottomRight: isMe? const Radius.circular(0): const Radius.circular(12),
          ),
        ),
        width: 140,
        padding: const EdgeInsets.symmetric(
          vertical: 10, 
          horizontal: 16,
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 8,
        ),
        child: Column(
          crossAxisAlignment: isMe? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: <Widget>[
            
            
            
              
               Text(
              userName,
                style: TextStyle(fontWeight: FontWeight.bold,
                color:isMe? Colors.black: Theme.of(context).accentTextTheme.titleMedium!.color,),
                ),
            
            
          
            
            Text(
              message,
            style: TextStyle(
              color:isMe? Colors.black: Theme.of(context).accentTextTheme.titleMedium!.color,
              ),
              textAlign: isMe? TextAlign.end:TextAlign.start,
            ),
          ],
        ),
      ),
      ],
      
    );
  }
}