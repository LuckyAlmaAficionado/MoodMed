import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_reminder_medicine/controller/firestore_controller.dart';
import 'package:project_reminder_medicine/controller/medicine_controller.dart';
import 'package:project_reminder_medicine/models/medicion_model.dart';
import 'package:project_reminder_medicine/models/user_model.dart';
import 'package:project_reminder_medicine/routes/routes_name.dart';
import 'package:project_reminder_medicine/widgets/custom_snackbar.dart';

class AddMedicinePage extends StatefulWidget {
  const AddMedicinePage({super.key});

  @override
  State<AddMedicinePage> createState() => _AddMedicinePageState();
}

// User
String namaPasien = 'Masukan nama pasien';
String? uidPasien;

// Medicine
String namaObat = 'Nama obat';
String dosis = 'Berapa kali sehari';
TimeOfDay time = TimeOfDay.now();

// waktu minum
List<String>? jamMinum;

var fireC = Get.find<FirestoreFirebase>();
var medC = Get.put(MedicineController());
TextEditingController timeOfDayC = TextEditingController();

TimeOfDay selectedTime = TimeOfDay.now();
TextEditingController timeC = TextEditingController();

class _AddMedicinePageState extends State<AddMedicinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(Get.height * 0.15),
                SizedBox(
                  width: double.maxFinite,
                  child: Text(
                    'Tambahkan data obat untuk pasien'.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                const Gap(20),
                Text(
                  'Nama Pasien',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                  ),
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
                Text(
                  'Nama Obat',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                  ),
                ),
                FutureBuilder(
                  future: fireC.fetchDataObat(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    } else if (!snapshot.hasData) {
                      return const Center(
                        child: Text('NO DATA AVAILABEL'),
                      );
                    } else {
                      List<ModelObat> data = snapshot.data as List<ModelObat>;

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
                            namaObat,
                            style: GoogleFonts.poppins(),
                          ),
                          items: List.generate(data.length, (index) {
                            ModelObat med = data[index];

                            return DropdownMenuItem(
                              onTap: () {
                                namaObat = med.namaObat;
                                dosis = med.dosisObat;
                              },
                              value: med, // di ganti const di hilangkan
                              child: Text(med.namaObat),
                            );
                          }),
                          onChanged: (value) {
                            setState(() {
                              namaObat = value!.namaObat;
                              dosis = value.dosisObat;
                            });
                          },
                        ),
                      );
                    }
                  },
                ),
                Text(
                  'Jam Minum Obat',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                  ),
                ),
                const Gap(10),
                TextField(
                  autocorrect: false,
                  enabled: true,
                  controller: timeOfDayC,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        ).then((value) {
                          setState(() {
                            time = value!;
                            timeOfDayC.text = '${value.hour}:${value.minute}';
                          });
                        });
                      },
                      icon: const Icon(Icons.timer_outlined),
                    ),
                    hintText: 'Jam Minum Obat',
                    hintStyle: GoogleFonts.poppins(),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                  ),
                ),
                const Gap(30),
                SizedBox(
                  width: double.maxFinite,
                  height: 50,
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.deepOrange,
                    child: InkWell(
                      onTap: () async {
                        Get.find<FirestoreFirebase>().createANewMedicine(
                            uidPasien!, namaObat, dosis, [timeOfDayC.text]);
                        SnackbarC.successSnackbar(
                            'Success', 'berhasil menambahkan obat ke pasien');
                        await Future.delayed(const Duration(seconds: 2));
                        Get.toNamed(RouteName.doctorPage);
                      },
                      child: Center(
                        child: Text(
                          'SUBMIT',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
