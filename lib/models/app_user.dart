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
  int? fitnessLevel;
  String? fitnessMethod;
  String? additionalMusclegroup;
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
    this.fitnessLevel,
    this.fitnessMethod,
    this.additionalMusclegroup,
    this.activityPoints,
    this.activityLevel,
  });

  Map<String, dynamic> appUserToJson() => {
        'uid': uid,
        'name': name,
        'email': email,
        'weigth': weigth,
        'size': size,
        'age': age,
        'gender': gender,
        'goalName': goalName,
        'dayFrequenz': dayFrequenz,
        'minutesFrequenz': minutesFrequenz,
        'reminder': reminder,
        'fitnessLevel': fitnessLevel,
        'fitnessMethod': fitnessMethod,
        'additionalMusclegroup': additionalMusclegroup,
        'activityPoints': activityPoints,
        'activityLevel': activityLevel,
      };

  static AppUser appUserFromJson(Map<String, dynamic> json) {
    return AppUser(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      weigth: json['weigth'],
      size: json['size'],
      age: json['age'],
      gender: json['gender'],
      goalName: json['goalName'],
      dayFrequenz: json['dayFrequenz'],
      minutesFrequenz: json['minutesFrequenz'],
      reminder: json['reminder'],
      fitnessLevel: json['fitnessLevel'],
      fitnessMethod: json['fitnessMethod'],
      additionalMusclegroup: json['additionalMusclegroup'],
      activityPoints: json['activityPoints'],
      activityLevel: json['activityLevel'],
    );
  }
}
