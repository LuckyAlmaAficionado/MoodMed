import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_reminder_medicine/controller/firestore_controller.dart';
import 'package:project_reminder_medicine/routes/routes_name.dart';
import 'package:project_reminder_medicine/widgets/custom_button.dart';
import 'package:project_reminder_medicine/widgets/custom_snackbar.dart';
import 'package:project_reminder_medicine/widgets/custom_textfield.dart';

// ignore: must_be_immutable
class DetailInformationPage extends StatefulWidget {
  const DetailInformationPage({super.key});

  @override
  State<DetailInformationPage> createState() => _DetailInformationPageState();
}

enum Gender { laki, perempuan }

class _DetailInformationPageState extends State<DetailInformationPage> {
  TextEditingController umurC = TextEditingController();
  TextEditingController penyakitC = TextEditingController();
  TextEditingController alamatC = TextEditingController();
  Gender? genderC;
  TextEditingController kPasienC = TextEditingController();
  TextEditingController kKPasienC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_register.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(60),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Input data diri pasien'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.notoSans(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const Gap(25),
              TextFieldC(
                controller: umurC,
                obsecureText: false,
                hintText: 'Umur',
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.number,
              ),
              const Gap(15),
              TextFieldC(
                controller: penyakitC,
                obsecureText: false,
                hintText: 'Diagnosis Penyakit',
                textInputAction: TextInputAction.next,
              ),
              const Gap(15),
              TextFieldC(
                controller: alamatC,
                obsecureText: false,
                hintText: 'Alamat',
                textInputAction: TextInputAction.next,
              ),
              const Gap(15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jenis Kelamin :',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'laki-laki',
                        style: GoogleFonts.poppins(),
                      ),
                      leading: Radio<Gender>(
                        value: Gender.laki,
                        groupValue: genderC,
                        onChanged: (value) {
                          setState(() {
                            genderC = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'perempuan',
                        style: GoogleFonts.poppins(),
                      ),
                      leading: Radio<Gender>(
                        value: Gender.perempuan,
                        groupValue: genderC,
                        onChanged: (value) {
                          setState(() {
                            genderC = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              TextFieldC(
                controller: kPasienC,
                obsecureText: false,
                hintText: 'Kontak Pasien',
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.phone,
              ),
              const Gap(15),
              TextFieldC(
                controller: kKPasienC,
                obsecureText: false,
                hintText: 'Kontak Keluarga Pasien',
                textInputAction: TextInputAction.done,
                textInputType: TextInputType.phone,
              ),
              const Gap(25),
              ButtonC(
                textButton: 'INPUT DATA DIRI',
                onTap: () {
                  Get.put(FirestoreFirebase())
                      .updateBiodataWhereUid(
                    int.parse(umurC.text),
                    genderC.toString(),
                    penyakitC.text,
                    alamatC.text,
                    kPasienC.text,
                    kKPasienC.text,
                  )
                      .then((value) async {
                    if (value) {
                      SnackbarC.successSnackbar(
                          'Success', 'behasil update biodata');
                      await Future.delayed(const Duration(seconds: 3));
                      Get.toNamed(RouteName.home);
                    } else {
                      SnackbarC.failedSnackbar(
                          'Failed', 'gagal update biodata');
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
