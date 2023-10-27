import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practico_postips/style/app_style.dart';

class NoteReaderScreen extends StatefulWidget{
        NoteReaderScreen(this.doc,{Key? key}) : super(key: key);
        QueryDocumentSnapshot doc;
        @override
        _NoteReaderScreenState createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen>{
        @override
        Widget build(BuildContext context){
                int color_id = widget.doc['color_id'];
                return Scaffold(
                        backgroundColor: AppStyle.cardsColor[color_id],
                        appBar: AppBar(
                                backgroundColor: AppStyle.cardsColor[color_id],
                                elevation: 0.0,
                        ),
                        body: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        Text(widget.doc["note_title"],style: AppStyle.mainTitle,),
                                        SizedBox(
                                            height: 4.0,
                                        ),
                                        Text(widget.doc["creation_date"],style: AppStyle.dateTitle, overflow: TextOverflow.ellipsis,),
                                        SizedBox(
                                            height: 28.0,
                                        ),
                                        Text(widget.doc["note_content"],style: AppStyle.mainContent),
                                    ],
                                ),
                            ),
                        ),
                );
        }
}
