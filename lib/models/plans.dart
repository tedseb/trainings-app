class Plans {
  String? name;
  int? time;
  int? kcal;
  int? totalRepetitions;
  int? totalWeight;
  int? score;
  int? success;
  bool? higymAutomated;
  String? planDoneTime;
  Map<String, String>? parameters;
  List<Exercises>? exercises;

  Plans({
    this.name,
    this.time,
    this.kcal,
    this.totalRepetitions,
    this.totalWeight,
    this.score,
    this.success,
    this.higymAutomated,
    this.planDoneTime,
    this.parameters,
    this.exercises,
  });

  Map<String, dynamic> plansToJson() => {
        'name': name,
        'time': time,
        'kcal': kcal,
        'totalRepetitions': totalRepetitions,
        'totalWeight': totalWeight,
        'score': score,
        'success': success,
        'higymAutomated': higymAutomated,
        'planDoneTime': planDoneTime,
        'parameters': parameters,
        'exercises': exercises?.map((exe) => exe.exercisesToJson()).toList(),
      };

  static Plans plansFromJson(Map<String, dynamic> json) {
    return Plans(
      name: json['name'],
      time: json['time'],
      kcal: json['kcal'],
      totalRepetitions: json['totalRepetitions'],
      totalWeight: json['totalWeight'],
      score: json['score'],
      success: json['success'],
      higymAutomated: json['higymAutomated'],
      planDoneTime: json['planDoneTime'],
      parameters: json['parameters'],
      exercises: json['exercises'] != null ? json['exercises'].map<Exercises>((exe) => Exercises.exercisesFromJson(exe)).toList() : [],
    );
  }
}

class Exercises {
  String? name;
  String? img;
  String? video;
  String? info;
  String? muscleGroup;
  int? pk;
  int? exePauseTime;
  int? exePauseTimeDone;
  bool? exerciseFinished;
  bool? exercisePauseFinished;
  int? stations;
  List<int>? rpeScale;
  List<Sets>? sets;

  Exercises({
    this.name,
    this.img,
    this.video,
    this.info,
    this.muscleGroup,
    this.pk,
    this.exePauseTime,
    this.exePauseTimeDone,
    this.exerciseFinished,
    this.exercisePauseFinished,
    this.stations,
    this.rpeScale,
    this.sets,
  });

  Map<String, dynamic> exercisesToJson() => {
        'name': name,
        'img': img,
        'video': video,
        'info': info,
        'muscleGroup': muscleGroup,
        'pk': pk,
        'exePauseTime': exePauseTime,
        'exerciseFinished': exerciseFinished,
        'exePauseTimeDone': exePauseTimeDone,
        'exercisePauseFinished': exercisePauseFinished,
        'stations': stations,
        'rpeScale': rpeScale,
        'sets': sets?.map((sts) => sts.setsToJson()).toList(),
      };

  static Exercises exercisesFromJson(Map<String, dynamic> json) {
    return Exercises(
      name: json['name'],
      img: json['img'],
      video: json['video'],
      info: json['info'],
      muscleGroup: json['muscleGroup'],
      pk: json['pk'],
      exePauseTime: json['exePauseTime'],
      exePauseTimeDone: json['exePauseTimeDone'],
      exerciseFinished: json['exerciseFinished'],
      exercisePauseFinished: json['exercisePauseFinished'],
      stations: json['stations'],
      rpeScale: json['rpeScale'],
      sets: json['sets'].map<Sets>((sts) => Sets.setsFromJson(sts)).toList(),
    );
  }
}

class Sets {
  int? time;
  int? repetitions;
  double? weight;
  int? pause;
  int? success;
  int? setIndex;
  int? timeDone;
  int? repetitionsDone;
  double? weightDone;
  int? pauseDone;
  bool? setFinished;
  bool? setPauseFinished;

  Sets({
    this.time,
    this.repetitions,
    this.weight,
    this.pause,
    this.success,
    this.setIndex,
    this.timeDone,
    this.repetitionsDone,
    this.weightDone,
    this.pauseDone,
    this.setFinished,
    this.setPauseFinished,
  });

  Map<String, dynamic> setsToJson() => {
        'time': time,
        'repetitions': repetitions,
        'weight': weight,
        'pause': pause,
        'success': success,
        'timeDone': timeDone,
        'repetitionsDone': repetitionsDone,
        'weightDone': weightDone,
        'pauseDone': pauseDone,
        'setFinished': setFinished,
        'setPauseFinished': setPauseFinished,
      };

  static Sets setsFromJson(Map<String, dynamic> json) => Sets(
        time: json['time'],
        repetitions: json['repetitions'],
        weight: json['weight'],
        pause: json['pause'],
        success: json['success'],
        timeDone: json['timeDone'],
        repetitionsDone: json['repetitionsDone'],
        weightDone: json['weightDone'],
        pauseDone: json['pauseDone'],
        setFinished: json['setFinished'],
        setPauseFinished: json['setPauseFinished'],
      );
}
