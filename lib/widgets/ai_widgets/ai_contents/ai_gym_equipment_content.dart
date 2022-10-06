import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/widgets/general_widgets/exercise_card_widget.dart';
import 'package:higym/widgets/general_widgets/glas_box_widget.dart';

import 'package:higym/app_utils/helper_utils.dart' as helper_utils;
import 'package:higym/widgets/general_widgets/shadow_icon_button_widget.dart';

class AiGymEquipmentContent extends StatefulWidget {
  const AiGymEquipmentContent({
    required this.gymEquipment,
    Key? key,
  }) : super(key: key);

  final List<Map<String, bool>> gymEquipment;

  @override
  State<AiGymEquipmentContent> createState() => _AiGymEquipmentContentState();
}

class _AiGymEquipmentContentState extends State<AiGymEquipmentContent> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.gymEquipment.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 0.0, right: 26.0, bottom: 32.0),
            child: SizedBox(
              height: 75.0,
              // color: Colors.grey[50],
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlasBoxWidget(exerciseImage: 'dumbbell'),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 26.0, top: 4.0, right: 26.0, bottom: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.gymEquipment[index].keys.first,
                            style: Styles.trainingsplanCardExeTitle,
                          ),
                          // Text(
                          //   'Learn more',
                          //   style: Styles.trainingsplanCardExeSubTitle,
                          // ),
                        ],
                      ),
                    ),
                  ),
                  widget.gymEquipment[index].values.first
                      ? ShadowIconButtonWidget(
                          buttonIcon: Icons.done_rounded,
                          onPressFunction: () => setState(() => widget.gymEquipment[index][widget.gymEquipment[index].keys.first] = false),
                          loggerText: 'add_${widget.gymEquipment[index].keys.first}',
                        )
                      : ShadowIconButtonWidget(
                          buttonIcon: Icons.add_rounded,
                          onPressFunction: () => setState(() => widget.gymEquipment[index][widget.gymEquipment[index].keys.first] = true),
                          loggerText: 'delete_${widget.gymEquipment[index].keys.first}',
                        ),
                ],
              ),
            ),
          );
        });
  }
}
