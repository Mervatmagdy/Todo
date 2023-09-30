import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/MyTheme.dart';
import 'package:todo/Provider/app_config_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ShowLanguageBottomSheet extends StatefulWidget {
  @override
  State<ShowLanguageBottomSheet> createState() => _ShowLanguageBottomSheetState();
}

class _ShowLanguageBottomSheetState extends State<ShowLanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<AppConfigProvider>(context);
    return Container(
      color:provider.isDarkMode()?MyTheme.blackDark:MyTheme.whiteColor,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
           InkWell(
              onTap: (){
              provider.changeLanguage('en');
              },
             child: provider.appLanguage=='en'?getSelectedLanguage(AppLocalizations.of(context)!.english):
             getUnSelectedLanguage(AppLocalizations.of(context)!.english),
           ),
            InkWell(
               onTap: () {
                 provider.changeLanguage('ar');
               },
              child:provider.appLanguage=='ar'?getSelectedLanguage(AppLocalizations.of(context)!.arabic):
              getUnSelectedLanguage(AppLocalizations.of(context)!.arabic),
            )
          ],
        ),
      ),
    );
  }

Widget getSelectedLanguage(language){
    return  Padding(
      padding: const EdgeInsets.all(12),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(language,style: Theme.of(context).textTheme.titleSmall!.copyWith(color:MyTheme.primaryColor,fontWeight:FontWeight.normal),),
          Icon(Icons.check,color:MyTheme.primaryColor,)
        ],
      ),
    );
}
Widget getUnSelectedLanguage(language){
    return  Padding(
      padding: const EdgeInsets.all(12),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(language,style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight:FontWeight.normal),),
        ],
      ),
    );
}
}
