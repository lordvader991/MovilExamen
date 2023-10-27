import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practico_postips/todo/model/todo_model.dart';

class TodoService{
    final TodoCollection= FirebaseFirestore.instance.collection('todoApp');


    void addNewTask(TodoModel model){
        TodoCollection.add(model.toMap());
    }



    //update

    void updateTask(String? docID, bool? valueUpdate){
        TodoCollection.doc(docID).update({
            'isDone':valueUpdate,
    });
    }

    //delete

    void deleteTask(String? docID){
        TodoCollection.doc(docID).delete();
    }
}
