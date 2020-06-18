import 'package:flutter/material.dart';
import 'package:sevaBusiness/constants/themeColors.dart';

class GreenPaintingBgProducts extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size){
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();
    Path ovalPath = Path();

    // top left graphic
    ovalPath.lineTo(width*0.25, 0);
    ovalPath.quadraticBezierTo(width*0.25, height*0.12, 0, height*0.18);
    ovalPath.close();


    // paint
    paint.color = ThemeColoursSeva().vlgGreen;
    canvas.drawPath(ovalPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

class GreenPaintBgLogin extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size){
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();
    Path ovalPath = Path();

    // top left graphic
    ovalPath.lineTo(width*0.25, 0);
    ovalPath.quadraticBezierTo(width*0.25, height*0.12, 0, height*0.18);
    ovalPath.close();

 
    paint.color = ThemeColoursSeva().vlgGreen;
     var center = Offset(width / 0.78,height / 2.9);
    canvas.drawCircle(center, 180.0, paint);
      var location = Offset(width / 7,height / 0.93);
    canvas.drawCircle(location, 180.0, paint);


    // paint
    canvas.drawPath(ovalPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}