import 'package:get/get.dart';
import 'package:project_reminder_medicine/pages/emergency/emergency_call.dart';
import 'package:project_reminder_medicine/pages/home/ui/doctor_home.dart';
import 'package:project_reminder_medicine/pages/home/ui/home.dart';
import 'package:project_reminder_medicine/pages/medicine/add_medicine.dart';
import 'package:project_reminder_medicine/pages/medicine/obat_pasien.dart';
import 'package:project_reminder_medicine/pages/medicine/medicine.dart';
import 'package:project_reminder_medicine/pages/mood/mood.dart';
import 'package:project_reminder_medicine/pages/pasien/pasien.dart';
import 'package:project_reminder_medicine/pages/question/ui/question.dart';
import 'package:project_reminder_medicine/pages/register/ui/detail_information.dart';
import 'package:project_reminder_medicine/pages/register/ui/register.dart';
import 'package:project_reminder_medicine/pages/splash/splash.dart';

import '../routes/routes_name.dart';
import '../pages/login/ui/login.dart';

class Routes {
  static final route = [
    GetPage(name: RouteName.login, page: () => LoginPage()),
    GetPage(name: RouteName.home, page: () => const HomePage()),
    GetPage(name: RouteName.register, page: () => const RegisterPage()),
    GetPage(name: RouteName.question, page: () => const QuestionPage()),
    GetPage(name: RouteName.medicine, page: () => const MedicinePage()),
    GetPage(name: RouteName.addMedicine, page: () => const AddMedicinePage()),
    GetPage(name: RouteName.doctorPage, page: () => DoctorPage()),
    GetPage(name: RouteName.pasien, page: () => const PasienPage()),
    GetPage(name: RouteName.moodTracker, page: () => const MoodPage()),
    GetPage(name: RouteName.tambahObat, page: () => TambahObat()),
    GetPage(name: RouteName.emergency, page: () => EmergencyCallPage()),
    GetPage(name: RouteName.splash, page: () => const SplashScreenPage()),
    GetPage(
        name: RouteName.detailInformation, page: () => DetailInformationPage()),
  ];
}
