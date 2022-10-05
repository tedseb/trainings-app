import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/widgets/ai_widgets/textfield_user_modifier_widget.dart';
import 'package:higym/widgets/general_widgets/textfield_widget.dart';

class AiNameContent extends StatefulWidget {
  const AiNameContent({
    required this.appUser,
    Key? key,
  }) : super(key: key);

  final AppUser appUser;

  @override
  State<AiNameContent> createState() => _AiNameContentState();
}

class _AiNameContentState extends State<AiNameContent> {
  final nameController = TextEditingController();

  @override
  void initState() {
    widget.appUser.name != null ? nameController.text = widget.appUser.name! : () {};
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
          child: TextFieldUserModifierWidget(controller: nameController, label: 'Name', hintText: 'Dein Name', changeVal: changeName),
        ),
      ],
    );
  }


  changeName(String val){
    widget.appUser.name = val;
  }
}
