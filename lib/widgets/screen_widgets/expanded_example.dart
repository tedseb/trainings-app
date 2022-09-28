import 'package:flutter/material.dart';
import 'package:higym/app_utils/pie_painter.dart';
import 'package:higym/app_utils/styles.dart';
import 'package:higym/widgets/general_widgets/button_widget.dart';

class ExpandExample extends StatefulWidget {
  const ExpandExample({Key? key}) : super(key: key);

  @override
  State<ExpandExample> createState() => _ExpandExampleState();
}

enum TpParameters { kraft, koordination, cardio, beweglichkeit }

class _ExpandExampleState extends State<ExpandExample> {
  final Map<TpParameters, double> tpParameters = {
    TpParameters.kraft: 0.3,
    TpParameters.koordination: 0.25,
    TpParameters.cardio: 0.15,
    TpParameters.beweglichkeit: 0.3,
  };

  ///If the box is expanded
  bool _isExpanded = false;

  ///Toogle the box to expand or collapse
  void _toogleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 26.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              InkWell(
                onTap: _toogleExpand,
                child: Container(
                  height: 120.0,
                  // margin: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    image: DecorationImage(
                      image: const AssetImage('assets/card_background/build.jpg'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.srcOver),
                    ),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // 'TRAINING 1',
                              'Build Muscles',
                              style: Styles.goalsCardTitle,
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 4.0),
                              width: 100.0,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Styles.primaryColor,
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ExpandedSection(
                expand: _isExpanded,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 110,
                            width: 110,
                            child: CustomPaint(
                              painter: PiePainter(
                                beweglichkeitPercent: tpParameters[TpParameters.beweglichkeit]!,
                                koordinationPercent: tpParameters[TpParameters.koordination]!,
                                cardioPercent: tpParameters[TpParameters.cardio]!,
                                kraftPercent: tpParameters[TpParameters.kraft]!,
                              ),
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Kraft
                              Row(
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Styles.pastelGreen,
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  const Icon(Icons.fitness_center_rounded, color: Styles.hiGymText),
                                  const SizedBox(width: 8.0),
                                  Text('Kraft', style: Styles.homeCardText)
                                ],
                              ),

                              /// Koordination
                              Row(
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Styles.pastelYellow,
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  const Icon(Icons.self_improvement_rounded, color: Styles.hiGymText),
                                  const SizedBox(width: 8.0),
                                  Text('Koordination', style: Styles.homeCardText)
                                ],
                              ),

                              /// Cardio
                              Row(
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Styles.pastelRed,
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  const Icon(Icons.directions_run_rounded, color: Styles.hiGymText),
                                  const SizedBox(width: 8.0),
                                  Text('Cardio', style: Styles.homeCardText)
                                ],
                              ),

                              /// Beweglichkeit
                              Row(
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Styles.pastelBlue,
                                    ),
                                  ),
                                  const SizedBox(width: 8.0),
                                  const Icon(Icons.sports_gymnastics_rounded, color: Styles.hiGymText),
                                  const SizedBox(width: 8.0),
                                  Text('Beweglichkeit', style: Styles.homeCardText)
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 32.0),
                      const Text(
                        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. ',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 32.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ButtonWidget(
                            text: 'Active',
                            onPressed: () {},
                            options: const ButtonOptions(
                              color: Styles.primaryColor,
                              textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Styles.hiGymText),
                            ),
                          ),
                          ButtonWidget(
                            text: 'Details',
                            onPressed: () {},
                            options: const ButtonOptions(
                              color: Styles.hiGymText,
                              textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ExpandedSection extends StatefulWidget {
  final Widget child;
  final bool expand;
  const ExpandedSection({Key? key, this.expand = false, required this.child}) : super(key: key);

  @override
  State<ExpandedSection> createState() => _ExpandedSectionState();
}

class _ExpandedSectionState extends State<ExpandedSection> with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
  }

  ///Setting up the animation
  void prepareAnimations() {
    expandController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    Animation<double> curve = CurvedAnimation(
      parent: expandController,
      curve: Curves.easeInOut,
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(curve)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void didUpdateWidget(ExpandedSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.expand) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(axisAlignment: 1.0, sizeFactor: animation, child: widget.child);
  }
}
