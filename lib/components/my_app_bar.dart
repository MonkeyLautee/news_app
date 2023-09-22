import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  final String title;
  const MyAppBar({this.title='News app',Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context)=>AppBar(
    title: Text(title,style:const TextStyle(fontFamily:'Serif',fontWeight:FontWeight.bold)),
    actions: const [
      Row(
        children: [
          Icon(Icons.person,color:Colors.black),
          SizedBox(width:7),
          Text('My account',style:TextStyle(fontWeight:FontWeight.bold)),
          SizedBox(width:7),
        ],
      ),
    ],
  );
}