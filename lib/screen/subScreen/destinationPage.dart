import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_application/components/app_bar.dart';
import 'package:travel_application/components/direction_list.dart';
import 'package:travel_application/components/image_swipe.dart';
import 'package:travel_application/screen/map.dart';
import 'package:travel_application/services/firebase_crud.dart';

class DestinationPage extends StatefulWidget {
  final String destinationId;
  DestinationPage({this.destinationId});
  @override
  _DestinationPageState createState() => _DestinationPageState();
}

class _DestinationPageState extends State<DestinationPage> {
  CrudMethods crudMethods = CrudMethods();

  Future addToBokomark() {
    return crudMethods.userRef
        .doc(crudMethods.getUserId())
        .collection("bookmark")
        .doc(widget.destinationId)
        .set({"count": 1});
  }

  final SnackBar _snakbar = SnackBar(
    content: Text("Successfully added to the bookmark"),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(""),
      body: Stack(
        children: <Widget>[
          FutureBuilder(
            future: crudMethods.destinationRef.doc(widget.destinationId).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error : ,${snapshot.error}"),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                //firebase document data of map
                Map<String, dynamic> documentData = snapshot.data.data();

                //from map retrive image data into list
                List imageList = documentData['imgURL'];

                List directionList = documentData['distance'];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: ListView(
                    children: [
                      ImageSwipe(
                        imageList: imageList,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Container(
                              width: 200,
                              child: Text("${documentData['title']}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ),
                            Spacer(),
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  backgroundBlendMode: BlendMode.colorDodge,
                                  color: Colors.white60),
                              child: Row(
                                children: [
                                  Text(
                                    "Rating: ${documentData['rating'].toString()}" ??
                                        "4.4",
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 17),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Icon(
                                    CupertinoIcons.star,
                                    color: Colors.black54,
                                    size: 14,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Description: ",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 18),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 15),
                        child: Text(
                          documentData['desc'],
                          textAlign: TextAlign.justify,
                          style: TextStyle(),
                        ),
                      ),
                      DirectionList(
                        directionList: directionList,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(vertical: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await addToBokomark();
                                Scaffold.of(context).showSnackBar(_snakbar);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 20),
                                height: 90,
                                width: 170,
                                decoration: BoxDecoration(
                                    color: Color(0xff007580),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.bookmark,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Bookmark",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MapView(
                                        destination: documentData['title']),
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 20),
                                alignment: Alignment.center,
                                height: 90,
                                width: 170,
                                decoration: BoxDecoration(
                                    color: Color(0xff007580),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Direction",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
