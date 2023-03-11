import 'package:flutter/material.dart';

class CircularPlayButton extends StatelessWidget {
  final double size;
  final Color color;
   final VoidCallback onPressed;

  CircularPlayButton({
    this.size = 50.0,
    this.color = Colors.white,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),      
      child: IconButton(
        iconSize: size-14,
        icon: Icon(
          Icons.play_arrow,
          color: Colors.black,
        ),
        
        onPressed: onPressed,
      ),
      
    );
  }
}
