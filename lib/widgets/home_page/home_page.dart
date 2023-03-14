import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ui_demo/constants/constants.dart';
import 'package:flutter_ui_demo/widgets/login/login.dart';
import 'package:flutter_ui_demo/widgets/background/background_widget.dart';
import 'package:flutter_ui_demo/widgets/add_photo/add_photo_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  void _handleLogin(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const LoginWidget()));
  }

  void _handleAddPhoto(BuildContext context) {
    File placeholder = File("");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddPhotoWidget(imageFile: placeholder,)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackgroundContainer(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => _handleLogin(context),
                      child: const Text(
                        loginButtonText,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  SizedBox(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => _handleAddPhoto(context),
                      child: const Text(
                        addPhotoButtonText,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
