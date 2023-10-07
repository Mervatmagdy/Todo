import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/modal/my_user.dart';
import 'package:todo/modal/task.dart';
import 'package:flutter/services.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTaskCollection(String uId) {
    return getUserCollection().doc(uId)
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: (snapshot, options) =>
                Task.formFireStore(snapshot.data()!),
            toFirestore: (task, options) => task.toFireStore());
  }

  static Future<void> addTaskToFireStore(Task task,String uId) async {
    var collectionTask = getTaskCollection(uId);
    DocumentReference<Task> docRef = collectionTask.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }

  static Future<void> deleteTaskFromFireStore(Task task,String uId) {
    return getTaskCollection(uId).doc(task.id).delete();
  }

  static Future<void> updateDoneTaskFormFireStore(Task task,String uId) {
    return getTaskCollection(uId).doc(task.id).update({"isDone": true});
  }

  static Future<void> updateTaskFormFireStore(Task task,String uId) {
    return getTaskCollection(uId).doc(task.id).update({
      "title": task.title,
      "description": task.description,
      "dateTime": task.dateTime?.millisecondsSinceEpoch
    });
  }

  static CollectionReference<MyUser> getUserCollection() {
   return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, options) =>
              MyUser.fromFireStore(snapshot.data()),
          toFirestore: (myUser, options) => myUser.toFireStore(),
        );
  }
  static Future<void> addUserToFireStore(MyUser myUser){
   return getUserCollection().doc(myUser.id).set(myUser);
  }
  static Future<MyUser?> readUserFromFireStore(String uId)async{
   var querySnapShot= await getUserCollection().doc(uId).get();
   return querySnapShot.data();
  }
}
