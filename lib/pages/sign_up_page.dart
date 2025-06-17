import 'package:auto_route/auto_route.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_project/controller/auth_controller.dart';
import 'package:movie_project/core/router/app_router.gr.dart';

@RoutePage()
class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final TextEditingController _emailContoller = TextEditingController();
  final TextEditingController _passwordContoller = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailContoller.dispose();
    _passwordContoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SİGN UP"), centerTitle: true),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/assets/signUp.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          AspectRatio(
            aspectRatio: 5 / 4,
            child: Container(
              decoration: BoxDecoration(color: Colors.black87),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 20,
                      ),
                      child: Text(
                        "SİGN UP",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: _emailContoller,
                        decoration: InputDecoration(
                          icon: Icon(Icons.email, color: Colors.white),
                          labelText: "E-Mail",
                          labelStyle: TextStyle(color: Colors.white),
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isNotEmpty ||
                              EmailValidator.validate(value)) {
                            return null;
                          }
                          return "Incorrect Format";
                        },
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        obscureText: true,
                        controller: _passwordContoller,
                        decoration: InputDecoration(
                          icon: Icon(Icons.password, color: Colors.white),
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password is required";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: MaterialButton(
                          child: Text(
                            "SİGN UP",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          onPressed: () {
                            if (EmailValidator.validate(_emailContoller.text)) {
                              ref
                                  .read(authControllerProvider)
                                  .signUpWithEmailAndPassword(
                                    email: _emailContoller.text.trim(),
                                    password: _passwordContoller.text.trim(),
                                  );

                              context.pushRoute(SignInRoute());
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Email is Incorrect Format!"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                        ),
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
