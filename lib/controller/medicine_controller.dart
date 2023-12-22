import 'package:get/get.dart';
import 'package:project_reminder_medicine/models/medicion_model.dart';

class MedicineController extends GetxController {
  List<Map<String, String>> listRumahSakit = [
    {
      'nama': 'RSUD Tugurejo',
      'alamat': 'Jl. Majapahit No.140',
      'telepon': '(024) 6720947',
      'maps_link': 'https://www.google.com/maps?q=RSUD+Tugurejo+Semarang'
    },
    {
      'nama': 'Rumah Sakit Columbia Asia',
      'alamat': 'Jl. Jenderal Ahmad Yani No. 70-72',
      'telepon': '(024) 33001888',
      'maps_link':
          'https://www.google.com/maps?q=Rumah+Sakit+Columbia+Asia+Semarang'
    },
    {
      'nama': 'RS Elizabeth',
      'alamat': 'Jl. Kaliwaru No. 44',
      'telepon': '(024) 3580200',
      'maps_link': 'https://www.google.com/maps?q=RS+Elizabeth+Semarang'
    },
    {
      'nama': 'RS Telogorejo',
      'alamat': 'Jl. Siliwangi No. 148',
      'telepon': '(024) 86558677',
      'maps_link': 'https://www.google.com/maps?q=RS+Telogorejo+Semarang'
    },
    {
      'nama': 'RSIA YPK Mandiri',
      'alamat': 'Jl. Raya Tugu No. 54',
      'telepon': '(024) 86621777',
      'maps_link': 'https://www.google.com/maps?q=RSIA+YPK+Mandiri+Semarang'
    },
    {
      'nama': 'RSU St. Elisabeth',
      'alamat': 'Jl. Taman Semarang Baru No.1',
      'telepon': '(024) 8412723',
      'maps_link': 'https://www.google.com/maps?q=RSU+St.+Elisabeth+Semarang'
    },
    {
      'nama': 'RS Kariadi',
      'alamat': 'Jl. Dr. Cipto No. 31',
      'telepon': '(024) 3541010',
      'maps_link': 'https://www.google.com/maps?q=RS+Kariadi+Semarang'
    },
    {
      'nama': 'RS Hermina',
      'alamat': 'Jl. Kawi No. 1',
      'telepon': '(024) 3555000',
      'maps_link': 'https://www.google.com/maps?q=RS+Hermina+Semarang'
    },
    {
      'nama': 'RS Panti Rahayu',
      'alamat': 'Jl. Singosari Raya No. 5',
      'telepon': '(024) 86614766',
      'maps_link': 'https://www.google.com/maps?q=RS+Panti+Rahayu+Semarang'
    },
    {
      'nama': 'RS Baptis Kedungmundu',
      'alamat': 'Jl. Kedungmundu Raya No. 13',
      'telepon': '(024) 6718251',
      'maps_link':
          'https://www.google.com/maps?q=RS+Baptis+Kedungmundu+Semarang'
    },
  ];

  List<ModelMedicine> medicine = [
    ModelMedicine(
      namaObat: 'Antiprestin',
      dosisObat: '20 mg kapsul',
      waktuPenggunaan: ["08:00"],
      kegunaaan:
          'bisa meningkatkan mood, merangsang selera makan, membuat tubuh lebih berenergi, dan memperbaiki gairah hidup Anda. Obat ini juga membantu mengurangi prasangka buruk, meredakan rasa takut, dan mengatasi kecemasan',
    ),
    ModelMedicine(
      namaObat: 'Stablon',
      dosisObat: '12,5 mg Tablet',
      waktuPenggunaan: [
        "08:00",
        "12:00",
        "19:00",
      ],
      kegunaaan:
          'kegunaan untuk memperbaiki suasana hati orang yang mengalami depresi',
    ),
  ];
}
