class AppUser {
  final String? uid;
  String? name;
  String? email;
  double? weigth;
  double? size;
  int? age;
  String? gender;
  String? goalName;
  int? dayFrequenz;
  String? minutesFrequenz;
  String? reminder;
  Map<String, double>? activityPoints;
  int? activityLevel;

  AppUser({
    this.uid,
    this.name,
    this.email,
    this.weigth,
    this.size,
    this.age,
    this.gender,
    this.goalName,
    this.dayFrequenz,
    this.minutesFrequenz,
    this.reminder,
    this.activityPoints,
    this.activityLevel,
  });
}
