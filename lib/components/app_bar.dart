import 'package:flutter/material.dart';
import 'package:travel_application/constants.dart';

// class CustomAppBar extends StatelessWidget {
//   final String title;
//   final bool hasBackArrow;
//   final bool hasTitle;
//   CustomAppBar({this.title, this.hasBackArrow, this.hasTitle});
//   @override
//   Widget build(BuildContext context) {
//     bool _hasBackArrow = hasBackArrow ?? false;

//     bool _hasTitle = hasTitle ?? true;
//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Colors.white, Colors.white],
//         ),
//       ),
//       padding: EdgeInsets.only(top: 56, left: 24, right: 24, bottom: 24),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           if (_hasBackArrow)
//             Container(
//               decoration: BoxDecoration(
//                 color: Color(0xff007580),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: IconButton(
//                 icon: Icon(Icons.arrow_back),
//                 color: Colors.white,
//                 onPressed: () {},
//               ),
//             ),
//           if (_hasTitle)
//             Text(
//               title ?? "Home page",
//               style: constant.boldHeading,
//             ),
//           Container(
//             decoration: BoxDecoration(
//               color: Color(0xff007580),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: IconButton(
//               icon: Icon(Icons.search),
//               color: Colors.white,
//               onPressed: () {},
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
Widget appBar(String title) {
  return AppBar(
    elevation: 0.0,
    title: Center(
      child: Padding(
        child: Text(
          title ?? "Home page",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
      ),
    ),
    actions: [
      Container(
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {},
            ),
          ],
        ),
      ),
    ],
  );
}
