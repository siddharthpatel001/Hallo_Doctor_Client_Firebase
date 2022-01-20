import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({Key? key, required this.msg}) : super(key: key);

  final String msg;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(
        msg,
        textAlign: TextAlign.center,
        style: GoogleFonts.nunito(fontSize: 15),
      ),
    );
  }
}
