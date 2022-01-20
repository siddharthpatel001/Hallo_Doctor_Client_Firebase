import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  /// Icon data
  const ProfileButton(
      {Key? key,
      required this.icon,
      required this.text,
      required this.onTap,
      this.hideArrowIcon = false})
      : super(key: key);

  /// Icon data
  final IconData icon;

  /// Button text string
  final String text;

  /// Hide arrow icon
  final bool hideArrowIcon;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Row(
            children: [
              Icon(
                icon,
                size: 30,
                color: Colors.grey[700],
              ),
              SizedBox(
                width: 10,
              ),
              Text(text),
              Spacer(),
              hideArrowIcon
                  ? SizedBox.shrink()
                  : Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 20,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
