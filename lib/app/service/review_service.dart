import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hallo_doctor_client/app/models/doctor_model.dart';
import 'package:hallo_doctor_client/app/models/review_model.dart';
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
      'doctorId': timeSlot.doctorid,
      'user': {
        'displayName': UserService().currentUser!.displayName,
        'photoUrl': UserService().getProfilePicture(),
      }
    });
    try {} catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<List<ReviewModel>> getDoctorReview(
      {required Doctor doctor, int limit = 4}) async {
    try {
      var reviewRef = await FirebaseFirestore.instance
          .collection('Review')
          .where('doctorId', isEqualTo: doctor.doctorId)
          .limit(limit)
          .get();
      List<ReviewModel> listReview = reviewRef.docs.map((doc) {
        var data = doc.data();
        data['reviewId'] = doc.reference.id;
        ReviewModel review = ReviewModel.fromMap(data);
        return review;
      }).toList();
      return listReview;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
