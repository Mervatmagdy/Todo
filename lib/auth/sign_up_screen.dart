import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Dialogs/dialog_utilts.dart';
import 'package:todo/Home/Home_Screen.dart';
import 'package:todo/MyTheme.dart';
import 'package:todo/Provider/Auth_Provider.dart';
import 'package:todo/auth/sign_in_screen.dart';
import 'package:todo/components/custom_text_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:todo/modal/firebase_utils.dart';
import 'package:todo/modal/my_user.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = 'sign_up_screen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var nameController = TextEditingController(text: "mervat");

  var emailController = TextEditingController(text: "mervat@gmail.com");

  var passController = TextEditingController(text: '12345678');

  var confirmController = TextEditingController(text: '12345678');

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
                              return "Please enter user name";
                            }
                            return null;
                          },
                          title: 'User Name',
                          textEditingController: nameController),
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
                      CustomTextField(
                          hiddenPass: true,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'Please enter confirm password';
                            } else if (text != passController.text) {
                              return "Confirm not match password";
                            } else {
                              return null;
                            }
                          },
                          title: 'Confirm Password',
                          textInputType: TextInputType.number,
                          textEditingController: confirmController),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                )),
                                padding: MaterialStatePropertyAll(
                                    EdgeInsets.symmetric(vertical: 12))),
                            onPressed: () {
                              register();
                              setState(() {});
                            },
                            child: Text(
                              "SIGN UP",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: MyTheme.whiteColor),
                            )),
                      ),
                      TextButton(
                        style: ButtonStyle(
                            overlayColor:
                                MaterialStatePropertyAll(Colors.transparent)),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(SignInScreen.routeName);
                        },
                        child: Text('Already have an account',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: MyTheme.primaryColor)),
                      )
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }

  Future<void> register() async {
    if (formKey.currentState?.validate() == true) {
      ///register
      dialogUtils.showLoading(context, "Loading...");
      try {
        var credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passController.text,
        );
        MyUser myUser=MyUser(id:credential.user?.uid??"", name:nameController.text, email:emailController.text);
       var authProvider=Provider.of<AuthProvider>(context,listen:false);
       authProvider.updateUser(myUser);
        await FirebaseUtils.addUserToFireStore(myUser);
        ///hideLoading
        dialogUtils.hideLoading(context);

        ///showMessageSuccess
        dialogUtils.showMessage(context, 'Success', 'Registerion Successfully',
            posActionName: "ok",
            posAction: () =>
                Navigator.pushReplacementNamed(context, HomeScreen.routeName));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ///hideLoading
          dialogUtils.hideLoading(context);

          ///showMessageError
          dialogUtils.showMessage(context,'Error','The password provided is too weak.',posActionName:"ok");
        } else if (e.code == 'email-already-in-use') {
          ///hideLoading
          dialogUtils.hideLoading(context);
          ///showMessageError
          dialogUtils.showMessage(context,'Error','The account already exists for that email.',posActionName:"ok");
        }
      } catch (e) {
        ///hideLoading
        dialogUtils.hideLoading(context);
        ///showMessageError
        dialogUtils.showMessage(context,'Error','${e.toString()}',posActionName:"ok");

      }
    }
  }
}
