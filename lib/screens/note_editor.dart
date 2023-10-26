import 'dart:math';
import 'package:flutter/material.dart';
import 'package:practico_postips/style/app_style.dart';

class NoteEditorScreen extends StatefulWidget{
    const NoteEditorScreen({Key? key}) : super(key: key);

    @override
    State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}
class _NoteEditorScreenState extends State<NoteEditorScreen>{
    int color_id = Random().nextInt(AppStyle.cardsColor.length);
    String date = DateTime.now().toString();
    TextEditingController _titleController = TextEditingController();
    TextEditingController _mainController = TextEditingController();

    @override
    Widget build(BuildContext context){

        return Scaffold(
            backgroundColor: AppStyle.cardsColor[color_id],
            appBar: AppBar(
                backgroundColor: AppStyle.cardsColor[color_id],
                elevation:  0.0,
                iconTheme: IconThemeData(color: Colors.black),
                title: Text("Agregar nuevo Postip", style:
                TextStyle(
                    color: Colors.black),
                ),
            ),
            body: Padding(
                padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                        controller: _titleController,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Titulo',
                        ),
                        style: AppStyle.mainTitle,
                    ),
                    SizedBox(
                        height: 8.0,
                    ),
                    Text(date, style: AppStyle.dateTitle,),
                    SizedBox(
                        height: 28.0,
                    ),
                    TextField(
                        controller: _mainController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Contenido',
                        ),
                        style: AppStyle.mainContent,
                    ),
                  ],
              ),
            ),

        );
    }
}
