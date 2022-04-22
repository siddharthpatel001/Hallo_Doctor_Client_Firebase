import 'doctor_category_model.dart';

class Doctor {
  Doctor(
      {this.doctorId,
      this.doctorName,
      this.doctorPicture,
      this.doctorPrice,
      this.doctorShortBiography,
      this.doctorCategory,
      this.doctorHospital,
      this.accountStatus});
  static const String _doctorId = 'doctorId';
  static const String _doctorName = 'doctorName';
  static const String _doctorPicture = 'doctorPicture';
  static const String _doctorPrice = 'doctorBasePrice';
  static const String _doctorShortBiography = 'doctorBiography';
  static const String _doctorCategory = 'doctorCategory';
  static const String _doctorHospital = 'doctorHospital';
  static const String _accountStatus = 'accountStatus';
  String? doctorId;
  String? doctorName;
  String? doctorPicture;
  int? doctorPrice;
  String? doctorShortBiography;
  DoctorCategory? doctorCategory;
  String? doctorHospital;
  String? accountStatus;

  factory Doctor.fromJson(Map<String, dynamic> data) {
    return Doctor(
        doctorId: data[_doctorId],
        doctorName: data[_doctorName],
        doctorPicture: data[_doctorPicture],
        doctorPrice: data[_doctorPrice],
        doctorShortBiography: data[_doctorShortBiography],
        doctorCategory: data[_doctorCategory] != null
            ? DoctorCategory.fromJson(data[_doctorCategory])
            : null,
        doctorHospital: data[_doctorHospital],
        accountStatus: data[_accountStatus]);
  }
}
