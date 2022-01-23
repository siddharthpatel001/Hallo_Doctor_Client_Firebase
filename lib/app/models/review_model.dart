import 'package:hallo_doctor_client/app/models/user_model.dart';

class ReviewModel {
  ReviewModel(
      {this.reviewId,
      this.rating,
      this.review,
      this.timeSlotId,
      this.userId,
      this.user});
  String? reviewId;
  int? rating;
  String? review;
  String? timeSlotId;
  String? userId;
  UserModel? user;

  static const String _reviewId = 'reviewId';
  static const String _rating = 'rating';
  static const String _timeSlotId = 'timeSlotId';
  static const String _review = 'review';
  static const String _userId = 'userId';
  static const String _user = 'user';

  factory ReviewModel.fromMap(Map<String, dynamic> data) {
    return ReviewModel(
        reviewId: data[_reviewId],
        rating: data[_rating],
        review: data[_review],
        timeSlotId: data[_timeSlotId],
        userId: data[_userId],
        user: data[_user] != null ? UserModel.fromJson(data[_user]) : null);
  }
}
