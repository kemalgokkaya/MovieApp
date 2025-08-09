import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_project/controller/auth_controller.dart';
import 'package:movie_project/core/router/app_router.gr.dart';

@RoutePage()
class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final TextEditingController emailContoller = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailContoller.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/assets/signIn.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      child: Text(
                        "Sign In",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: emailContoller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "E-mail is required";
                          }
                          return null;
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          icon: Icon(Icons.email_sharp, color: Colors.white),
                          labelText: "E-Mail",
                          labelStyle: TextStyle(color: Colors.white54),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password is required";
                          }
                          return null;
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          icon: Icon(Icons.password, color: Colors.white),
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.white54),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              context.pushRoute(SignUpRoute());
                            },
                            child: Text(
                              "Don't you have an account? SİGN UP",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        minWidth: double.infinity,
                        child: Text(
                          "SIGN IN",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final email = emailContoller.text.trim();
                            final password = passwordController.text.trim();
                            try {
                              await ref
                                  .read(authControllerProvider)
                                  .signInWithEmailAndPassword(
                                    email: email,
                                    password: password,
                                  );
                              context.replaceRoute(HomeRoute());
                            } catch (e) {
                              print("$e");
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "E-mail veya şifrenizi kontrol ediniz",
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
