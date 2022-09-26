import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_days/models/new_day_model.dart';

class MyDaysRepository {
  Stream<List<NewDayModel>> getNewDayStream() {
    return FirebaseFirestore.instance
        .collection('mydays')
        .orderBy('date')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((document) {
        return NewDayModel(
            id: document.id,
            date: (document['date'] as Timestamp).toDate(),
            textData: document['title'],
            rating: (document['rating'] + 0.0) as double,
            ratingUpdate: (document['rating_update'] as bool));
      }).toList();
    });
  }

  Future<void> delete(String id) {
    return FirebaseFirestore.instance.collection('mydays').doc(id).delete();
  }

  Future<void> add(
    String textData,
    DateTime date,
  ) async {
    await FirebaseFirestore.instance.collection('mydays').add(
      {
        'title': textData,
        'date': date,
        'rating': 0.0,
        'rating_update': false,
      },
    );
  }

  Future<void> ratingUpdate(
    String id,
    double rating,
  ) async {
    await FirebaseFirestore.instance.collection('mydays').doc(id).update(
      {
        'rating': rating,
        'rating_update': true,
      },
    );
  }
}
