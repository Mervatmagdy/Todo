import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/MyTheme.dart';
import 'package:todo/Provider/Auth_Provider.dart';
import 'package:todo/Provider/app_config_provider.dart';
import 'package:todo/task_list/task_widget_item.dart';

class TaskList extends StatefulWidget {
  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  // late Task task;
  @override
  Widget build(BuildContext context) {
    var authProvider=Provider.of<AuthProvider>(context,listen:false);
    var provider = Provider.of<AppConfigProvider>(context);
    if (provider.taskList.isEmpty) {
      provider.getAllTaskFormFirebase(AuthProvider.pref.getString('id')!);
    }
    return Padding(
      padding: EdgeInsets.only(top: 100),
      child: Column(
        children: [
          CalendarTimeline(
            initialDate:provider.selectDate,
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateSelected: (date) =>provider.getChangeDate(date,authProvider.myUser!.id!),
            leftMargin: 10,
            monthColor: MyTheme.blackColor,
            dayColor: MyTheme.blackColor,
            activeDayColor: provider.isDarkMode()
                ? MyTheme.whiteColor
                : MyTheme.primaryColor,
            activeBackgroundDayColor:
                provider.isDarkMode() ? MyTheme.blackDark : MyTheme.whiteColor,
            dotsColor: provider.isDarkMode()
                ? MyTheme.whiteColor
                : MyTheme.primaryColor,
            selectableDayPredicate: (date) => true,
            locale: 'en_ISO',
          ),
          Expanded(
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    return TaskWidgetItem(
                      tasks: provider.taskList[index],
                    );
                  },
                  itemCount: provider.taskList.length))
        ],
      ),
    );
  }
}
