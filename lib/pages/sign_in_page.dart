import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movie_project/core/router/app_router.gr.dart';

@RoutePage()
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("lib/assets/signInBackground.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "What Should i Watch",
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                SizedBox(height: 20),
                Text(
                  "No time to be bored, too many movies to watch!",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
          AspectRatio(
            aspectRatio: 5 / 4,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: TextFormField(
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
                    padding: const EdgeInsets.all(30.0),
                    child: TextFormField(
                      obscureText: true,
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
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minWidth: double.infinity,
                    child: Text(
                      "SIGN IN",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    onPressed: () {
                      context.pushRoute(HomeRoute());
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
