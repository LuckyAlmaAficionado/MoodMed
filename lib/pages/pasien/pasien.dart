import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_reminder_medicine/controller/firestore_controller.dart';

import '../../models/medicion_model.dart';
import '../../models/user_model.dart';

// ignore: must_be_immutable
class PasienPage extends StatefulWidget {
  const PasienPage({super.key});

  @override
  State<PasienPage> createState() => _PasienPageState();
}

class _PasienPageState extends State<PasienPage> {
  var fireC = Get.put(FirestoreFirebase());

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
            SizedBox(
              width: double.maxFinite,
              child: Text(
                'Data Pasien Minum Obat'.toUpperCase(),
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
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
                        style: GoogleFonts.poppins(),
                      ),
                      items: List.generate(users.length, (index) {
                        UserModel user = users[index];

                        return DropdownMenuItem(
                          value: {user.username: user.uuid},
                          child: Text(user.username),
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
              'Note: obat yang sudah diminum akan ada centang pada checkbox',
              style: GoogleFonts.poppins(
                color: Colors.blue,
              ),
              textAlign: TextAlign.justify,
            ),
            const Gap(20),
            Expanded(
              child: FutureBuilder(
                future: fireC.fetchMedicineTrackerByUid(uidPasien),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    List<ModelMedicineFirebase> snap = snapshot.data;
                    return ListView.builder(
                      itemCount: snap.length,
                      itemBuilder: (context, index) {
                        ModelMedicineFirebase data = snap[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              image:
                                  AssetImage('assets/images/path_button.png'),
                              fit: BoxFit.fill,
                            ),
                            color: const Color.fromARGB(255, 135, 146, 238),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: ListTile(
                            title: Text(
                              data.namaObat,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Text(
                              data.dosisObat,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            trailing: Checkbox(
                              checkColor: Colors.white,
                              value: data.sudahMinum,
                              onChanged: (value) {},
                            ),
                          ),
                        );
                      },
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
