// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_reminder_medicine/models/mood_model.dart';
import 'package:project_reminder_medicine/models/user_model.dart';
import 'package:uuid/uuid.dart';

import '../models/medicion_model.dart';

class FirestoreFirebase extends GetxController {
  CollectionReference firestore =
      FirebaseFirestore.instance.collection('users');

  Stream getStreamMedicine() {
    return FirebaseFirestore.instance
        .collection('medicine')
        .where('pasienUid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  final references = FirebaseFirestore.instance.collection('users');
  fetchDataAllUser() async {
    try {
      QuerySnapshot querySnapshot = await references.get();
      return querySnapshot.docs;
    } catch (e) {
      debugPrint('Error fetching data: $e');
    }
  }

  extractUsers() async {
    try {
      List<UserModel> tempUser = [];
      List<DocumentSnapshot> users = await fetchDataAllUser();
      for (var element in users) {
        var json = element.data() as Map<String, dynamic>;
        var temp = UserModel.fromJson(json);
        tempUser.add(temp);
      }
      return tempUser;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future createNewMoodTracker(String paramDay, String paramFeel,
      String paramTags, String paramWrite, String badHappen) async {
    try {
      var db = FirebaseFirestore.instance;
      final moodTracker = <String, dynamic>{
        'uuid': FirebaseAuth.instance.currentUser!.uid,
        'username': FirebaseAuth.instance.currentUser!.displayName,
        'colorDay': paramDay,
        'feelings': paramFeel,
        'tags': paramTags,
        'story': paramWrite,
        'badStory': badHappen,
        'createdAt': Timestamp.now().toString(),
      };

      await db.collection('tracker').doc().set(moodTracker).onError(
            (error, _) => debugPrint('Error writing document: $error'),
          );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  createANewMedicine(String pasienUid, String namaObat, String berapaKali,
      List<String> waktuMinum) {
    try {
      var db = FirebaseFirestore.instance;
      final medicine = {
        "randomUid": const Uuid().v4().toString(),
        "pasienUid": pasienUid,
        "namaObat": namaObat,
        "dosisObat": berapaKali,
        "waktuObat": waktuMinum,
        "sudahMinum": false,
      };

      db.collection('medicine').doc().set(medicine).onError(
            (error, _) => debugPrint("Error writing document: $error"),
          );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>>
      findAllMedicineFromFirestore() async {
    try {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('medicine')
          .where('pasienUid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      return querySnapshot;
    } catch (e) {
      throw Exception('Failed: $e');
    }
  }

  createNewAccountFirestore(String username, String uuid, String email) {
    try {
      var db = FirebaseFirestore.instance;

      final user = userModelToJson(UserModel(
        uuid: uuid,
        username: username,
        email: email,
        age: 0,
        jenisKelamin: '',
        diagnosisPenyakit: '',
        alamat: '',
        kontakPasien: '',
        kontakKeluarga: '',
        createdAt: Timestamp.now(),
        updateAt: Timestamp.now(),
      ));

      db
          .collection("users")
          .doc(uuid)
          .set(user)
          .onError((error, _) => debugPrint('Error writing document: $error'));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<UserModel> fetchDataUser() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance
              .doc('users/${FirebaseAuth.instance.currentUser!.uid}')
              .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic> json = documentSnapshot.data()!;
        // Now 'data' contains the fields of your document

        return UserModel.fromJson(json);
      } else {
        // Authentication failed, throw an exception or return a default UserModel
        throw Exception('Authentication failed');
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
      rethrow;
    }
  }

  // todo: Mengambil semua data user dari firebase collection medicine dan juga tracker untuk mendapatkan obat yang digunakan dan bagaimana harinya
  Future querySnapshotMedicine(String paramUid) async {
    try {
      var db = FirebaseFirestore.instance;
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await db
          .collection('medicine')
          .where('pasienUid', isEqualTo: paramUid)
          .get();

      return querySnapshot;
    } catch (e) {
      throw Exception('error fetch data: $e');
    }
  }

  Future fetchMedicineTrackerByUid(String uid) async {
    try {
      var result = await querySnapshotMedicine(uid);
      // Access the data from result
      List<QueryDocumentSnapshot<Map<String, dynamic>>> documents = result.docs;

      List<ModelMedicineFirebase> medFirebase = [];
      // Process or display the data as needed
      for (var document in documents) {
        medFirebase.add(ModelMedicineFirebase.fromJson(document.data()));
      }

      return medFirebase;
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
  // Selesai mendapatkan pasien sesuai uid

  // TODO: mengambil data mood dari user sesuai uid
  Future querySnapshotMood(String paramUid) async {
    try {
      var db = FirebaseFirestore.instance;
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await db
          .collection('tracker')
          .where('uuid', isEqualTo: paramUid)
          .orderBy(
            'createdAt',
            descending: false,
          )
          .get();

      return querySnapshot;
    } catch (e) {
      throw Exception('error fetch data: $e');
    }
  }

  Future conclusionSevenDays(String uid) async {
    List<ModelMoodTracker> medFirebase = await fetchMoodTrackerByUid(uid);
    List mood = [];
    List<String> moodTemp = [];
    int senang = 0;
    int sedih = 0;
    int counterMood = 0;
    for (int i = 0; i < medFirebase.length ~/ 7; i++) {
      for (int j = counterMood; j < (counterMood + 6); j++) {
        ModelMoodTracker data = medFirebase[j];
        mood.add(data.colorDay);
      }

      for (String e in mood) {
        if (e == 'Sangat Senang' || e == 'Senang') {
          senang++;
        } else if (e == 'Sedih' || e == 'Sangat Sedih') {
          sedih++;
        }
      }

      if (senang >= 3) {
        debugPrint('Netral');
        moodTemp.add('Netral');
      } else {
        debugPrint('Sedih');
        moodTemp.add('Sedih');
      }

      senang = 0;
      sedih = 0;
      counterMood += 7;
      mood.clear();
    }

    return moodTemp;
  }

  Future fetchMoodTrackerByUid(String uid) async {
    try {
      var result = await querySnapshotMood(uid);
      // Access the data from result
      List<QueryDocumentSnapshot<Map<String, dynamic>>> documents = result.docs;

      List<ModelMoodTracker> medFirebase = [];
      // Process or display the data as needed
      for (var document in documents) {
        medFirebase.add(ModelMoodTracker.fromJson(document.data()));
      }

      return medFirebase;
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
  // SELESAI

  Future<bool> updateBiodataWhereUid(
    int age,
    String jenisKelamin,
    String diagnosisPenyakit,
    String alamat,
    String kontakPasien,
    String kontakKeluarga,
  ) async {
    try {
      var db = FirebaseFirestore.instance;
      final user =
          db.collection('users').doc(FirebaseAuth.instance.currentUser!.uid);
      user.update({
        "age": age,
        "jenisKelamin": jenisKelamin,
        "diagnosisPenyakit": diagnosisPenyakit,
        "alamat": alamat,
        "kotakPasien": kontakPasien,
        "kontakKeluarga": kontakKeluarga,
        'updateAt': Timestamp.now(),
      }).then(
        (value) => debugPrint('DocumentSnapshot successfully updated!'),
        onError: (e) => debugPrint('Error updating document $e'),
      );

      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> updateSudahMinumObat(String randomUid, bool sudahMinum) async {
    try {
      var db = FirebaseFirestore.instance;

      QuerySnapshot query = await db
          .collection('medicine')
          .where('randomUid', isEqualTo: randomUid)
          .get();

      if (query.docs.isNotEmpty) {
        String docId = query.docs[0].id;

        await db.collection('medicine').doc(docId).update({
          "sudahMinum": sudahMinum,
        }).then(
          (value) =>
              (value) => debugPrint('DocuemtnSnapshot successfully updated!'),
          onError: (e) => debugPrint("Error updating document $e"),
        );
      }

      return true;
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  // create new med
  createdNewMedicine(
      String namaObat, String dosisObat, String kegunaanObat) async {
    try {
      var db = FirebaseFirestore.instance;

      final medicine = {
        "medId": const Uuid().v4().toString(),
        "namaObat": namaObat,
        "dosisObat": dosisObat,
        "kegunaanObat": kegunaanObat,
      };

      db
          .collection('obat')
          .doc()
          .set(medicine)
          .onError((error, _) => debugPrint('Error writing document: $error'));
    } catch (e) {
      throw Exception('error $e');
    }
  }

  // fetch data obat
  Future<List<ModelObat>> fetchDataObat() async {
    try {
      List<ModelObat> temporary = [];
      final references = FirebaseFirestore.instance.collection('obat');
      QuerySnapshot querySnapshot = await references.get();
      List<DocumentSnapshot> medicine = querySnapshot.docs;
      for (var element in medicine) {
        var json = element.data() as Map<String, dynamic>;
        temporary.add(ModelObat.fromJson(json));
      }
      return temporary;
    } catch (e) {
      throw Exception('Error $e');
    }
  }
}
