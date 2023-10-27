import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practico_postips/todo/model/todo_model.dart';
import 'package:practico_postips/todo/services/todo_service.dart';

final serviceProvider = StateProvider<TodoService>((ref) {
    return TodoService();
});

final fetchStreamProvider = StreamProvider<List<TodoModel>>((ref) async* {
    final getData = FirebaseFirestore.instance
            .collection('todoApp')
            .snapshots()
            .map((event) => event.docs
                    .map((snapshot) => TodoModel.fromSnapshot(snapshot))
                    .toList());
    yield* getData;
});

final fetchDataProvider = FutureProvider<List<TodoModel>>((ref) async {
    final getData = await FirebaseFirestore.instance
            .collection('todoApp')
            .get()
            .then((querySnapshot) => querySnapshot.docs
                    .map((doc) => TodoModel.fromSnapshot(doc))
                    .toList());
    return getData;
});
