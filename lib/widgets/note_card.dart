import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practico_postips/style/app_style.dart';

Widget noteCard(BuildContext context, Function()? onTap, QueryDocumentSnapshot doc, Function(String) onDelete) {
    return InkWell(
        onTap: onTap,
        onLongPress: () {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                    title: Text("Eliminar nota"),
                    content: Text("¿Está seguro de que desea eliminar esta nota?"),
                    actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("Cancelar"),
                        ),
                        TextButton(
                            onPressed: () async {
                                await FirebaseFirestore.instance
                                        .collection("notes")
                                        .doc(doc.id)
                                        .delete();
                                onDelete(doc.id);
                                Navigator.pop(context);
                            },
                            child: Text("Eliminar"),
                        ),
                    ],
                ),
            );
        },
        child: Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: AppStyle.cardsColor[doc["color_id"]],
                borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text(
                        doc["note_title"],
                        style: AppStyle.mainTitle,
                    ),
                    SizedBox(
                        height: 4.0,
                    ),
                    Text(
                        doc["creation_date"],
                        style: AppStyle.dateTitle,
                        overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                        height: 8.0,
                    ),
                    Text(
                        doc["note_content"],
                        style: AppStyle.mainContent,
                    ),
                ],
            ),
        ),
    );
}
