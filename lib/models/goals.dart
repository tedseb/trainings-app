// class Goals {
//   String name;
//   int? time;
//   int? kcal;
//   int? totalRepetitions;
//   int? totalWeight;
//   int? score;
//   int? success;
//   bool? higymAutomated;
//   String? planDoneTime;
//   Map<String, String>? parameters;
//   List<Exercises>? exercises;

//   Goals({
//     this.name,
//     this.time,
//     this.kcal,
//     this.totalRepetitions,
//     this.totalWeight,
//     this.score,
//     this.success,
//     this.higymAutomated,
//     this.planDoneTime,
//     this.parameters,
//     this.exercises,
//   });

//   Map<String, dynamic> plansToJson() => {
//         'name': name,
//         'time': time,
//         'kcal': kcal,
//         'totalRepetitions': totalRepetitions,
//         'totalWeight': totalWeight,
//         'score': score,
//         'success': success,
//         'higymAutomated': higymAutomated,
//         'planDoneTime': planDoneTime,
//         'parameters': parameters,
//         'exercises': exercises?.map((exe) => exe.exercisesToJson()).toList(),
//       };

//   static Plans plansFromJson(Map<String, dynamic> json) {
//     return Plans(
//       name: json['name'],
//       time: json['time'],
//       kcal: json['kcal'],
//       totalRepetitions: json['totalRepetitions'],
//       totalWeight: json['totalWeight'],
//       score: json['score'],
//       success: json['success'],
//       higymAutomated: json['higymAutomated'],
//       planDoneTime: json['planDoneTime'],
//       parameters: json['parameters'],
//       exercises: json['exercises'] != null ? json['exercises'].map<Exercises>((exe) => Exercises.exercisesFromJson(exe)).toList() : [],
//     );
//   }
// }