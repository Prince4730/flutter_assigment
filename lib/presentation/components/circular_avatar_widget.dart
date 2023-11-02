import 'package:flutter/material.dart';
import 'package:flutter_assigment/utility/colors.dart';


class CircularAvatarWidget extends StatelessWidget {
  const CircularAvatarWidget({
    Key? key,
    this.margin=10,
    this.titleText="S"
  }) : super(key: key,);
    final String titleText;
    final double margin;




  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.all(margin),
      child: Container(
        width: 45,
        height: 45,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: kLightPinkColor,
        ),
        child: Center(
          child: Text(
            titleText,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}