import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hallo_doctor_client/app/models/time_slot_model.dart';

class TimeSlotService {
  Future<List<TimeSlot>> getListAppointment(User user) async {
    try {
      var userId = user.uid;
      var documentSnapshot = await FirebaseFirestore.instance
          .collection('DoctorTimeslot')
          .where('bookByWho.userId', isEqualTo: userId)
          .where('charged', isEqualTo: true)
          .get();

      if (documentSnapshot.docs.isEmpty) {
        return [];
      }
      List<TimeSlot> listTimeslot = documentSnapshot.docs.map((doc) {
        var data = doc.data();
        data['timeSlotId'] = doc.reference.id;
        TimeSlot timeSlot = TimeSlot.fromJson(data);
        return timeSlot;
      }).toList();

      return listTimeslot;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future rescheduleTimeslot(
      TimeSlot timeSlotNow, TimeSlot timeslotChanged) async {
    try {
      var callable =
          FirebaseFunctions.instance.httpsCallable('rescheduleTimeslot');
      await callable({
        'timeSlotIdNow': timeSlotNow.timeSlotId,
        'timeslotChanged': timeslotChanged.timeSlotId
      });
    } on FirebaseFunctionsException catch (e) {
      return Future.error(e.message!);
    }
  }
}
