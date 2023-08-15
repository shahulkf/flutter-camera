import 'dart:io';

import 'package:camera_app/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ImageView extends StatelessWidget {
  const ImageView({super.key,required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.file(File(imageNotifier[index])),
      ),
    );
  }
}
