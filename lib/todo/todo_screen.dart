import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:practico_postips/style/app_style.dart';
import 'package:practico_postips/todo/common/show_model.dart';
import 'package:practico_postips/todo/provider/service_provider.dart';
import 'package:practico_postips/widgets/card_todo_widget.dart';

class TodoClass extends ConsumerWidget {
    const TodoClass({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context, WidgetRef ref) {
        return Scaffold(
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
                    child: Column(
                        children: [
                            const Gap(20),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                    Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: const [
                                            Text(
                                                'Recordatorios',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                ),
                                            ),
                                            Text(
                                                'Recientes',
                                                style: TextStyle(color: Colors.white),
                                            ),
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
                                        onPressed: () => showModalBottomSheet(
                                            isScrollControlled: true,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(16.0),
                                            ),
                                            context: context,
                                            builder: (context) => AddNewTaskModel(),
                                        ),
                                        child: const Text('+ Nuevo Recordatorio'),
                                    ),
                                ],
                            ),
                            const Gap(20),
                            Consumer(
                                builder: (context, ref, _) {
                                    final todoData = ref.watch(fetchDataProvider);
                                    return ListView.builder(
                                        itemCount: todoData.value!.length ?? 0,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) => CardTodoListWidget(
                                            getIndex: index,
                                        ),
                                    );
                                },
                            ),
                        ],
                    ),
                ),
            ),
        );
    }
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: Consumer(
        builder: (context, ref, _) {
          final todoData = ref.watch(fetchDataProvider);
          return todoData.when(
            data: (todoData) {
              return ListView.builder(
                itemCount: todoData.length,
                itemBuilder: (context, index) {
                  return CardTodoListWidget(getIndex: index);
                },
              );
            },
            error: (error, stackTrace) => Center(
              child: Text(
                stackTrace.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
            loading: () => Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
