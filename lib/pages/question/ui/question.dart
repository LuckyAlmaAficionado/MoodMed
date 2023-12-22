import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_reminder_medicine/controller/firestore_controller.dart';
import 'package:project_reminder_medicine/controller/question_controller.dart';
import 'package:project_reminder_medicine/routes/routes_name.dart';
import 'package:project_reminder_medicine/widgets/custom_button.dart';
import 'package:project_reminder_medicine/widgets/custom_snackbar.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

TextEditingController writeDayC = TextEditingController();
TextEditingController badHappenC = TextEditingController();

int current = 0;

final CarouselController carouselController = CarouselController();

int? selectedFell;
int? selectedDay;

String? paramDay;
String? paramFeel;
String? paramTags;

void setDefaultValue() {
  paramDay = '';
  paramFeel = '';
  paramTags = '';
  writeDayC.text = '';
  badHappenC.text = '';
}

var questionC = Get.put(QuestionController());
var fireC = Get.find<FirestoreFirebase>();

class _QuestionPageState extends State<QuestionPage> {
  @override
  void dispose() {
    super.dispose();
    current = 0;
    selectedDay = null;
    selectedFell = null;
  }

  @override
  Widget build(BuildContext context) {
    // supaya bisa reload
    List<Widget> carouselWidget = [
      Container(
        height: double.maxFinite,
        decoration: const BoxDecoration(),
        child: SizedBox(
          height: double.maxFinite,
          width: double.maxFinite,
          child: Column(
            children: [
              const Gap(100),
              Text(
                'How was your day?'.toUpperCase(),
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              Expanded(
                flex: 15,
                child: ListView.builder(
                  itemCount: questionC.colorDay.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      paramDay = questionC.colorDay[index].keys.first;
                      carouselController.nextPage();
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 100,
                        vertical: 20,
                      ),
                      height: 70,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                        color: questionC.colorDay[index].values.first,
                      ),
                      child: Center(
                        child: Text(
                          questionC.colorDay[index].keys.first,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Gap(100),
            Text(
              'How do you feel?'.toUpperCase(),
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            const Gap(10),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 5 / 1.5,
                ),
                itemCount: questionC.feeling.length,
                itemBuilder: (context, index) {
                  var entry = questionC.feeling[index];
                  var color = entry.keys.first;
                  var emotion = entry.values.first;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFell = index;
                        debugPrint(emotion);
                      });
                      paramFeel = emotion;
                      carouselController.nextPage();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: (selectedFell == index) ? 3 : 1,
                          color: (selectedFell == index)
                              ? Colors.blue
                              : Colors.transparent,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 13,
                            width: 13,
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          const Gap(10),
                          Text(
                            emotion,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Gap(100),
            Text(
              'Add tags to your day'.toUpperCase(),
              style: GoogleFonts.robotoFlex(
                fontWeight: FontWeight.w900,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            const Gap(10),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 5 / 1.5,
                ),
                itemCount: questionC.tags.length,
                itemBuilder: (context, index) {
                  var entry = questionC.tags[index];
                  var color = entry.keys.first;
                  var emotion = entry.values.first;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDay = index;
                        debugPrint(emotion);
                      });
                      paramTags = emotion;
                      carouselController.nextPage();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: (selectedDay == index) ? 3 : 1,
                          color: (selectedDay == index)
                              ? Colors.blue
                              : Colors.transparent,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 13,
                            width: 13,
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          const Gap(10),
                          Text(
                            emotion,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          decoration: const BoxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(60),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Write about your day...  😊',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 19,
                        color: Colors.black,
                      ),
                    ),
                    const Gap(20),
                    TextField(
                      controller: writeDayC,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                      maxLines: 8,
                    ),
                    const Gap(20),
                    Text(
                      'Is there anything bad happen today?...',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 19,
                      ),
                    ),
                    const Gap(20),
                    TextField(
                      controller: badHappenC,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                      maxLines: 8,
                    ),
                  ],
                ),
              ),
              ButtonC(
                textButton: 'Done',
                onTap: () {
                  fireC
                      .createNewMoodTracker(
                    paramDay!,
                    paramFeel!,
                    paramTags!,
                    writeDayC.text,
                    badHappenC.text,
                  )
                      .then((value) async {
                    setDefaultValue();
                    SnackbarC.successSnackbar(
                        'Mood Disimpan', 'Terimakasih sudah mengisi');
                    await Future.delayed(const Duration(seconds: 2));
                    Get.offAllNamed(RouteName.home);
                  });
                },
              )
            ],
          ),
        ),
      ),
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background_home.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Stack(
          children: [
            CarouselSlider(
              carouselController: carouselController,
              items: carouselWidget,
              options: CarouselOptions(
                height: double.maxFinite,
                viewportFraction: 1,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    current = index;
                  });
                },
              ),
            ),
            Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: carouselWidget.asMap().entries.map((e) {
                  return Container(
                    height: 5,
                    padding: const EdgeInsets.all(10),
                    width: (MediaQuery.of(context).size.width /
                            carouselWidget.length) -
                        20,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black87)
                          .withOpacity(current == e.key ? 0.8 : 0.2),
                    ),
                    child: Text(current.toString()),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
