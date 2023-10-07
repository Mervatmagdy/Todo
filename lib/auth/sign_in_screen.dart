import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Dialogs/dialog_utilts.dart';
import 'package:todo/auth/sign_up_screen.dart';
import 'package:todo/components/custom_text_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:todo/modal/firebase_utils.dart';

import '../Home/Home_Screen.dart';
import '../MyTheme.dart';
import '../Provider/Auth_Provider.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = 'sign_in_screen';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController =
      TextEditingController(text: 'mervat@gmail.com');

  TextEditingController passController =
      TextEditingController(text: '12345678');

  var formKey = GlobalKey<FormState>();

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
            child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          hiddenPass: true,
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 50),
                        child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                                padding: MaterialStatePropertyAll(
                                    EdgeInsets.symmetric(vertical: 12))),
                            onPressed: () {
                              login();
                              setState(() {});
                            },
                            child: Text(
                              "SIGN IN",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: MyTheme.whiteColor),
                            )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account ?',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          TextButton(
                              style: ButtonStyle(
                                  overlayColor: MaterialStatePropertyAll(
                                      Colors.transparent)),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, SignUpScreen.routeName);
                              },
                              child: Text("Sign up",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                        color: MyTheme.primaryColor,
                                      )))
                        ],
                      )
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }

  Future<void> login() async {
    if (formKey.currentState?.validate() == true) {
      dialogUtils.showLoading(context, 'Loading...');
      try {
        var credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: emailController.text, password: passController.text
        );
         var user=await FirebaseUtils.readUserFromFireStore(credential.user?.uid??"");
         if(user==null){
           ///if user data assign to auth not cloud
           return;
         }
        var authProvider=Provider.of<AuthProvider>(context,listen:false);
        authProvider.updateUser(user);
        dialogUtils.hideLoading(context);
        dialogUtils.showMessage(
            context,
            'Success',
            'Login Successfully',
            posActionName: 'ok',
            posAction: () =>
                Navigator.pushReplacementNamed(context, HomeScreen.routeName));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          ///hideLoading
          dialogUtils.hideLoading(context);

          ///showMessageError
          dialogUtils.showMessage(
              context, 'Error', 'No user found for that email.',
              posActionName: "ok");
        } else if (e.code == 'wrong-password') {
          ///hideLoading
          dialogUtils.hideLoading(context);

          ///showMessageError
          dialogUtils.showMessage(
              context, 'Error', 'Wrong password provided for that user.',
              posActionName: "ok");
        }
      } catch (e) {
        ///hideLoading
        dialogUtils.hideLoading(context);

        ///showMessageError
        dialogUtils.showMessage(context, 'Error', '${e.toString()}',
            posActionName: "ok");
      }
    }
  }
}
