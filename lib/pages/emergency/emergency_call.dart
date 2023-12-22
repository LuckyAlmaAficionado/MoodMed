import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_reminder_medicine/controller/medicine_controller.dart';

// ignore: must_be_immutable
class EmergencyCallPage extends StatelessWidget {
  EmergencyCallPage({super.key});

  var medC = Get.put(MedicineController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.fill,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const Gap(20),
                SizedBox(
                  width: double.maxFinite,
                  child: Text(
                    'Data Rumah Sakit'.toUpperCase(),
                    style: GoogleFonts.akatab(
                        fontWeight: FontWeight.bold, fontSize: 30),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Gap(20),
                DataTable(
                  dataRowColor: MaterialStateProperty.all(Colors.white),
                  headingRowColor:
                      MaterialStateProperty.all(Colors.grey.shade300),
                  border: TableBorder.all(width: 1, color: Colors.black),
                  headingRowHeight: 40,
                  columnSpacing: 30.0,
                  columns: [
                    DataColumn(
                        label: Text(
                      'Rumah Sakit',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    )),
                    DataColumn(
                        label: Text(
                      'Alamat',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    )),
                    DataColumn(
                        label: Text(
                      'Telpon',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    )),
                  ],
                  rows: List.generate(
                    medC.listRumahSakit.length,
                    (index) => DataRow(cells: [
                      DataCell(GestureDetector(
                        onTap: () {
                          medC.listRumahSakit[index]['maps_link'];
                        },
                        child: Text(
                          medC.listRumahSakit[index]['nama']!,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                          ),
                        ),
                      )),
                      DataCell(Text(
                        medC.listRumahSakit[index]['alamat']!,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                        ),
                      )),
                      DataCell(Text(
                        medC.listRumahSakit[index]['telepon']!,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                        ),
                      )),
                    ]),
                  ),
                ),
                const Gap(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
