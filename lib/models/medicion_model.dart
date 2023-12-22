class ModelMedicine {
  final String namaObat;
  final String dosisObat;
  final List<String> waktuPenggunaan;
  final String kegunaaan;

  ModelMedicine({
    required this.namaObat,
    required this.dosisObat,
    required this.waktuPenggunaan,
    required this.kegunaaan,
  });
}

class ModelMedicineFirebase {
  final String randomUid;
  final String pasienUid;
  final String namaObat;
  final String dosisObat;
  final List<dynamic> waktuPenggunaan;
  late bool sudahMinum;

  ModelMedicineFirebase({
    required this.randomUid,
    required this.pasienUid,
    required this.namaObat,
    required this.dosisObat,
    required this.waktuPenggunaan,
    required this.sudahMinum,
  });

  factory ModelMedicineFirebase.fromJson(Map<String, dynamic> json) =>
      ModelMedicineFirebase(
        randomUid: json["randomUid"],
        namaObat: json["namaObat"],
        dosisObat: json["dosisObat"],
        sudahMinum: json["sudahMinum"],
        waktuPenggunaan: json["waktuObat"],
        pasienUid: json["pasienUid"],
      );
}

class ModelObat {
  final String uuid;
  final String namaObat;
  final String dosisObat;
  final String kegunaan;

  ModelObat(
      {required this.uuid,
      required this.namaObat,
      required this.dosisObat,
      required this.kegunaan});

  factory ModelObat.fromJson(Map<String, dynamic> json) => ModelObat(
        uuid: json["medId"],
        namaObat: json["namaObat"],
        dosisObat: json["dosisObat"],
        kegunaan: json["kegunaanObat"],
      );
}
