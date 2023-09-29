import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/MyTheme.dart';
import 'package:todo/Provider/app_config_provider.dart';
import 'package:todo/modal/firebase_utils.dart';
import 'package:todo/modal/task.dart';
import 'edit_task_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskWidgetItem extends StatefulWidget {
  Task tasks;
  TaskWidgetItem({required this.tasks});
  @override
  State<TaskWidgetItem> createState() => _TaskWidgetItemState();
}

class _TaskWidgetItemState extends State<TaskWidgetItem> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Padding(
      padding: EdgeInsets.all(9.0),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.25,
          // A motion is a widget used to control how the pane animates.
          motion: StretchMotion(),
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              borderRadius: BorderRadius.circular(20),
              onPressed: (tasks) {
                FirebaseUtils.deleteTaskFromFireStore(widget.tasks).timeout(
                  Duration(milliseconds:0),
                  onTimeout: () { print('task delete successfully');
                  provider.getAllTaskFormFirebase();
                  }
                );

              },
              backgroundColor: MyTheme.redColor,
              foregroundColor: MyTheme.whiteColor,
              icon: Icons.delete,
              label: AppLocalizations.of(context)!.delete,
            ),
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            Navigator.of(context).pushNamed(EditTaskItem.routeName);
          },
          child: Container(
            padding: EdgeInsets.all(15),
            // color: MyTheme.whiteColor,
            decoration: BoxDecoration(
                color: provider.isDarkMode()
                    ? MyTheme.blackDark
                    : MyTheme.whiteColor,
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment:CrossAxisAlignment.start ,
              children: [
                Container(
                  // margin: EdgeInsets.all(12),
                  color:provider.isDone(widget.tasks)?MyTheme.greenColor:MyTheme.primaryColor,
                  width: 4,
                  height: 80,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 59),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.tasks.title ?? "",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color:provider.isDone(widget.tasks)?MyTheme.greenColor:MyTheme.primaryColor)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(widget.tasks.description ?? "",
                            style: Theme.of(context).textTheme.bodyLarge),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed:provider.isDone(widget.tasks)?null:() {
                      FirebaseUtils.updateDoneTaskFormFireStore(widget.tasks).
                      timeout(Duration(milliseconds:0),onTimeout:(){
                        print('task is done successfully');
                        provider.getAllTaskFormFirebase();
                      });
                  },
                  child: provider.isDone(widget.tasks)?
                      Text('Done!',style:Theme.of(context).textTheme.titleSmall!.copyWith(color:MyTheme.greenColor,fontSize:22),):Icon(Icons.check, size: 30),
                  style: ButtonStyle(
                    elevation: MaterialStatePropertyAll(0),
                      backgroundColor:
                          MaterialStatePropertyAll(provider.isDone(widget.tasks)?Colors.transparent:MyTheme.primaryColor),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11)))),
                ),

                // FloatingActionButton(onPressed: (){},child:Icon(Icons.check),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
