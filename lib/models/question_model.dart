import 'dart:convert';

QuestionModel questionFromJson(String str) =>
    QuestionModel.fromJson(json.decode(str));

String questionToJson(QuestionModel data) => json.encode(data.toJson());

class QuestionModel {
  String? pertanyaan;
  List<Jawaban>? jawaban;

  QuestionModel({
    this.pertanyaan,
    this.jawaban,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
        pertanyaan: json["pertanyaan"],
        jawaban: json["jawaban"] == null
            ? []
            : List<Jawaban>.from(
                json["jawaban"]!.map((x) => Jawaban.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pertanyaan": pertanyaan,
        "jawaban": jawaban == null
            ? []
            : List<dynamic>.from(jawaban!.map((x) => x.toJson())),
      };
}

class Jawaban {
  String? teksJawaban;
  String? nilai;

  Jawaban({
    this.teksJawaban,
    this.nilai,
  });

  factory Jawaban.fromJson(Map<String, dynamic> json) => Jawaban(
        teksJawaban: json["teks_jawaban"],
        nilai: json["nilai"],
      );

  Map<String, dynamic> toJson() => {
        "teks_jawaban": teksJawaban,
        "nilai": nilai,
      };
}
