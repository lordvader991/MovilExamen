import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:practico_postips/todo/provider/service_provider.dart';

class CardTodoListWidget extends ConsumerWidget {
    const CardTodoListWidget({
        Key? key,
        required this.getIndex,
    }) : super(key: key);

    final int getIndex;

    @override
    Widget build(BuildContext context, WidgetRef ref) {
        final todoData = ref.watch(fetchDataProvider);
        return todoData.when(
            data: (todoData) {
                Color categoryColor = Colors.white;
                final getCategory = todoData[getIndex].category;
                switch (getCategory) {
                    case 'Learning':
                        categoryColor = Colors.green;
                        break;

                    case 'Working':
                        categoryColor = Colors.blue.shade700;
                        break;

                    case 'General':
                        categoryColor = Colors.amber.shade700;
                        break;
                }
                return Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: double.infinity,
                    height: 120,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                        children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: categoryColor,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        bottomLeft: Radius.circular(12),
                                    ),
                                ),
                                width: 20,
                            ),
                            Expanded(
                                child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20,
                                    ),
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            ListTile(
                                                contentPadding: EdgeInsets.zero,
                                                leading: IconButton(icon: Icon(
                                                CupertinoIcons.delete),
                                                onPressed:()=> ref.read(serviceProvider)
                                                .deleteTask(todoData[getIndex].docID),
                                                ),
                                                title: Text(todoData[getIndex].titleTask, maxLines: 1,
                                                style: TextStyle(
                                                    decoration: todoData[getIndex].isDone ? TextDecoration.lineThrough : null,
                                                ),),
                                                subtitle: Text(todoData[getIndex].description, maxLines: 1,
                                                style: TextStyle(
                                                    decoration: todoData[getIndex].isDone ? TextDecoration.lineThrough : null,
                                                ),
                                                ),
                                                trailing: Transform.scale(
                                                    scale: 1.5,
                                                    child: Checkbox(
                                                        activeColor: Colors.green,
                                                        value: todoData[getIndex].isDone,
                                                        shape: CircleBorder(),
                                                        onChanged: (value) => ref
                                                                .read(serviceProvider)
                                                                .updateTask(todoData[getIndex].docID, value),
                                                    ),
                                                ),
                                            ),
                                            Transform.translate(
                                                offset: Offset(0, -12),
                                                child: Container(
                                                    child: Column(
                                                        children: [
                                                            Divider(
                                                                thickness: 1.5,
                                                                color: Colors.grey.shade200,
                                                            ),
                                                            Row(
                                                                children: [
                                                                    Text('today'),
                                                                    Gap(12),
                                                                    Text(todoData[getIndex].timeTask),
                                                                ],
                                                            ),
                                                        ],
                                                    ),
                                                ),
                                            )
                                        ],
                                    ),
                                ),
                            )
                        ],
                    ),
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
