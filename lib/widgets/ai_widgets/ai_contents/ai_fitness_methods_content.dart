import 'package:flutter/material.dart';
import 'package:higym/constants/styles.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/constants/value_constants.dart';
import 'package:higym/widgets/general_widgets/navbar_icon_button_widget.dart';

class AiFitnessMethodsContent extends StatefulWidget {
  const AiFitnessMethodsContent({
    required this.appUser,
    Key? key,
  }) : super(key: key);

  final AppUser appUser;

  @override
  State<AiFitnessMethodsContent> createState() => _AiFitnessMethodsContentState();
}

class _AiFitnessMethodsContentState extends State<AiFitnessMethodsContent> {
  int _selectedItem = -1;

  @override
  void initState() {
    _selectedItem = ValueConstants.fitnessMethodObjects.indexWhere((element) => element['titel'] == widget.appUser.fitnessMethod);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: ValueConstants.fitnessMethodObjects.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
            child: InkWell(
              onTap: () => _onItemTapped(index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Styles.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    ///bottom right
                    BoxShadow(
                      color: Colors.grey.shade400,
                      offset: const Offset(3, 3),
                      blurRadius: 3,
                    ),

                    ///top left
                    BoxShadow(
                      color: Colors.grey.shade200,
                      offset: const Offset(-3, -3),
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    NavbarIconButtonWidget(
                      onPressedFunction: () => _onItemTapped(index),
                      iconData: ValueConstants.fitnessMethodObjects[index]['icon'],
                      selectedItem: _selectedItem,
                      index: index,
                      borderHeigth: 4.0,
                      borderWidth: 30.0,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(ValueConstants.fitnessMethodObjects[index]['titel'], style: Styles.subLinesBold),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedItem = index;
      widget.appUser.fitnessMethod = ValueConstants.fitnessMethodObjects[index]['titel'];
    });
  }
}
