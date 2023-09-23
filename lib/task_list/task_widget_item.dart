import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/MyTheme.dart';
import 'package:todo/Provider/app_config_provider.dart';

import 'edit_task_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class TaskWidgetItem extends StatefulWidget {
  @override
  State<TaskWidgetItem> createState() => _TaskWidgetItemState();
}

class _TaskWidgetItemState extends State<TaskWidgetItem> {
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AppConfigProvider>(context);
    return Padding(
      padding:  EdgeInsets.all(9.0),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio:0.25,
          // A motion is a widget used to control how the pane animates.
          motion: StretchMotion(),
          children:  [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              borderRadius: BorderRadius.circular(20),
              onPressed:(context) {
              },
              backgroundColor:MyTheme.redColor,
              foregroundColor:MyTheme.whiteColor,
              icon: Icons.delete,
              label: AppLocalizations.of(context)!.delete,
            ),
          ],
        ),

        child: InkWell(
          onTap:(){
           Navigator.of(context).pushNamed(EditTaskItem.routeName);
          },
          child: Container(
            padding: EdgeInsets.all(15),
            // color: MyTheme.whiteColor,
            decoration: BoxDecoration(color: provider.isDarkMode()?MyTheme.blackDark:MyTheme.whiteColor,borderRadius: BorderRadius.circular(20)),
            child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment:CrossAxisAlignment.start ,
              children: [
                Container(
                  // margin: EdgeInsets.all(12),
                  color:MyTheme.primaryColor,
                  width:5,
                  height: 80,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 59),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Play Football ',style: Theme.of(context).textTheme.titleSmall!.copyWith(color:MyTheme.primaryColor)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text('12/2/2010 ',style:Theme.of(context).textTheme.bodyLarge),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(onPressed: (){}, child:Icon(Icons.check,size:30),
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(MyTheme.primaryColor),
                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)))
                ),
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
