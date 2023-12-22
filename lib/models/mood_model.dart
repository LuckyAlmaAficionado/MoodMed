class ModelMoodTracker {
  final String uuid;
  final String username;
  final String colorDay;
  final String feelings;
  final String tags;
  final String story;
  final String badStory;
  final String createdAt;

  ModelMoodTracker({
    required this.uuid,
    required this.username,
    required this.colorDay,
    required this.feelings,
    required this.tags,
    required this.story,
    required this.badStory,
    required this.createdAt,
  });

  factory ModelMoodTracker.fromJson(Map<String, dynamic> json) =>
      ModelMoodTracker(
        uuid: json["uuid"],
        username: json["username"],
        colorDay: json["colorDay"],
        feelings: json["feelings"],
        tags: json["tags"],
        story: json["story"],
        badStory: json["badStory"],
        createdAt: json["createdAt"],
      );
}
