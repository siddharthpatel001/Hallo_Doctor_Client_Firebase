import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  static final greyTextColor = Color(0xFF8A8A8E);
  static final cardLighBluecolor = Color(0xFFECF9FC);
  static final secondaryBlueColor = Color(0xFF33C5FD);
  static final primaryBlueColor = Color(0xFF0091FC);
  static const whiteGreyColor = Color(0xFFF9F9F9);
  static final homeTitleStyle =
      GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: 20);

  static final homeSubTitleStyle = GoogleFonts.roboto(
      fontWeight: FontWeight.w500, fontSize: 15, color: greyTextColor);

  static final appointmentDetailTextStyle =
      GoogleFonts.nunito(fontWeight: FontWeight.w500, fontSize: 18);
  static final greyTextInfoStyle = GoogleFonts.nunito(
      fontWeight: FontWeight.w500, fontSize: 14, color: greyTextColor);
}
