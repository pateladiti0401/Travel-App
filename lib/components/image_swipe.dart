import 'package:flutter/material.dart';

class ImageSwipe extends StatefulWidget {
  final List imageList;
  ImageSwipe({this.imageList});
  @override
  _ImageSwipeState createState() => _ImageSwipeState();
}

class _ImageSwipeState extends State<ImageSwipe> {
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
          color: Colors.black45.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          children: [
            PageView(
              onPageChanged: (num) {
                setState(() {
                  selectedPage = num;
                });
              },
              children: [
                for (var i = 0; i < widget.imageList.length; i++)
                  Container(
                    child: Image.network(
                      "${widget.imageList[i]}",
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
              ],
            ),
            Positioned(
              bottom: 15,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < widget.imageList.length; i++)
                    AnimatedContainer(
                      duration: Duration(
                        milliseconds: 250,
                      ),
                      curve: Curves.easeInCubic,
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      width: selectedPage == i ? 40.0 : 10.0,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
