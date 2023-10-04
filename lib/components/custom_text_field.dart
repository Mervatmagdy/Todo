import 'package:flutter/material.dart';
import 'package:todo/MyTheme.dart';

class CustomTextField extends StatelessWidget {
  String title;
  TextInputType textInputType;
  TextEditingController textEditingController;
  String? Function(String?) validator;
  bool hiddenPass;
  CustomTextField({required this.title,this.textInputType=TextInputType.text,required this.textEditingController,required this.validator,this.hiddenPass=false});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        obscureText:hiddenPass,
        validator:validator,
        controller:textEditingController,
       keyboardType:textInputType ,
        decoration: InputDecoration(
          // suffixIcon:Icon(Icons.remove_red_eye_outlined) ,
         focusedErrorBorder:OutlineInputBorder(
             borderSide: BorderSide(color:MyTheme.redColor,width:2)
             ,borderRadius: BorderRadius.circular(20)
         ) ,
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color:MyTheme.redColor,width:2)
              ,borderRadius: BorderRadius.circular(20)
          ),
          label:Text(title,),
          enabledBorder:OutlineInputBorder(
            borderSide: BorderSide(color:Theme.of(context).primaryColor,width:2)
                ,borderRadius: BorderRadius.circular(20)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color:Theme.of(context).primaryColor,width: 2)
              ,borderRadius: BorderRadius.circular(20)
          ),
        ),
      ),
    );
  }
}
