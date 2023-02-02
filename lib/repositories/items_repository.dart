import 'package:cantwait28/models/item_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemsRepository {
  Stream<List<ItemModel>> getItemsStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc('rE4hULvSN5OWHXXiSnVJ4sBkG272')
        .collection('items')
        .orderBy('release_date')
        .snapshots()
        .map((querySnaapshot) {
      return querySnaapshot.docs.map(
        (doc) {
          return ItemModel(
            id: doc.id,
            title: doc['title'],
            imageURL: doc['image_url'],
            relaseDate: (doc['release_date'] as Timestamp).toDate(),
          );
        },
      ).toList();
    });
  }

  Future<void> delete({required String id}) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc('rE4hULvSN5OWHXXiSnVJ4sBkG272')
        .collection('items')
        .doc(id)
        .delete();
  }

  Future<ItemModel> get({required String id}) async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc('rE4hULvSN5OWHXXiSnVJ4sBkG272')
        .collection('items')
        .doc(id)
        .get();
    return ItemModel(
      id: doc.id,
      title: doc['title'],
      imageURL: doc['image_url'],
      relaseDate: (doc['release_date'] as Timestamp).toDate(),
    );
  }

  Future<void> add(
    String title,
    String imageURL,
    DateTime releaseDate,
  ) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc('rE4hULvSN5OWHXXiSnVJ4sBkG272')
        .collection('items')
        .add(
      {
        'title': title,
        'image_url': imageURL,
        'release_date': releaseDate,
      },
    );
  }
}
