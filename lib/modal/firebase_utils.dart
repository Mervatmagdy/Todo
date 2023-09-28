import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/modal/task.dart';

class FirebaseUtils{
  static CollectionReference<Task> getTaskCollection(){
    return FirebaseFirestore.instance.collection('users').
    withConverter<Task>(
      fromFirestore:(snapshot, options) =>Task.formFireStore(snapshot.data()!),
      toFirestore:(task, options) =>task.toFireStore());
  }
  static Future<void> addTaskToFireStore(Task task) async {
   var collectionTask=getTaskCollection();
   DocumentReference<Task> docRef= collectionTask.doc();
  task.id=docRef.id;
   return docRef.set(task);
  }
  static Future<void> deleteTaskFromFireStore(Task task){
    return getTaskCollection().doc(task.id).delete();

  }
static Future<void> updateDoneTaskFormFireStore(Task task){
   return getTaskCollection().doc(task.id).update({"isDone":true});
}
}