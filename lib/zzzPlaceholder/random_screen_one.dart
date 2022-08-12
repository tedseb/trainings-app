import 'package:flutter/material.dart';
import 'package:higym/app_utils/styles.dart';

class RandomScreenOne extends StatefulWidget {
  const RandomScreenOne({Key? key}) : super(key: key);

  @override
  State<RandomScreenOne> createState() => _RandomScreenOneState();
}

class _RandomScreenOneState extends State<RandomScreenOne> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Styles.white,
      body: Center(child: Text('Profile Screen'),),
    );
  }
}

/*

Container(
          decoration: const BoxDecoration(
            color: Styles.white,
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                offset: Offset(0, -15),
                blurRadius: 15,
                spreadRadius: 10,
              ),
            ],
          ),
          child: Row(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Expanded(child: SizedBox()),
              Container(
                child: IconButton(
                  color: Styles.gymyGrey,
                  icon: const Icon(
                    Icons.home_outlined,
                  ),
                  onPressed: () {},
                ),
              ),
              IconButton(
                color: Styles.gymyGrey,
                icon: const Icon(Icons.person_outline_rounded),
                onPressed: () {},
              ),
              IconButton(
                iconSize: 80,
                color: Styles.primaryColor,
                icon: const Icon(Icons.play_circle_rounded),
                onPressed: () {},
              ),
              IconButton(
                color: Styles.gymyGrey,
                icon: const Icon(Icons.phone_iphone_rounded),
                onPressed: () {},
              ),
              IconButton(
                color: Styles.gymyGrey,
                icon: const Icon(Icons.outlined_flag_rounded),
                onPressed: () {},
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
        ),
 */



// Container(
//           margin: const EdgeInsets.all(20),
//           height: size.height*0.155,

//           decoration: const BoxDecoration(
//             color: Styles.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey,
//                 offset: Offset(0, -15),
//                 blurRadius: 15,
//                 spreadRadius: 10,
//               ),
//             ],
//           ),
//           child: ListView.builder(
//             itemCount: _pages.length,
//             scrollDirection: Axis.horizontal,
//             padding: EdgeInsets.symmetric(horizontal: size.width * 0.024),
//             itemBuilder: (context, index) => InkWell(
//               onTap: () {
//                 setState(() {
//                   _selectedItem = index;
//                 });
//               },
//               splashColor: Colors.transparent,
//               highlightColor: Colors.transparent,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   AnimatedContainer(
//                     duration: const Duration(milliseconds: 1500),
//                     curve: Curves.easeInOut,
//                     margin: EdgeInsets.only(bottom: index == _selectedItem ? size.width * 0.014 : 0),
//                     decoration: const BoxDecoration(
//                       color: Styles.primaryColor,
//                       borderRadius: BorderRadius.vertical(
//                         bottom: Radius.circular(10.0),
//                       ),
//                     ),
//                   ),
//                   Icon(_icons[index],
//                   size: size.width*0.076,
//                   color: index == _selectedItem ? Styles.primaryColor : Styles.gymyGrey,
//                   ),
//                   SizedBox(height: size.width*0.03,)
//                 ],
//               ),
//             ),
//           ),
//         ),


// Row(

//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               const Expanded(child: SizedBox()),
//               Container(
//                 padding: EdgeInsets.zero,
//                 decoration: bottomBorder(),
//                 child: IconButton(

//                   padding: EdgeInsets.zero,
//                   color: Styles.gymyGrey,
//                   icon: const Icon(
//                     Icons.home_outlined,
//                   ),
//                   onPressed: () {},
//                 ),
//               ),
//               IconButton(
//                 color: Styles.gymyGrey,
//                 icon: const Icon(Icons.person_outline_rounded),
//                 onPressed: () {},
//               ),
//               IconButton(
//                 iconSize: 80,
//                 color: Styles.primaryColor,
//                 icon: const Icon(Icons.play_circle_rounded),
//                 onPressed: () {},
//               ),
//               IconButton(
//                 color: Styles.gymyGrey,
//                 icon: const Icon(Icons.phone_iphone_rounded),
//                 onPressed: () {},
//               ),
//               IconButton(
//                 color: Styles.gymyGrey,
//                 icon: const Icon(Icons.outlined_flag_rounded),
//                 onPressed: () {},
//               ),
//               const Expanded(child: SizedBox()),
//             ],
//           ),



 //////////////////////////////////////////////////////ButtomNavBar original
        // bottomNavigationBar: BottomNavigationBar(
        //   elevation: 0.0,
        //   backgroundColor: Styles.white,

        //   items: const <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //       icon: Icon(
        //         Icons.home_outlined,
        //         color: Styles.gymyGrey,
        //       ),
        //       label: 'Home',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(
        //         Icons.person_outline_rounded,
        //         color: Styles.gymyGrey,
        //       ),
        //       label: 'Business',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(
        //         Icons.phone_iphone_rounded,
        //         color: Styles.gymyGrey,
        //       ),
        //       label: 'School',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(
        //         Icons.outlined_flag_rounded,
        //         color: Styles.gymyGrey,
        //       ),
        //       label: 'School',
        //     ),
        //   ],
        //   _selectedItem: _selectedItem,
        //   selectedItemColor: Colors.amber[800],
        //   onTap: _onItemTapped,
        // ),
        //////////////////////////////////////////////////////ButtomNavBar original

        ///////////////////////////////////////////////////////End Design1
        // bottomNavigationBar: BottomAppBar(
        //   elevation: 0.0,
        //   //bottom navigation bar on scaffold
        //   // color: Colors.redAccent,
        //   child: Row(
        //     //children inside bottom appbar
        //     mainAxisSize: MainAxisSize.max,
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.end,
        //     children: <Widget>[
        //       IconButton(
        //         icon: const Icon(
        //           Icons.home_outlined,
        //           color: Styles.gymyGrey,
        //         ),
        //         onPressed: () {},
        //       ),
        //       IconButton(
        //         icon: const Icon(
        //           Icons.person_outline_rounded,
        //           color: Styles.gymyGrey,
        //         ),
        //         onPressed: () {},
        //       ),
        //       SizedBox(
        //         height: 100.0,
        //         width: 100.0,
        //         child: IconButton(
        //           icon: const Icon(
        //             Icons.play_circle_fill_rounded,
        //             color: Colors.orangeAccent,
        //             size: 80.0,
        //           ),
        //           onPressed: () {},
        //         ),
        //       ),
        //       IconButton(
        //         icon: const Icon(
        //           Icons.phone_iphone_rounded,
        //           color: Styles.gymyGrey,
        //         ),
        //         onPressed: () {},
        //       ),
        //       IconButton(
        //         icon: const Icon(
        //           Icons.outlined_flag_rounded,
        //           color: Styles.gymyGrey,
        //         ),
        //         onPressed: () {},
        //       ),
        //     ],
        //   ),
        // ),
        ///////////////////////////////////////////////////////End Design1