import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hallo_doctor_client/app/models/doctor_category_model.dart';
import 'package:hallo_doctor_client/app/models/doctor_model.dart';
import 'package:hallo_doctor_client/app/models/review_model.dart';
import 'package:hallo_doctor_client/app/models/time_slot_model.dart';

class DoctorService {
  //Get list of Doctor schedule base on doctor id
  Future<List<TimeSlot>> getDoctorTimeSlot(Doctor doctor) async {
    try {
      print('doctor id : ' + doctor.doctorId!);
      //List<TimeSlot> listTimeslot = [];
      QuerySnapshot doctorScheduleRef = await FirebaseFirestore.instance
          .collection('DoctorTimeslot')
          .where('doctorId', isEqualTo: doctor.doctorId)
          .get();
      var listTimeslot = doctorScheduleRef.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data['timeSlotId'] = doc.reference.id;
        TimeSlot timeSlot = TimeSlot.fromJson(data);

        return timeSlot;
      }).toList();
      print('length : ' + listTimeslot.length.toString());
      if (doctorScheduleRef.docs.isEmpty) return [];
      return listTimeslot;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  //Get doctor schedule base on id
  Future getDoctorScheduleById(String scheduleId) async {
    // QueryBuilder<ParseObject> queryDoctorSchedule =
    //     QueryBuilder(ParseObject('DoctorSchedule'))
    //       ..whereEqualTo('objectId', scheduleId)
    //       ..includeObject(['doctor.name'])
    //       ..excludeKeys(['status']);
    // final ParseResponse apiResponse = await queryDoctorSchedule.query();
    // if (apiResponse.success && apiResponse.results != null) {
    //   var parseObject = apiResponse.results as List<ParseObject>;
    //   var listSchedule = parseObject.map((e) {
    //     var doctorName = e.get<Object>('doctor');
    //     return doctorName;
    //   }).toList();
    //   print('doctor : ' + listSchedule.toString());
    // } else {
    //   print('fail to get the data + ' + apiResponse.error.toString());
    //   return Future.error(apiResponse.error!);
    // }
  }

// Get doctor and all its property
  Future<Doctor> getDoctorDetail(String doctorId) async {
    var doctorSnapshot = await FirebaseFirestore.instance
        .collection('Doctors')
        .doc(doctorId)
        .get();
    Doctor doctor =
        Doctor.fromJson(doctorSnapshot.data() as Map<String, dynamic>);
    return doctor;
  }

  Future<List<Doctor>> getListDoctorByCategory(
      DoctorCategory doctorCategory) async {
    try {
      List<Doctor> listDoctor = [];
      var listDoctorQuery = await FirebaseFirestore.instance
          .collection('Doctors')
          .where('doctorCategory.categoryId',
              isEqualTo: doctorCategory.categoryId)
          .get();

      print('masuk sini kok');
      if (listDoctorQuery.docs.isEmpty) return [];
      var list = listDoctorQuery.docs.map((doc) {
        var data = doc.data();
        data['doctorId'] = doc.reference.id;
        Doctor doctor = Doctor.fromJson(data);
        listDoctor.add(doctor);
      }).toList();
      print('list doctor : ' + list.toString());
      return listDoctor;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<Doctor>> getTopRatedDoctor({int limit = 10}) async {
    // QueryBuilder<ReviewModel> query = QueryBuilder(ReviewModel())
    //   ..whereGreaterThan('rating', 4)
    //   ..includeObject(['doctor'])
    //   ..setLimit(limit);
    // ParseResponse apiResponse = await query.query();
    // if (apiResponse.success) {
    //   print('success get top rated doctor');
    //   if (apiResponse.results == null) return [];
    //   var list = apiResponse.results!.cast<ReviewModel>();
    //   print(list.toString());
    //   List<Doctor> listDoctor = list.map((e) => e.doctor!).toList();
    //   return listDoctor;
    // } else {
    //   return Future.error(apiResponse.error!.message);
    // }
    return [];
  }

  // Future<List<Doctor>> searchDoctor(String doctorName) async {
  //   QueryBuilder<Doctor> query = QueryBuilder(Doctor())
  //     ..whereContains('name', doctorName)
  //     ..setLimit(10)
  //     ..keysToReturn(['name', 'doctorPicture']);
  //   ParseResponse apiResponse = await query.query();
  //   if (apiResponse.success && apiResponse.results != null) {
  //     print('success get query' + apiResponse.results.toString());
  //     var list = apiResponse.results!.cast<Doctor>();
  //     //List<String> listDoctorName = list.map((e) => e.name!).toList();
  //     return list;
  //   } else {
  //     return Future.error(apiResponse.error!.message);
  //   }
  // }
}
