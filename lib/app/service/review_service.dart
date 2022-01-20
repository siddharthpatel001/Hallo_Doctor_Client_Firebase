import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hallo_doctor_client/app/models/doctor_model.dart';
import 'package:hallo_doctor_client/app/models/review_model.dart';
import 'package:hallo_doctor_client/app/models/time_slot_model.dart';

class ReviewService {
  Future saveReview(
      String review, int rating, TimeSlot timeSlot, User user) async {
    print('review : ' + review);
    print('rating :' + rating.toString());
    ReviewModel reviewObject = ReviewModel();
    //reviewObject.review = review;
    //reviewObject.rating = rating;
    //reviewObject.set('timeSlot', timeSlot.toPointer());
    //reviewObject.user = user;
    //reviewObject.doctor = timeSlot.doctor;

    //var apiResponse = await reviewObject.save();

    // if (apiResponse.success) {
    //   print('Success save review');
    //   //timeSlot.set('review', reviewObject.toPointer());
    //   // ParseResponse timeSlotResponse = await timeSlot.update();
    //   // if (timeSlotResponse.success) {
    //   //   print('Save timeslot review');
    //   // }
    // } else {
    //   return Future.error(apiResponse.error.toString());
    // }
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
