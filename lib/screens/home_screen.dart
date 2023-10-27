import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practico_postips/screens/note_editor.dart';
import 'package:practico_postips/screens/note_reader.dart';
import 'package:practico_postips/style/app_style.dart';
import 'package:practico_postips/todo/todo_screen.dart';
import 'package:practico_postips/widgets/note_card.dart';

class HomeScreen extends StatefulWidget {
    const HomeScreen({Key? key}) : super(key: key);

    @override
    State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    int _currentIndex = 0;

    void _deleteNote(String noteId) async {
        await FirebaseFirestore.instance
                .collection("notes")
                .doc(noteId)
                .delete();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: AppStyle.mainColor,
            appBar: AppBar(
                elevation: 0.0,
                title: const Text("Mis Postips"),
                centerTitle: true,
                backgroundColor: AppStyle.mainColor,
            ),
            body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text(
                            "Mis Postips Recientes",
                            style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                            ),
                        ),
                        const SizedBox(
                            height: 20.0,
                        ),
                        Expanded(
                            child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance.collection("notes").snapshots(),
                                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                        return Center(
                                            child: CircularProgressIndicator(),
                                        );
                                    }
                                    if (snapshot.hasData) {
                                        return GridView(
                                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                            ),
                                            children: snapshot.data!.docs.map((note) => noteCard(
                                                context,
                                                () {

                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => NoteReaderScreen(note),
                                                        ),
                                                    );
                                                },
                                                note,
                                                _deleteNote,
                                            )).toList(),
                                        );
                                    }
                                    return Text(
                                        "No hay Postips",
                                        style: GoogleFonts.nunito(
                                            color: Colors.white,
                                        ),
                                    );
                                },
                            ),
                        ),
                    ],
                ),
            ),
            floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NoteEditorScreen()),
                    );
                },
                label: Text("Agregar Postip"),
                icon: Icon(Icons.add),
            ),
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: (index) {
                    setState(() {
                        _currentIndex = index;
                        if (_currentIndex == 0) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => HomeScreen()),
                            );
                        } else if (_currentIndex == 1) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => TodoClass()),
                            );
                        }
                    });
                },
                items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.event_note_outlined),
                        activeIcon: Icon(Icons.event_note),
                        label: "Mis Postips",
                        backgroundColor: AppStyle.accentColor,
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.add_alert_outlined),
                        activeIcon: Icon(Icons.add_alert),
                        label: 'Recordatorios',
                        backgroundColor: AppStyle.accentColor,
                    ),
                ],
            ),
        );
    }
}
