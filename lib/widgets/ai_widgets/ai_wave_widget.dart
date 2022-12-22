import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AiWaveWidget extends StatefulWidget {
  const AiWaveWidget({Key? key}) : super(key: key);

  @override
  State<AiWaveWidget> createState() => _AiWaveWidgetState();
}

class _AiWaveWidgetState extends State<AiWaveWidget> {
  static const List<Color> colors = [Color(0xFFe4b0d8), Color(0xFF7bb0d8), Color(0xFFed24b7), Color(0xFF45abf7)];
  List<int> duration = [700, 600, 550, 650, 500];

  late List<Widget> allWaves;

  @override
  void initState() {
    allWaves = List<Widget>.generate(5, (index) => VisualComponent(duration: duration[index % 5], color: colors[index % 4], waveHeigth: 3));
    for (var element in List<Widget>.generate(5, (index) => VisualComponent(duration: duration[index % 5], color: colors[index % 4], waveHeigth: 1))) {
      allWaves.add(element);
    }
   for (var element in List<Widget>.generate(5, (index) => VisualComponent(duration: duration[index % 5], color: colors[index % 4], waveHeigth: 3))) {
      allWaves.add(element);
    }

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 100.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: allWaves,
          // children: List<Widget>.generate(10, (index) => VisualComponent(duration: duration[index % 5], color: colors[index % 4], waveHeigth: 1)),
        ),
      ),
    );
  }
}

// class MusicVisiualizer extends StatelessWidget {
//   const MusicVisiualizer({Key? key}) : super(key: key);

//   List<Color> colors = [Colors.blueAccent, Colors.greenAccent, Colors.redAccent, Colors.yellowAccent];
//   List<int> duration = [900, 700, 600, 800, 500];

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: List<Widget>.generate(10, (index) => VisualComponent(duration: duration[index%5], color: colors[index%4],)),
//     );
//   }
// }

class VisualComponent extends StatefulWidget {
  const VisualComponent({
    required this.duration,
    required this.color,
    required this.waveHeigth,
    Key? key,
  }) : super(key: key);

  final int duration;
  final Color color;
  final double waveHeigth;

  @override
  State<VisualComponent> createState() => _VisualComponentState();
}

class _VisualComponentState extends State<VisualComponent> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animationController;

    @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(duration: Duration(milliseconds: widget.duration), vsync: this);
    final curvedAnimation = CurvedAnimation(parent: animationController, curve: Curves.easeInOutCubic);

    animation = Tween<double>(begin: 0, end: 100).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });
    animationController.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 2.0,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(5),
      ),
      height: (animation.value / (2 * widget.waveHeigth)),
    );
  }
}
