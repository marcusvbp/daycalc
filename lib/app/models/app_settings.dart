class AppSettings {
  final bool showSettingsFirst;

  AppSettings({this.showSettingsFirst = true});

  Map<String, dynamic> toJson() => {'showSettingsFirst': showSettingsFirst};

  factory AppSettings.fromJson(Map<String, dynamic> json) =>
      AppSettings(showSettingsFirst: json['showSettingsFirst'] as bool);
}
