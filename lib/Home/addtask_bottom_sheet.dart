import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todo/MyTheme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/Provider/Auth_Provider.dart';
import 'package:todo/Provider/app_config_provider.dart';
import 'package:todo/modal/firebase_utils.dart';
import 'package:todo/modal/task.dart';
import 'package:toast/toast.dart';

class AddTaskBottomSheet extends StatefulWidget {

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {

  late AppConfigProvider provider;
  String title = '';
  String description = '';
  DateTime selectedDate = DateTime.now();
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    provider = Provider.of<AppConfigProvider>(context);
    return SingleChildScrollView(
      child: Container(
        color: provider.isDarkMode() ? MyTheme.blackDark : MyTheme.whiteColor,
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context)!.add_new_task,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Form(
                key: formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (text) {
                          title = text;
                        },
                        validator: (value) {
                          if (value == '') {
                            return AppLocalizations.of(context)!.error_title;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: provider.isDarkMode()
                                        ? MyTheme.geryColor
                                        : MyTheme.blackColor)),
                            hintText:
                                AppLocalizations.of(context)!.enter_your_task,
                            hintStyle: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: MyTheme.geryColor)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (text) {
                          description = text;
                        },
                        validator: (value) {
                          if (value == "") {
                            return AppLocalizations.of(context)!
                                .error_description;
                          }
                          return null;
                        },
                        maxLines: 4,
                        minLines: 2,
                        // maxLengthEnforcement:MaxLengthEnforcement.none,
                        // textInputAction: TextInputAction.newline,
                        // maxLength:10,
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: provider.isDarkMode()
                                        ? MyTheme.geryColor
                                        : MyTheme.blackColor)),
                            hintText:
                                AppLocalizations.of(context)!.task_details,
                            hintStyle: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: MyTheme.geryColor)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        AppLocalizations.of(context)!.select_time,
                        style: provider.isDarkMode()
                            ? Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: MyTheme.geryColor)
                            : Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          showCalendar();
                          setState(() {});
                        },
                        child: Text(
                            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleSmall),
                      ),
                    ),
                  ],
                )),
            FloatingActionButton(
              shape: Theme.of(context).floatingActionButtonTheme.shape,
              onPressed: () {
                addTask();
                setState(() {});
              },
              child: Icon(
                Icons.check,
                color: MyTheme.whiteColor,
                size: 30,
              ),
            )
          ],
        ),
      ),
    );
  }

  showCalendar() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now().subtract(Duration(days: 365)),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chosenDate != null) {
      selectedDate = chosenDate;
    }
  }

  void addTask() {
    var authProvider=Provider.of<AuthProvider>(context,listen:false);
    if (formkey.currentState?.validate() == true) {
      Task task =
          Task(title: title, dateTime: selectedDate, description: description);
      FirebaseUtils.addTaskToFireStore(task,authProvider.myUser!.id!).then((value){
        Toast.show(AppLocalizations.of(context)!.task_added_success, duration: Toast.lengthShort, gravity:  Toast.bottom);
        provider.getAllTaskFormFirebase(authProvider.myUser!.id!);
        Navigator.pop(context);
      }).timeout(Duration(milliseconds:500),onTimeout:() {
        Toast.show(AppLocalizations.of(context)!.task_added_success, duration: Toast.lengthShort, gravity:  Toast.bottom);
        provider.getAllTaskFormFirebase(authProvider.myUser!.id!);
        Navigator.pop(context);
      },);

      ;

    }
  }
}
