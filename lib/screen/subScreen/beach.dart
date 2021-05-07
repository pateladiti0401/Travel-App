import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_application/components/app_bar.dart';
import 'package:travel_application/constants.dart';
import 'package:travel_application/screen/subScreen/destinationPage.dart';
import 'package:travel_application/services/firebase_crud.dart';

class BeachScreen extends StatefulWidget {
  @override
  _BeachScreenState createState() => _BeachScreenState();
}

class _BeachScreenState extends State<BeachScreen> {
  CrudMethods crudMethods = CrudMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Beaches"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Text(
              'Beaches',
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.w600,
                color: Color(0xff007580),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: Container(
                margin: EdgeInsets.only(top: 30),
                child: FutureBuilder<QuerySnapshot>(
                  future: crudMethods.desRefBeach.get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Scaffold(
                        body: Center(
                          child: Text("Error : ,${snapshot.error}"),
                        ),
                      );
                    }

                    //collection data ready to display

                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: ClampingScrollPhysics(),
                        children: snapshot.data.docs.map((document) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DestinationPage(
                                    destinationId: document.id,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black12.withBlue(5),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              height: 385.0,
                              margin: EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 24.0,
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    height: 280.0,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          topRight: Radius.circular(12)),
                                      child: Image.network(
                                        document.data()['imgURL'][0],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          5, 20, 24, 24),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 300,
                                            height: 60,
                                            child: Text(
                                              document.data()['title'] ??
                                                  "Title",
                                              style: constant.boldHeading,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }
                    return Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
