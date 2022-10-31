import 'package:flutter/cupertino.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/models/app_user.dart';
import 'package:higym/widgets/general_widgets/shadow_button_widget.dart';

class AiReminderContent extends StatefulWidget {
  const AiReminderContent({
    required this.appUser,
    Key? key,
  }) : super(key: key);
  final AppUser appUser;

  @override
  State<AiReminderContent> createState() => _AiReminderContentState();
}

class _AiReminderContentState extends State<AiReminderContent> {
  late int hourIndexSelected;
  late int minuteIndexSelected;
  late int cycleIndexSelected;
  late int daysIndexSelected;

  late PageController hourController;
  late PageController minuteController;

  List<String> hourList = [
    '00',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23'
  ];
  List<String> minutesList = ['00', '15', '30', '45'];
  List<String> cycleList = ['Everyday', 'Mon-Fri', 'Weekends'];
  List<String> daysList = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  void initState() {
     int initHourPage;
      int initMinutePage;
    if (widget.appUser.reminder != null) {
      initHourPage = hourList.indexWhere((element) => element.toString() == widget.appUser.reminder!.split('_')[0]);
      initMinutePage = minutesList.indexWhere((element) => element.toString() == widget.appUser.reminder!.split('_')[1]);
    }else{
      initHourPage = 9;
      initMinutePage = 0;
    }
    hourIndexSelected = initHourPage == -1 ? 0 : initHourPage;
    minuteIndexSelected = initMinutePage == -1 ? 0 : initMinutePage;
    hourController = PageController(viewportFraction: 0.35, initialPage: hourIndexSelected);
    minuteController = PageController(viewportFraction: 0.35, initialPage: minuteIndexSelected);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('What Time?', style: Styles.headLine),
        const SizedBox(height: 16.0),
        SizedBox(
          height: 130,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 4),
                width: 100.0,
                height: 40.0,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 2.0, color: Styles.hiGymText),
                    bottom: BorderSide(width: 2.0, color: Styles.hiGymText),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  SizedBox(
                    width: 50,
                    child: PageView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: hourList.length,
                      controller: hourController,
                      onPageChanged: (int index) => setState(() => hourIndexSelected = index),
                      itemBuilder: (_, hourIndex) {
                        return Center(
                          child: Text(
                            hourList[hourIndex].toString(),
                            style: Styles.headLine.copyWith(color: hourIndex == hourIndexSelected ? Styles.hiGymText : Styles.lightGrey),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  SizedBox(
                    width: 50,
                    child: PageView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: minutesList.length,
                      controller: minuteController,
                      onPageChanged: (int index) => setState(() => minuteIndexSelected = index),
                      itemBuilder: (_, minuteIndex) {
                        return Center(
                          child: Text(
                            minutesList[minuteIndex].toString(),
                            style: Styles.headLine.copyWith(color: minuteIndex == minuteIndexSelected ? Styles.hiGymText : Styles.lightGrey),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(child: Row(children: [const SizedBox(width: 16.0), Text('Uhr', style: Styles.headLine)]))
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        Text('Which Days?', style: Styles.headLine),
        const SizedBox(height: 16.0),
        SizedBox(
          height: 200,
          child: Row(
            children: [
              Flexible(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: cycleList.length,
                    itemBuilder: (context, index) {
                      return ShadowButtonWidget(
                          buttonText: cycleList[index], buttonWidth: 80.0, onPressFunction: () {}, loggerText: '${cycleList[index]} Selected');
                    }),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        Row()
      ],
    );
  }
}
