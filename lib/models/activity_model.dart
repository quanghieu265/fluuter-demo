class ActivityModel {
  ActivityModel({
    required this.activity,
    required this.type,
  });

  /// Convert a JSON object into an [ActivityModel] instance.
  /// This enables type-safe reading of the API response.
  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      activity: json['activity'] as String,
      type: json['type'] as String,
    );
  }

  final String activity;
  final String type;
}
