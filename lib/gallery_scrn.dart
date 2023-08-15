import 'dart:io';

import 'package:camera_app/imageView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'functions.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Gallery'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisExtent: 190, mainAxisSpacing: 8),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ImageView(index: index),
                  ));
                },
                child: Container(
                  child: Image.file(File(imageNotifier[index])),
                ),
              ),
              itemCount: imageNotifier.length,
            ),
          )),
    );
  }
}
