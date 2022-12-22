import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:higym/constants/styles.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/constants/value_constants.dart';

class AiTextWidget extends StatefulWidget {
  const AiTextWidget({
    this.user,
    required this.possibleAiScreen,
    required this.variation,
    Key? key,
  }) : super(key: key);

  final AppUser? user;
  final PossibleAiScreens possibleAiScreen;
  final int variation;

  @override
  State<AiTextWidget> createState() => _AiTextWidgetState();
}

class _AiTextWidgetState extends State<AiTextWidget> {
  TextStyle aiTextStyle = Styles.subLinesBold;
  String aiText = '';
  Map<PossibleAiScreens, Map<int, String>> aiTextMap = {};

  @override
  void initState() {
    aiTextMap = {
      PossibleAiScreens.signInScreen: {
        1: 'Log in to your HiGym account',
        2: 'Log in to your HiGym account',
      },
      PossibleAiScreens.signUpScreen: {
        1: 'Registriere dich und starte dein Training!',
        2: 'Registriere dich und starte dein Training!',
      },
      PossibleAiScreens.aiOnboardingScreen: {
        1: 'Hallo, ich bin Gymion! Ich bin dein smarter Coach.',
        2: 'Hallo, ich bin Gymion! Ich bin dein smarter Coach.',
      },
      PossibleAiScreens.talkToAiContent: {
        1: 'Worauf willst du mich genauer einstimmen ${widget.user?.name}?',
        2: 'Worauf willst du mich genauer einstimmen ${widget.user?.name}?',
      },
      PossibleAiScreens.aiNameContent: {
        1: 'Wie heißt du?',
        2: 'Welchen neuen Namen möctest du dir geben ${widget.user?.name}?',
      },
      PossibleAiScreens.aiPersonalDataContent: {
        1: '${widget.user?.name}, ich erstelle dir einen Workout der perfekt auf dich abgestimmt ist. Dazu brauch ich einige Information von dir.',
        2: 'Hey ${widget.user?.name}! Gerne kannst du deine persönlichen Daten nochmal updaten!',
      },
      PossibleAiScreens.aiGoalContent: {
        1: 'Interessant dein BMI beträgt ${bmiCalculator()}. Was ist dein Ziel?',
        2: 'Was ist dein neues Ziel ${widget.user?.name}?',
      },
      PossibleAiScreens.aiFitnessLevelContent: {
        1: 'Wie fit bist du? Damit ich deinen Schwierigkeitsgrad richtig einstellen kann, wähle die Option, die am besten zu dir passt!',
        2: 'Wie fit bist du? Damit ich deinen Schwierigkeitsgrad richtig einstellen kann, wähle die Option, die am besten zu dir passt!',
      },
      PossibleAiScreens.aiFitnessMethodsContent: {
        1: 'Mit welcher Art von Fitness hast du die meiste Erfahrung?',
        2: 'Mit welcher Art von Fitness hast du die meiste Erfahrung?',
      },
      PossibleAiScreens.aiFrequenzyContent: {
        1: 'Wie oft und für wie lange kannst du sicher pro Woche trainieren?',
        2: 'Wie oft und für wie lange kannst du sicher pro Woche trainieren?',
      },
      PossibleAiScreens.aiAdditionalMusclegroupContent: {
        1: 'Gibt es einen Körperteil was du besonders gut entwickeln möchtest?',
        2: 'Gibt es einen Körperteil was du besonders gut entwickeln möchtest?',
      },
      PossibleAiScreens.aiGymEquipmentContent: {
        1: 'Diese Equipments solltest du parat haben!',
        2: 'Diese Equipments solltest du parat haben!',
      },
      PossibleAiScreens.aiPresentTrainingsProgrammContent: {
        1: 'Geschafft! Hier ist dein Trainingsprogramm.',
        2: 'Hier ist dein neues Trainings Programm, viel Erfolg!',
      },
    };
    aiText = aiTextMap[widget.possibleAiScreen]![widget.variation]!;

    super.initState();
  }

  String bmiCalculator() {
    if (widget.user != null) {
      if (widget.user!.weigth!.isNotEmpty) {
        return ((widget.user!.weigth!.last.entries.first.value / (widget.user!.size! * widget.user!.size!)) * 10000).toStringAsFixed(2);
      }
    }
    return '22';
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Container(
      /// heighth is needed, to prevent the page movement if text is double lined so I need to know possible place for my Text
      height: textSize(screenSize.width - 52.0),
      padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 8.0),
      child: AnimatedTextKit(
        animatedTexts: [
          TyperAnimatedText(
            aiText,
            textAlign: TextAlign.center,
            speed: const Duration(milliseconds: 100),
            textStyle: aiTextStyle,
          )
        ],
        isRepeatingAnimation: false,
        displayFullTextOnTap: true,
      ),
    );
  }

  double textSize(double possibleWidth) {
    double containerHeight = 0;
    TextPainter textPainter = TextPainter(
      text: TextSpan(text: aiText, style: aiTextStyle),
      textDirection: TextDirection.ltr,
      textScaleFactor: WidgetsBinding.instance.window.textScaleFactor,
    )..layout();
    containerHeight = ((textPainter.size.width / possibleWidth).ceil() * textPainter.size.height) + 20.0;

    return containerHeight;
  }
}
