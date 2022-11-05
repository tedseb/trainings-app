class Goal {
  String name;
  String info;
  List<TrainingPrograms> trainingsProgramms;

  Goal({
    required this.name,
    required this.info,
    required this.trainingsProgramms,
  });

  Map<String, dynamic> goalToJson() => {
        'name': name,
        'info': info,
        'trainingsProgramms': trainingsProgramms.map((trainingsProgramms) => trainingsProgramms.trainingsProgrammsToJson()).toList(),
      };

  static Goal goalFromJson(Map<String, dynamic> json) {
    return Goal(
      name: json['name'],
      info: json['info'],
      trainingsProgramms: json['trainingsProgramms']
          .map<TrainingPrograms>((trainingsProgramms) => TrainingPrograms.trainingsProgrammsFromJson(trainingsProgramms))
          .toList(),
    );
  }
}

class TrainingPrograms {
  String name;
  String info;
  String fitnesstype;
  int difficultyLevel;
  int durationWeeks;
  int actualPhase;
  List<String> phases;
  String actualPlan;
  List<Plans> plans;

  TrainingPrograms({
    required this.name,
    required this.info,
    required this.fitnesstype,
    required this.difficultyLevel,
    required this.durationWeeks,
    required this.actualPhase,
    required this.phases,
    required this.actualPlan,
    required this.plans,
  });

  Map<String, dynamic> trainingsProgrammsToJson() => {
        'name': name,
        'info': info,
        'fitnesstype': fitnesstype,
        'difficultyLevel': difficultyLevel,
        'durationWeeks': durationWeeks,
        'actualPhase': actualPhase,
        'phases': phases,
        'actualPlan': actualPlan,
        'plans': plans.map((plan) => plan.plansToJson()).toList(),
      };

  static TrainingPrograms trainingsProgrammsFromJson(Map<String, dynamic> json) {
    return TrainingPrograms(
      name: json['name'],
      info: json['info'],
      fitnesstype: json['fitnesstype'],
      difficultyLevel: json['difficultyLevel'],
      durationWeeks: json['durationWeeks'],
      actualPhase: json['actualPhase'],
      phases: json['phases'],
      actualPlan: json['actualPlan'],
      plans: json['plans'].map<Plans>((plan) => Plans.plansFromJson(plan)).toList(),
    );
  }
}

class Plans {
  String name;
  int time;
  List<Exercises> exercises;

  Plans({
    required this.name,
    this.time = 0,
    required this.exercises,
  });

  Map<String, dynamic> plansToJson() => {
        'name': name,
        'time': time,
        'exercises': exercises.map((exe) => exe.exercisesToJson()).toList(),
      };

  static Plans plansFromJson(Map<String, dynamic> json) {
    return Plans(
      name: json['name'],
      time: json['time'],
      exercises: json['exercises'].map<Exercises>((exe) => Exercises.exercisesFromJson(exe)).toList(),
    );
  }
}

class Exercises {
  String name;
  String subName;
  String info;
  String media;
  int eID;
  List<int> alternativeExercises;
  List<String> station;
  List<String> stationShort;
  List<String> handle;
  List<String> handleShort;
  List<double> ratio;
  Map<String, int> repetitionsScale;
  Map<String, int> setDoTimeScale;
  Map<String, int> setRestTimeScale;
  Map<String, double> weigthScale;
  double warmupWeigth;
  String warmupInfo;
  Map<String, int> exerciseRestTime;
  Map<String, int> rpeScale;
  List<Sets> sets;

  Exercises({
    required this.name,
    required this.subName,
    required this.info,
    required this.media,
    required this.eID,
    required this.alternativeExercises,
    required this.station,
    required this.stationShort,
    required this.handle,
    required this.handleShort,
    required this.ratio,
    required this.repetitionsScale,
    required this.setDoTimeScale,
    required this.setRestTimeScale,
    required this.weigthScale,
    required this.warmupWeigth,
    required this.warmupInfo,
    this.exerciseRestTime = const {},
    this.rpeScale = const {},
    required this.sets,
  });

  Map<String, dynamic> exercisesToJson() => {
        'name': name,
        'subName': subName,
        'info': info,
        'media': media,
        'eID': eID,
        'alternativeExercises': alternativeExercises,
        'station': station,
        'stationShort': stationShort,
        'handle': handle,
        'handleShort': handleShort,
        'ratio': ratio,
        'repetitionsScale': repetitionsScale,
        'setDoTimeScale': setDoTimeScale,
        'setRestTimeScale': setRestTimeScale,
        'weigthScale': weigthScale,
        'warmupWeigth': warmupWeigth,
        'warmupInfo': warmupInfo,
        'exerciseRestTime': exerciseRestTime,
        'rpeScale': rpeScale,
        'sets': sets.map((sts) => sts.setsToJson()).toList(),
      };

  static Exercises exercisesFromJson(Map<String, dynamic> json) {
    return Exercises(
      name: json['name'],
      subName: json['subName'],
      info: json['info'],
      media: json['media'],
      eID: json['eID'],
      alternativeExercises: json['alternativeExercises'],
      station: json['station'],
      stationShort: json['stationShort'],
      handle: json['handle'],
      handleShort: json['handleShort'],
      ratio: json['ratio'],
      repetitionsScale: json['repetitionsScale'],
      setDoTimeScale: json['setDoTimeScale'],
      setRestTimeScale: json['setRestTimeScale'],
      weigthScale: json['weigthScale'],
      warmupWeigth: json['warmupWeigth'],
      warmupInfo: json['warmupInfo'],
      exerciseRestTime: json['exerciseRestTime'],
      rpeScale: json['rpeScale'],
      sets: json['sets'].map<Sets>((sts) => Sets.setsFromJson(sts)).toList(),
    );
  }
}

class Sets {
  Map<String, int> repetitions;
  Map<String, int> setTime;
  Map<String, double> weight;
  Map<String, int> setRestTime;

  Sets({
    this.repetitions = const {},
    this.setTime = const {},
    this.weight = const {},
    this.setRestTime = const {},
  });

  Map<String, dynamic> setsToJson() => {
        'repetitions': repetitions,
        'setTime': setTime,
        'weight': weight,
        'setRestTime': setRestTime,
      };

  static Sets setsFromJson(Map<String, dynamic> json) => Sets(
        repetitions: json['repetitions'],
        setTime: json['setTime'],
        weight: json['weight'],
        setRestTime: json['setRestTime'],
      );
}
