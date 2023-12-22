import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_reminder_medicine/controller/authentication_controller.dart';
import 'package:project_reminder_medicine/routes/routes_name.dart';
import 'package:project_reminder_medicine/widgets/custom_snackbar.dart';

import '../../../widgets/custom_textfield_login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  var authController = Get.put(AuthFirebase());

  @override
  void dispose() {
    super.dispose();
    usernameC.dispose();
    emailC.dispose();
    passC.dispose();
  }

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
        child: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Gap(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Create\nAccount',
                    style: GoogleFonts.notoSans(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 50,
                    ),
                  ),
                ),
                const Gap(50),
                CTextField(
                  label: 'Username',
                  controller: usernameC,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
                const Gap(20),
                CTextField(
                  label: 'Email',
                  controller: emailC,
                  obsecureText: false,
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
                const Gap(40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sign up',
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
                            // TODO: Create new Account
                            authController
                                .signUpWithEmailAndPassword(
                                    usernameC.text, emailC.text, passC.text)
                                .then((value) async {
                              if (value) {
                                SnackbarC.successSnackbar(
                                    'Berhasil..!', 'Berhasil membuat akun..!');
                                await Future.delayed(
                                    const Duration(seconds: 2));
                                Get.offNamed(RouteName.detailInformation);
                              } else {
                                SnackbarC.failedSnackbar(
                                    'Gagal..!', "Gagal membuat akun..!");
                              }
                            });
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
                const Gap(50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteName.login);
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
                            'Sign In',
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
    // return Scaffold(
    //   body: Stack(
    //     children: [
    //       Image.asset(
    //         'assets/images/background.png',
    //         width: double.maxFinite,
    //         height: double.maxFinite,
    //         fit: BoxFit.fill,
    //       ),
    //       SingleChildScrollView(
    //         scrollDirection: Axis.vertical,
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             SizedBox(height: MediaQuery.of(context).size.height * 0.15),
    //             SizedBox(
    //               width: double.maxFinite,
    //               child: Column(
    //                 children: [
    //                   Container(
    //                     height: 100,
    //                     width: 100,
    //                     decoration: const BoxDecoration(
    //                       borderRadius: BorderRadius.all(
    //                         Radius.circular(100),
    //                       ),
    //                       image: DecorationImage(
    //                         image: AssetImage('assets/images/logo.png'),
    //                       ),
    //                     ),
    //                   ),
    //                   Text(
    //                     'REGISTER',
    //                     style: GoogleFonts.poppins(
    //                       fontSize: 20,
    //                       fontWeight: FontWeight.bold,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //             const SizedBox(height: 30),
    //             TextFieldC(
    //               textInputType: TextInputType.emailAddress,
    //               textInputAction: TextInputAction.next,
    //               controller: usernameC,
    //               obsecureText: false,
    //               hintText: 'Username',
    //             ),
    //             const SizedBox(height: 20),
    //             TextFieldC(
    //               textInputAction: TextInputAction.next,
    //               controller: emailC,
    //               obsecureText: false,
    //               hintText: 'Email',
    //               textInputType: TextInputType.emailAddress,
    //             ),
    //             const SizedBox(height: 20),
    //             TextFieldC(
    //               textInputAction: TextInputAction.done,
    //               controller: passC,
    //               obsecureText: true,
    //               hintText: 'Password',
    //             ),
    //             const SizedBox(height: 30),
    //             ButtonC(
    //               textButton: 'SignUp',
    //               onTap: () {
    //                 // create new account
    //                 authController
    //                     .signUpWithEmailAndPassword(
    //                   usernameC.text,
    //                   emailC.text,
    //                   passC.text,
    //                 )
    //                     .then((value) async {
    //                   if (value) {
    //                     SnackbarC.successSnackbar(
    //                       'Success..!',
    //                       'successfully created an account',
    //                     );
    //                     await Future.delayed(const Duration(seconds: 2));
    //                     Get.offNamed(RouteName.detailInformation);
    //                   } else {
    //                     SnackbarC.failedSnackbar(
    //                       'Failed..!',
    //                       'failed created an account',
    //                     );
    //                   }
    //                 });
    //               },
    //             ),
    //             const Gap(20),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 Text(
    //                   "Already have an account? ",
    //                   style: GoogleFonts.poppins(
    //                     color: Colors.black,
    //                   ),
    //                 ),
    //                 GestureDetector(
    //                   onTap: () {
    //                     Get.offNamed(RouteName.login);
    //                   },
    //                   child: Text(
    //                     'SignIn',
    //                     style: GoogleFonts.poppins(
    //                       color: Colors.blueAccent,
    //                     ),
    //                   ),
    //                 )
    //               ],
    //             )
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
