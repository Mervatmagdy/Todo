import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/MyTheme.dart';
import 'package:todo/Provider/app_config_provider.dart';
import 'package:todo/task_list/task_widget_item.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AppConfigProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(top:100),
      child: Column(
        children: [
          CalendarTimeline(
            initialDate: DateTime.now(),
            firstDate: DateTime.now()..subtract(Duration(days: 365)),
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateSelected: (date) => print(date),
            leftMargin: 10,
            monthColor: MyTheme.blackColor,
            dayColor: MyTheme.blackColor,
            activeDayColor:provider.isDarkMode()?MyTheme.whiteColor:MyTheme.primaryColor,
            activeBackgroundDayColor:provider.isDarkMode()?MyTheme.blackDark: MyTheme.whiteColor,
            dotsColor: MyTheme.whiteColor,
            selectableDayPredicate: (date) => true,
            locale: 'en_ISO',
          ),
          Expanded(
              child: ListView.builder(
                  itemBuilder:(context, index) {
                    return TaskWidgetItem();
                  },
                  itemCount:10))
        ],
      ),
    );
  }
}
