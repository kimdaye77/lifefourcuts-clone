import 'package:cloud_firestore/cloud_firestore.dart';

class Frame {
  final String title;
  final String hashtag;
  final String image;
  final int? price;
  final int? cuts;
  final bool like;
  final String? brand;
  final DocumentReference reference;

  Frame.fromMap(Map<String, dynamic> map, {required this.reference})
      : title = map['title'],
        hashtag = map['hashtag'],
        image = map['image'],
        price = map['price'],
        cuts = map['cuts'],
        brand = map['brand'],
        like = map['like'];

  Frame.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(
          snapshot.data() as Map<String, dynamic>,
          reference: snapshot.reference,
        );
}
