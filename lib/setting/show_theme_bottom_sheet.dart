import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/MyTheme.dart';
import 'package:todo/Provider/app_config_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class ShowThemeBottomSheet extends StatefulWidget {
  const ShowThemeBottomSheet({super.key});

  @override
  State<ShowThemeBottomSheet> createState() => _ShowThemeBottomSheetState();
}

class _ShowThemeBottomSheetState extends State<ShowThemeBottomSheet> {
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
              onTap: () {
                provider.changeTheming(ThemeMode.light);
              },
              child:provider.isDarkMode()?getUnSelectedTheme(AppLocalizations.of(context)!.light):
              getSelectedTheme(AppLocalizations.of(context)!.light),
            ),
            InkWell(
              onTap: (){
                provider.changeTheming(ThemeMode.dark);
              },
              child:provider.isDarkMode()?getSelectedTheme(AppLocalizations.of(context)!.dark):
                  getUnSelectedTheme(AppLocalizations.of(context)!.dark)
              ,
            )
          ],
        ),
      ),
    );
  }

  Widget getSelectedTheme(theme){
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(theme,style:Theme.of(context).textTheme.titleSmall!.copyWith(color:MyTheme.primaryColor,fontWeight:FontWeight.normal),),
          Icon(Icons.check,color:MyTheme.primaryColor,)
        ],
      ),
    );
  }
  Widget getUnSelectedTheme(theme){
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(theme,style:Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight:FontWeight.normal),),

        ],
      ),
    );
  }
}
