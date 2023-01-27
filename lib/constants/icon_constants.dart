import 'package:flutter/material.dart';
import 'package:higym/constants/gymion_icons.dart';
import 'package:higym/constants/styles.dart';

class IconConstants {
  ///--- Icon Constants ---///
  static Icon get closeIcon => const Icon(
        GymionIcons.close,
      );
  static Icon get skipIcon => const Icon(
        GymionIcons.skip,
      );

  static Icon get levelEasyIcon => const Icon(
        GymionIcons.levelEasy,
      );
  static Icon get levelMediumIcon => const Icon(
        GymionIcons.levelMedium,
      );
  static Icon get levelHardIcon => const Icon(
        GymionIcons.levelHard,
      );
  static Icon get timeIcon => const Icon(
        GymionIcons.clock,
      );
  static Icon get arrowLeftIcon => const Icon(
        GymionIcons.arrowLeft,
      );

  static Icon get gearIcon => const Icon(
        GymionIcons.gear,
      );
  static Icon get arrowUpIcon => const Icon(
        GymionIcons.arrowUp,
        size: 32.0,
      );
  static Icon get infoIcon => const Icon(
        GymionIcons.info,
      );
  static Icon get occupiedIcon => const Icon(
        Icons.skip_next_rounded,
        color: Styles.exercisingWhite,
      );

  static Icon get passwordVisibleIcon => const Icon(
        Icons.visibility_rounded,
        color: Styles.grey,
        size: Styles.iconSize,
      );
  static Icon get passwordNotVisibleIcon => const Icon(
        Icons.visibility_off_rounded,
        color: Styles.grey,
        size: Styles.iconSize,
      );

  ///--- Icon Constants ---///

  ///--- IconData Constants ---///

  /// Adjust Screen
  static IconData get signOutIconData => GymionIcons.signOut;
  static IconData get aboutIconData => GymionIcons.gear;
  static IconData get talkToAiIconData => GymionIcons.aiwave;
  static IconData get enhanceTheAiIconData => Icons.list_alt_rounded;

  /// Exercising Screen

  static IconData get closeIconData => GymionIcons.close;
  static IconData get skipIconData =>  GymionIcons.skip;
  static IconData get startExerciseIconData => Icons.play_circle_fill_rounded;
  static IconData get doneExerciseIconData => Icons.check_circle_rounded;

  /// Goals Screen
  static IconData get loseWeight => GymionIcons.libra;
  static IconData get muscleBuilding => GymionIcons.buildMuscle;
  static IconData get generalFitness => GymionIcons.running;
  static IconData get strengthenHealth => GymionIcons.heartbeat;
  static IconData get tightenSkin => GymionIcons.hips;

  /// FitnessMethod Screen
  static IconData get machineTraining => GymionIcons.gymMachines;
  static IconData get freeWeightsTraining => GymionIcons.dumbbells;
  static IconData get cardio => GymionIcons.cyclist;
  static IconData get all => GymionIcons.all;

  /// AdditionalMuscleGroup Screen
  static IconData get fullBody => GymionIcons.fullBody;
  static IconData get po => GymionIcons.po;
  static IconData get arms => GymionIcons.arm;
  static IconData get belly => GymionIcons.belly;
  static IconData get shoulders => GymionIcons.shoulders;
  static IconData get spine => GymionIcons.spine;
  static IconData get chest => GymionIcons.chest;

  /// General
  static IconData get arrowRightIconData => GymionIcons.arrowRight;
  static IconData get infoIconData => GymionIcons.info;

  /// Navigation Bar
  static IconData get home => GymionIcons.home;
  static IconData get plans => GymionIcons.plans;
  static IconData get body => GymionIcons.body;
  static IconData get adjust => GymionIcons.adjust;

  ///--- IconData Constants ---///

}
