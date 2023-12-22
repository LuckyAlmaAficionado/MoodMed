import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_reminder_medicine/controller/authentication_controller.dart';
import 'package:project_reminder_medicine/routes/routes_name.dart';
import 'package:project_reminder_medicine/widgets/custom_textfield_login.dart';

import '../../../widgets/custom_snackbar.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  // deklarasi GetX
  var authController = Get.put(AuthFirebase());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    emailC.dispose();
    passC.dispose();
  }

  int backButton = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        debugPrint(backButton.toString());
        if (backButton < 1) {
          Get.snackbar('', '',
              titleText: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: const DecorationImage(
                            image: AssetImage('assets/images/logo.png'))),
                    width: 30,
                    height: 30,
                  ),
                  const Gap(5),
                  Text(
                    'Tekan sekali lagi untuk keluar aplikasi',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
              margin: const EdgeInsets.all(10));
          backButton++;
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: Get.width,
          height: Get.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background_home.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
                const Gap(30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Welcome\nBack',
                    style: GoogleFonts.notoSans(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 50,
                    ),
                  ),
                ),
                const Gap(70),
                CTextField(
                  label: 'Email',
                  controller: emailC,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.emailAddress,
                ),
                const Gap(20),
                CTextField(
                  label: 'Password',
                  controller: passC,
                  obsecureText: true,
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.multiline,
                ),
                const Gap(50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sign in',
                        style: GoogleFonts.notoSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(100),
                        color: const Color.fromARGB(255, 54, 124, 254),
                        child: InkWell(
                          onTap: () async {
                            if (emailC.text == 'psikiater@gmail.com' &&
                                passC.text == 'psikiaterIndonesia') {
                              Get.offAllNamed(RouteName.doctorPage);
                            } else {
                              authController
                                  .signInUserWithEmailAndPassword(
                                      emailC.text, passC.text)
                                  .then((value) async {
                                if (value) {
                                  SnackbarC.successSnackbar('Berhasil Login!',
                                      'Selama datang kembali..!');
                                  await Future.delayed(
                                      const Duration(seconds: 2));
                                  Get.offAllNamed(RouteName.home);
                                } else {
                                  SnackbarC.failedSnackbar('Gagal Login!',
                                      'Tidak berhasil login..!');
                                }
                              });
                            }
                          },
                          splashColor: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          child: const Padding(
                            padding: EdgeInsets.all(20),
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(90),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteName.register);
                        },
                        child: Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              offset: const Offset(4, 8),
                              spreadRadius: 0.1,
                              blurRadius: 10,
                              color: const Color.fromARGB(255, 11, 126, 232)
                                  .withOpacity(0.5),
                            )
                          ]),
                          child: Text(
                            'Sign Up',
                            style: GoogleFonts.notoSans(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              offset: const Offset(4, 8),
                              spreadRadius: 0.1,
                              blurRadius: 10,
                              color: const Color.fromARGB(255, 255, 0, 0)
                                  .withOpacity(0.5),
                            )
                          ]),
                          child: Text(
                            'Forgot Password',
                            style: GoogleFonts.notoSans(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    // return WillPopScope(
    //   onWillPop: () async {
    //     debugPrint(backButton.toString());
    //     if (backButton < 1) {
    //       Get.snackbar('', '',
    //           titleText: Row(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Container(
    //                 decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(100),
    //                     image: const DecorationImage(
    //                         image: AssetImage('assets/images/logo.png'))),
    //                 width: 30,
    //                 height: 30,
    //               ),
    //               const Gap(5),
    //               Text(
    //                 'Tekan sekali lagi untuk keluar aplikasi',
    //                 textAlign: TextAlign.center,
    //                 style: GoogleFonts.poppins(
    //                   fontWeight: FontWeight.w500,
    //                   color: Colors.blue,
    //                 ),
    //               ),
    //             ],
    //           ),
    //           backgroundColor: Colors.white,
    //           snackPosition: SnackPosition.BOTTOM,
    //           margin: const EdgeInsets.all(10));
    //       backButton++;
    //       return false;
    //     } else {
    //       return true;
    //     }
    //   },
    //   child: Scaffold(
    //     body: Stack(
    //       children: [
    //         Image.asset(
    //           'assets/images/background.png',
    //           width: double.maxFinite,
    //           height: double.maxFinite,
    //           fit: BoxFit.fill,
    //         ),
    //         SingleChildScrollView(
    //           scrollDirection: Axis.vertical,
    //           child: Column(
    //             children: [
    //               SizedBox(height: MediaQuery.of(context).size.height * 0.2),
    //               Container(
    //                 height: 100,
    //                 width: 100,
    //                 decoration: const BoxDecoration(
    //                   borderRadius: BorderRadius.all(
    //                     Radius.circular(100),
    //                   ),
    //                   image: DecorationImage(
    //                     image: AssetImage('assets/images/logo.png'),
    //                   ),
    //                 ),
    //               ),
    //               const Gap(20),
    //               Text(
    //                 'MOODMED',
    //                 style: GoogleFonts.poppins(
    //                   fontSize: 25,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //               ),
    //               Text(
    //                 'Mood & Medicine',
    //                 style: GoogleFonts.poppins(
    //                   fontSize: 15,
    //                   fontWeight: FontWeight.normal,
    //                 ),
    //               ),
    //               const SizedBox(height: 30),
    //               TextFieldC(
    //                 textInputAction: TextInputAction.next,
    //                 textInputType: TextInputType.emailAddress,
    //                 controller: emailC,
    //                 obsecureText: false,
    //                 hintText: 'Email',
    //               ),
    //               const SizedBox(height: 20),
    //               TextFieldC(
    //                 textInputAction: TextInputAction.done,
    //                 controller: passC,
    //                 obsecureText: true,
    //                 hintText: 'Password',
    //               ),
    //               const SizedBox(height: 30),
    //               ButtonC(
    //                 textButton: 'MASUK',
    //                 onTap: () async {
    //                   if (emailC.text == 'psikiater@gmail.com' &&
    //                       passC.text == 'psikiaterIndonesia') {
    //                     Get.offAllNamed(RouteName.doctorPage);
    //                   } else {
    //                     // user login
    //                     authController
    //                         .signInUserWithEmailAndPassword(
    //                             emailC.text, passC.text)
    //                         .then((value) async {
    //                       if (value) {
    //                         SnackbarC.successSnackbar('Success',
    //                             'successful login waiting for the moments');
    //                         await Future.delayed(const Duration(seconds: 2));
    //                         Get.offAllNamed(RouteName.home);
    //                       } else {
    //                         SnackbarC.failedSnackbar('Wrong password',
    //                             'Wrong password provided for that user.');
    //                       }
    //                     });
    //                   }
    //                 },
    //               ),
    //               const SizedBox(height: 20),
    //               Row(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Text(
    //                     "Don't have an account? ",
    //                     style: GoogleFonts.poppins(
    //                       color: Colors.black,
    //                     ),
    //                   ),
    //                   GestureDetector(
    //                     onTap: () {
    //                       Get.toNamed(RouteName.register);
    //                     },
    //                     child: Text(
    //                       'SignUp',
    //                       style: GoogleFonts.poppins(
    //                         color: Colors.blueAccent,
    //                       ),
    //                     ),
    //                   )
    //                 ],
    //               )
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
