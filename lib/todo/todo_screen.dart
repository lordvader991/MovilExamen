import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:practico_postips/style/app_style.dart';
import 'package:practico_postips/todo/common/show_model.dart';
import 'package:practico_postips/widgets/card_todo_widget.dart';

class TodoClass extends StatefulWidget {
  const TodoClass({Key? key}) : super(key: key);

  @override
  _TodoClassState createState() => _TodoClassState();
}

class _TodoClassState extends State<TodoClass> {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Scaffold(
          backgroundColor: AppStyle.mainColor,
              appBar: AppBar(
                  elevation: 0.0,
                  title: const Text("Mis recordatorios"),
                  centerTitle: true,
                  backgroundColor: AppStyle.mainColor,
              ),
              body: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(children: [
                          const Gap(20),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const[
                                          Text('cosa 1', style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              ),),
                                          Text('Cosa 2', style: TextStyle(color: Colors.white),),
                                      ],
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Color.fromARGB(255, 103, 252, 120),
                                          foregroundColor: Colors.black,
                                          elevation: 0.0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8.0),
                                          ),
                                      ),
                                      onPressed: () =>showModalBottomSheet(
                                      isScrollControlled: true,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16.0),
                                      ),
                                      context: context,
                                      builder: (context) =>AddNewTaskModel()
                                      ),
                                      child: Text('+ Nuevo Recordatorio')
                                  ),
                              ],
                          ),
                          Gap(20),
                        ListView.builder(
                        itemCount: 1,
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                        CardTodoListWidget(),
                        )
                      ]),
                  ),
              ),
      ),
    );
  }
}



