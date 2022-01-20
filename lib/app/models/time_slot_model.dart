import 'package:cloud_firestore/cloud_firestore.dart';

import 'doctor_model.dart';

class TimeSlot {
  TimeSlot({
    this.timeSlotId,
    this.timeSlot,
    this.duration,
    this.price,
    this.available,
    this.doctorid,
    this.doctor,
    this.purchaseTime,
  });
  static const String _timeSlotId = 'timeSlotId';
  static const String _timeSlot = 'timeSlot';
  static const String _duration = 'duration';
  static const String _price = 'price';
  static const String _available = 'available';
  static const String _doctorId = 'doctorId';
  static const String _doctor = 'doctor';
  static const String _purchaseTime = 'purchaseTime';

  String? timeSlotId;
  DateTime? timeSlot;
  int? duration;
  int? price;
  bool? available;
  String? doctorid;
  Doctor? doctor;
  DateTime? purchaseTime;

  factory TimeSlot.fromJson(Map<String, dynamic> jsonData) {
    return TimeSlot(
      timeSlotId: jsonData[_timeSlotId],
      timeSlot: (jsonData[_timeSlot] as Timestamp).toDate(),
      duration: jsonData[_duration],
      price: jsonData[_price],
      available: jsonData[_available],
      doctorid: jsonData[_doctorId],
      doctor: Doctor.fromJson(jsonData[_doctor]),
      purchaseTime: jsonData[_purchaseTime] != null
          ? (jsonData[_purchaseTime] as Timestamp).toDate()
          : null,
    );
  }
}
