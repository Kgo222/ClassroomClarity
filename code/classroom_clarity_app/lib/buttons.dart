import 'package:flutter/material.dart';
import 'theme.dart';
import 'homepage.dart';
import 'main.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class EngagementButton extends StatefulWidget {
  final int level;
  final Color color;
  final bool isSelected;
  final VoidCallback onPressed;

  const EngagementButton({
    Key? key,
    required this.level,
    required this.color,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  @override
  _EngagementButtonState createState() => _EngagementButtonState();
}

class _EngagementButtonState extends State<EngagementButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(2),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: widget.isSelected ? Border.all(color: AppColors.darkRed, width: 2) : null,
        ),
        child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.color,
            alignment: Alignment.center,
            fixedSize: Size(5,100),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Center(
            child: Text(
              "${widget.level}",
              style: const TextStyle(color: AppColors.black, fontSize: 15),
            ),
          ),
        ),
      ),
    );
  }
}
