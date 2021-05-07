import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';

class CrudMethods {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final Query desRefFeaturedPlaces = FirebaseFirestore.instance
      .collection("destination_collection")
      .where("filterType", isEqualTo: "featurePlaces");

  final Query desRefPopularPlaces = FirebaseFirestore.instance
      .collection("destination_collection")
      .where("filterType", isEqualTo: "popularPlaces");

  final Query desRefBeach = FirebaseFirestore.instance
      .collection("destination_collection")
      .where("type", isEqualTo: "beach");

  final Query desRefTemple = FirebaseFirestore.instance
      .collection("destination_collection")
      .where("type", isEqualTo: "temple");

  final Query desRefMuseum = FirebaseFirestore.instance
      .collection("destination_collection")
      .where("type", isEqualTo: "museum");

  final Query desRefHeritage = FirebaseFirestore.instance
      .collection("destination_collection")
      .where("type", isEqualTo: "heritage site");

  final Query desRefMountain = FirebaseFirestore.instance
      .collection("destination_collection")
      .where("type", isEqualTo: "mountain");

  final Query desRefWildlife = FirebaseFirestore.instance
      .collection("destination_collection")
      .where("type", isEqualTo: "wildlife");

  final CollectionReference blogRef =
      FirebaseFirestore.instance.collection("blogs");

  final CollectionReference destinationRef =
      FirebaseFirestore.instance.collection("destination_collection");

  final CollectionReference userRef =
      FirebaseFirestore.instance.collection("user");

  Future<void> addData(blogData) async {
    FirebaseFirestore.instance
        .collection("blogs")
        .add(blogData)
        .catchError((e) {
      print(e);
    });
  }

  getData() async {
    // ignore: await_only_futures
    return await FirebaseFirestore.instance.collection("blogs").snapshots();
  }

  getUserId() {
    return _firebaseAuth.currentUser.uid;
  }
}
