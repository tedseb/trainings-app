import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/widgets/ai_widgets/ai_text_widget.dart';
import 'package:higym/widgets/ai_widgets/ai_wave_widget.dart';
import 'package:higym/widgets/ai_widgets/talk_to_ai_content_widget.dart';
import 'package:higym/widgets/general_widgets/shadow_icon_button_widget.dart';

class TalkToAiScreen extends StatefulWidget {
  const TalkToAiScreen({Key? key}) : super(key: key);

  @override
  State<TalkToAiScreen> createState() => _TalkToAiScreenState();
}

class _TalkToAiScreenState extends State<TalkToAiScreen> {


  Widget contentWidget = const TalkToAIContentWidget();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  iconSize: 38.0,
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Styles.hiGymText,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          const AiWaveWidget(),
          const AiTextWidget(aiText: ' Worauf willst du mich genauer einstimmen Nico?'),
          const Expanded(child: SizedBox()),
          contentWidget,
          const Expanded(child: SizedBox()),
        ],
      ),
      // bottomNavigationBar: ,
    );
  }

  // Widget talkToAiContent() { 
  //   return const TalkToAIContentWidget();
  //   }
}
