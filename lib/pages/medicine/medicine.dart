import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_reminder_medicine/controller/firestore_controller.dart';
import 'package:project_reminder_medicine/widgets/custom_button.dart';
import 'package:project_reminder_medicine/widgets/custom_snackbar.dart';

import '../../controller/notification_controller.dart';
import '../../models/medicion_model.dart';

class MedicinePage extends StatefulWidget {
  const MedicinePage({super.key});

  @override
  State<MedicinePage> createState() => _MedicinePageState();
}

class _MedicinePageState extends State<MedicinePage> {
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
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(40),
                    Text(
                      'Jangan lupa minum obat ya...!',
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                    const Gap(10),
                    Text(
                      '${FirebaseAuth.instance.currentUser!.displayName}',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    const Gap(20),
                    Text(
                      'Obat yang kamu perlukan',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: Get.put(FirestoreFirebase())
                      .fetchMedicineTrackerByUid(
                          FirebaseAuth.instance.currentUser!.uid),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<ModelMedicineFirebase> snap = snapshot.data;
                      return ListView.builder(
                        padding: const EdgeInsets.all(10),
                        itemBuilder: (context, index) {
                          ModelMedicineFirebase data = snap[index];
                          return Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                width: 1,
                                color: Colors.grey,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        int notif = 0;
                                        for (String waktu
                                            in data.waktuPenggunaan) {
                                          int hour = int.parse(waktu
                                              .toString()
                                              .split(':')
                                              .first);
                                          int minute = int.parse(
                                              waktu.toString().split(':').last);
                                          setNotification(hour, minute);

                                          notif++;
                                        }
                                        SnackbarC.successSnackbar(
                                            'Set Notifikasi',
                                            '$notif Notifikasi diaktifkan..!');
                                        await Future.delayed(
                                            const Duration(seconds: 2));
                                      },
                                      icon: const Icon(
                                        Icons.notifications_active,
                                        color: Colors.orange,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data.namaObat,
                                          style: GoogleFonts.poppins(
                                            fontSize: 17,
                                          ),
                                        ),
                                        Text(
                                          data.dosisObat,
                                          style: GoogleFonts.poppins(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Checkbox(
                                    value: data.sudahMinum,
                                    onChanged: (value) {
                                      data.sudahMinum = !data.sudahMinum;
                                      Get.find<FirestoreFirebase>()
                                          .updateSudahMinumObat(
                                        data.randomUid,
                                        data.sudahMinum,
                                      )
                                          .then((value) {
                                        setState(() {});
                                      });
                                    }),
                              ],
                            ),
                          );
                        },
                        itemCount: snap.length,
                      );
                    }
                    return Container();
                  },
                ),
              ),
              ButtonC(
                textButton: 'SET OFF NOTIFICATION',
                onTap: () {
                  NotificationController().cancellingAllNotifications().then(
                        (value) => SnackbarC.successSnackbar(
                          'Notifikasi Berhenti',
                          'Semua notifikasi dihentikan',
                        ),
                      );
                },
              ),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }

  setNotification(int hour, int minute) {
    debugPrint('notifikasi di set');
    NotificationController().scheduleNotification(
      title: 'Minum obat..!!',
      body: 'Jangan lupa minum obat hari ini',
      reminder: TimeOfDay(hour: hour, minute: minute),
    );
  }
}
