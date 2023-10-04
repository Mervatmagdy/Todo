import 'package:flutter/material.dart';
import 'package:todo/auth/sign_up_screen.dart';
import 'package:todo/components/custom_text_field.dart';
import 'package:email_validator/email_validator.dart';

import '../Home/Home_Screen.dart';
import '../MyTheme.dart';
class SignInScreen extends StatelessWidget {
  static const routeName = 'sign_in_screen';
  var emailController=TextEditingController();
  var passController=TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/SIGN IN – 1.png',
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          SingleChildScrollView(
            child: Form(key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                  CustomTextField(
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter email address';
                        } else if (!EmailValidator.validate(text)) {
                          return 'email invalid ';
                        }
                        return null;
                      },
                      title: 'Email Address',
                      textInputType: TextInputType.emailAddress,
                      textEditingController: emailController),
                  CustomTextField(
                      hiddenPass:true,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please enter password';
                        } else if (text.length < 8) {
                          return 'password must be at least 8 numbers';
                        } else {
                          return null;
                        }
                      },
                      title: 'Password',
                      textInputType: TextInputType.number,
                      textEditingController: passController),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical:50),
                    child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          )),
                            padding: MaterialStatePropertyAll(
                                EdgeInsets.symmetric(vertical: 12))),
                        onPressed: () {
                          if(formKey.currentState?.validate()==true){
                            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                          }
                        },
                        child: Text(
                          "SIGN IN",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: MyTheme.whiteColor),
                        )),
                  ),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account ?',style:Theme.of(context).textTheme.titleSmall,),
                    TextButton(
                      style: ButtonStyle(
                        overlayColor:MaterialStatePropertyAll(Colors.transparent)
                      ),
                        onPressed:(){
                      Navigator.pushNamed(context,SignUpScreen.routeName);
                    }, child:Text("Sign up",style:Theme.of(context).textTheme.titleSmall!.copyWith(color:MyTheme.primaryColor,))
                    )],
                )
              ],
            ),
                )),
          )
        ],
      ),
    );
  }
}
