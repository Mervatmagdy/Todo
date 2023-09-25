import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/MyTheme.dart';
import 'package:todo/Provider/app_config_provider.dart';
import 'package:todo/setting/show_language_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/setting/show_theme_bottom_sheet.dart';

class Setting extends StatefulWidget {
  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: AppBar(
                title: Padding(
              padding: const EdgeInsets.only(bottom: 30, left: 20),
              child: Text(
                AppLocalizations.of(context)!.setting_title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ))),
        Padding(
          padding: EdgeInsets.only(top: 190, right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 20),
                child: Text(
                  AppLocalizations.of(context)!.language,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              InkWell(
                overlayColor: MaterialStatePropertyAll(Colors.transparent),
                onTap: () {
                  showChangeLanguageBottomSheet();
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: provider.isDarkMode()
                          ? MyTheme.blackDark
                          : MyTheme.whiteColor,
                      border:
                          Border.all(color: MyTheme.primaryColor, width: 2)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          provider.appLanguage == 'en'
                              ? AppLocalizations.of(context)!.english
                              : AppLocalizations.of(context)!.arabic,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  fontWeight: FontWeight.normal,
                                  color: MyTheme.primaryColor)),
                      Icon(
                        Icons.arrow_drop_down,
                        color: MyTheme.primaryColor,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20, top: 20),
                child: Text(
                  AppLocalizations.of(context)!.mode,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              InkWell(
                overlayColor: MaterialStatePropertyAll(Colors.transparent),
                onTap: () {
                  showChangeThemeBottomSheet();
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: provider.isDarkMode()
                          ? MyTheme.blackDark
                          : MyTheme.whiteColor,
                      border:
                          Border.all(color: MyTheme.primaryColor, width: 2)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          provider.isDarkMode()
                              ? AppLocalizations.of(context)!.dark
                              : AppLocalizations.of(context)!.light,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(
                                  fontWeight: FontWeight.normal,
                                  color: MyTheme.primaryColor)),
                      Icon(
                        Icons.arrow_drop_down,
                        color: MyTheme.primaryColor,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  void showChangeLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ShowLanguageBottomSheet(),
    );
  }

  void showChangeThemeBottomSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => ShowThemeBottomSheet());
  }
}
