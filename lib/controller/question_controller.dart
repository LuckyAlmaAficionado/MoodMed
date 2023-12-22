import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionController extends GetxController {
  // List Color Day
  List<Map<dynamic, dynamic>> colorDay = [
    {"Sangat Senang": const Color.fromARGB(255, 37, 113, 188)}, // sangat senang
    {"Senang": const Color.fromARGB(255, 142, 202, 230)}, // senang
    {"Normal": const Color.fromARGB(255, 255, 183, 3)}, // normal
    {"Sedih": const Color.fromARGB(255, 234, 119, 0)}, // sedih
    {"Sangat Sedih": const Color.fromARGB(255, 209, 70, 11)}, // sangat sedih
  ].obs;

  // List Feeling
  List<Map<dynamic, String>> feeling = [
    {Colors.green: 'Energized'},
    {Colors.green: 'Excited'},
    {Colors.green: 'Happy'},
    {Colors.green: 'Hopeful'},
    {Colors.green: 'Inspired'},
    {Colors.green: 'Proud'},
    {Colors.green: 'Balance'},
    {Colors.green: 'Calm'},
    {Colors.green: 'Satisfied'},
    {Colors.green: 'Grateful'},
    {Colors.green: 'Loved'},
    {Colors.green: 'Relieved'},
    {Colors.green: 'Unmotivated'},
    {Colors.green: 'Suprised'},
    {Colors.grey: 'Confused'},
    {Colors.grey: 'Overwhelmed'},
    {Colors.grey: 'Bored'},
    {Colors.grey: 'Tired'},
  ].obs;

  // List Tags
  List<Map<dynamic, String>> tags = [
    {Colors.grey: 'Familiy'},
    {Colors.orange: 'Friends'},
    {Colors.red: 'Love'},
    {Colors.blue: 'Sport'},
    {Colors.green: 'Relax'},
    {Colors.purple: 'Reading'},
    {Colors.deepPurple: 'Cleaning'},
    {Colors.amber: 'Sleep early'},
    {Colors.greenAccent: 'Eat Helthy'},
    {Colors.orange: 'Shopping'},
    {Colors.green: 'Gaming'},
    {Colors.greenAccent: 'Watching TV'},
    {Colors.blueAccent: 'Mindfulness'},
    {Colors.green: 'Nature'},
    {Colors.green: 'Creativity'},
    {Colors.blue: 'Social Media'},
    {Colors.red: 'Work'},
    {Colors.green: 'Travel'},
  ].obs;
}
