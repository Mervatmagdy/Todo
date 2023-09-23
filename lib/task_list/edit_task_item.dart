import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/MyTheme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/Provider/app_config_provider.dart';
class EditTaskItem extends StatefulWidget {
  static const routeName='edit_task';

  @override
  State<EditTaskItem> createState() => _EditTaskItemState();
}

class _EditTaskItemState extends State<EditTaskItem> {
  DateTime selectedDate=DateTime.now();
  var formkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AppConfigProvider>(context);
    return Scaffold(
      body:SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
                top: 0.0,
                left: 0.0,
                right: 0.0,
                child: AppBar(
                  title:Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Text(AppLocalizations.of(context)!.to_do_title,style:Theme.of(context).textTheme.titleLarge),
                  ))),
            Container(
              height:MediaQuery.of(context).size.height-150,
              decoration: BoxDecoration(
                  color:provider.isDarkMode()?MyTheme.blackDark:MyTheme.whiteColor,
                  borderRadius: BorderRadius.circular(15)),

              padding: EdgeInsets.all(12),
              margin: EdgeInsets.only(right:25,left:25,bottom: 30,top: 110),
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    AppLocalizations.of(context)!.edit_task,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Form(
                      key:formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              validator:(value) {
                                if(value==null){
                                  return AppLocalizations.of(context)!.error_title;
                                }return null;
                              },
                              decoration: InputDecoration(enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:provider.isDarkMode()?MyTheme.primaryColor:
                              MyTheme.blackColor)),
                                  hintText: AppLocalizations.of(context)!.this_is_title,hintStyle:Theme.of(context).textTheme.titleSmall),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              validator:(value) {
                                if(value==null){
                                  return AppLocalizations.of(context)!.error_description;
                                }return null;
                              },
                              maxLines:4,
                              decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color:provider.isDarkMode()?MyTheme.primaryColor:
                                  MyTheme.blackColor)),
                                hintText: AppLocalizations.of(context)!.task_details,
                                hintStyle:Theme.of(context).textTheme.titleSmall
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppLocalizations.of(context)!.select_time,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                showCalendar();
                                setState(() {

                                });
                              },
                              child: Text(
                                "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                              ),
                            ),
                          ),
                        ],
                      )),
                  ElevatedButton(
                     style: ButtonStyle(
                       padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal:60,vertical:15)),
                     ),
                      onPressed: (){}, child:Text(AppLocalizations.of(context)!.sava_changes,style: Theme.of(context).textTheme.titleSmall!.copyWith(color:MyTheme.whiteColor),))
                ],
              ),
            ),
          ],
    ),
      ));
  }

  showCalendar() async {
    var chosenDate=await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if(chosenDate!=null){
      selectedDate=chosenDate;
    }
  }

  void addTask(){
    if(formkey.currentState?.validate()==true){
      setState(() {

      });
      return;
    }
  }
}
