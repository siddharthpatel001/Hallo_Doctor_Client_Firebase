import 'package:hallo_doctor_client/app/service/doctor_service.dart';
import 'package:hallo_doctor_client/app/service/user_service.dart';

import '../models/doctor_model.dart';

class ChatService {
  Future<Doctor> getDoctorByUserId(String userId) async {
    try {
      var user = await UserService().getUsernameById(userId);
      var doctor = await DoctorService().getDoctorDetail(user!.doctorId!);
      return doctor;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
