import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'image_carousel_model.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class ImageCarousel {
  ImageCarousel({this.id, this.imageUrl, this.fileName});
  String? id;
  @JsonKey(name: 'imageUrl')
  String? imageUrl;
  @JsonKey(name: 'fileName')
  String? fileName;

  factory ImageCarousel.fromJson(Map<String, dynamic> json) =>
      _$ImageCarouselFromJson(json);
  Map<String, dynamic> toJson() => _$ImageCarouselToJson(this);
  factory ImageCarousel.fromFirestore(DocumentSnapshot doc) =>
      ImageCarousel.fromJson(doc.data()! as Map<String, dynamic>)..id = doc.id;
}
