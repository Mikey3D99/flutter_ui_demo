import 'package:flutter/material.dart';
import 'package:flutter_ui_demo/widgets/background/background_widget.dart';
import 'package:flutter_ui_demo/constants/constants.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  LoginWidgetState createState() => LoginWidgetState();
}

class LoginWidgetState extends State<LoginWidget> {

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final paddingHeight = screenHeight / 5;

    return Scaffold(
      appBar: AppBar(
        title: const Text(loginButtonText),
      ),
      body: BackgroundContainer(
        child: Padding(
            padding: EdgeInsets.only(top: paddingHeight),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: inputEmailText,
                      filled: true,
                      fillColor: Colors.white,
                      // set the background color of the TextField
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.blueAccent,
                            width:
                                2.0), // set the border color and width of the TextField
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.blueAccent,
                            width:
                                2.0), // set the border color and width of the TextField when it's focused
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: inputPasswordText,
                      filled: true,
                      fillColor: Colors.white,
                      // set the background color of the TextField
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.blueAccent,
                            width:
                            2.0), // set the border color and width of the TextField
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.blueAccent,
                            width:
                            2.0), // set the border color and width of the TextField when it's focused
                      ),
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 14),
                    foregroundColor: Colors.white, // set the text color to red
                  ),
                  onPressed: () {},
                  child: const Text(forgotPasswordText),
                ),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      loginButtonText,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 14),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {},
                      child: const Text(newUserButtonText),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
// stateful logic and variables here
}
