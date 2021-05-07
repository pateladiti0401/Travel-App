import 'package:flutter/material.dart';

class DirectionList extends StatefulWidget {
  final List directionList;
  DirectionList({this.directionList});
  @override
  _DirectionListState createState() => _DirectionListState();
}

class _DirectionListState extends State<DirectionList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          for (var i = 0; i < widget.directionList.length; i++)
            Container(
              child: Column(
                children: [
                  if (i == 0)
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        children: [
                          Text(
                            "Distance from Airpot :",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.flight),
                        ],
                      ),
                    ),
                  if (i == 1)
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        children: [
                          Text(
                            "Distance from Railway Station :",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.directions_railway_sharp)
                        ],
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 8),
                    child: Column(
                      children: [
                        Text(
                          "${widget.directionList[i]}",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
