import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_reminder_medicine/controller/firestore_controller.dart';

import '../../models/user_model.dart';

// ignore: must_be_immutable
class MoodPage extends StatefulWidget {
  const MoodPage({super.key});

  @override
  State<MoodPage> createState() => _MoodPageState();
}

class _MoodPageState extends State<MoodPage> {
  var fireC = Get.find<FirestoreFirebase>();

  String namaPasien = 'Nama pasien';
  String uidPasien = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.fill,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(20),
            SizedBox(
              width: double.maxFinite,
              child: Text(
                'INFORMASI MOOD PASIEN'.toUpperCase(),
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
              ),
            ),
            const Gap(20),
            Text(
              'Nama pasien',
              style: GoogleFonts.poppins(),
            ),
            FutureBuilder(
              future: fireC.extractUsers(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.data == null) {
                  return Container();
                } else {
                  List<UserModel> users = snapshot.data as List<UserModel>;

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    width: double.maxFinite,
                    child: DropdownButton(
                      underline: Container(),
                      isExpanded: true,
                      hint: Text(
                        namaPasien,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      items: List.generate(users.length, (index) {
                        UserModel user = users[index];

                        return DropdownMenuItem(
                          value: {user.username: user.uuid},
                          child: Text(
                            user.username,
                          ),
                        );
                      }),
                      onChanged: (value) {
                        setState(() {
                          namaPasien = value!.keys.first;
                          uidPasien = value.values.first;
                        });
                      },
                    ),
                  );
                }
              },
            ),
            const Gap(10),
            Text(
              'Note: data dibawah adalah bagaimana mood pasien berdasarkan mingguan',
              style: GoogleFonts.poppins(
                color: Colors.blue,
              ),
              textAlign: TextAlign.justify,
            ),
            Expanded(
              child: FutureBuilder(
                future: fireC.conclusionSevenDays(uidPasien),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    List snap = snapshot.data;
                    return ListView.builder(
                      itemCount: snap.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: (snap[index] == 'Netral')
                                  ? Colors.lightGreen
                                  : Colors.redAccent,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1,
                                color: Colors.grey,
                              )),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: Column(children: [
                            SizedBox(
                              width: double.maxFinite,
                              child: Text(
                                'Date: Minggu ${index + 1}',
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            const Gap(10),
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/${(snap[index] == 'Sedih') ? "sad.png" : "smile.png"}'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            const Gap(10),
                            SizedBox(
                              width: double.maxFinite,
                              child: Text(
                                (snap[index] == 'Netral') ? "SENANG" : "SEDIH",
                                style: GoogleFonts.robotoFlex(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ]),
                        ),
                      ),
                    );
                  } else {
                    return const Text('dont have any data');
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
