import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hallo_doctor_client/app/models/time_slot_model.dart';
import 'package:hallo_doctor_client/app/service/user_service.dart';

class ReviewService {
  Future saveReview(
      String review, int rating, TimeSlot timeSlot, User user) async {
    print('review : ' + review);
    await FirebaseFirestore.instance
        .collection('Review')
        .doc(timeSlot.timeSlotId)
        .set({
      'review': review,
      'rating': rating,
      'timeSlotId': timeSlot.timeSlotId,
      'userId': UserService().currentUser!.uid,
      'doctorId': timeSlot.doctorid
    });
    try {} catch (e) {
      return Future.error(e.toString());
    }
  }

  // Future<List<ReviewModel>> getDoctorReview(
  //     {required Doctor doctor, int limit = 4}) async {
  //   // QueryBuilder<ReviewModel> query = QueryBuilder(ReviewModel())
  //   //   // ..whereEqualTo('doctor', doctor.toPointer())
  //   //   ..includeObject(['user'])
  //   //   ..setLimit(limit);

  //   // ParseResponse apiResponse = await query.query();
  //   // if (apiResponse.success) {
  //   //   print('success get doctor review ' + apiResponse.results.toString());
  //   //   if (apiResponse.results == null) return [];
  //   //   var list = apiResponse.results!.cast<ReviewModel>();
  //   //   return list;
  //   // } else {
  //   //   return Future.error(apiResponse.error!.message);
  //   // }
  //   DocumentReference reviewDocument = FirebaseFirestore.instance.doc(documentPath)
  // }
}
