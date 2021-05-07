import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_application/components/app_bar.dart';
import 'package:travel_application/components/drawer.dart';
import 'package:travel_application/screen/subScreen/destinationPage.dart';
import 'package:travel_application/services/firebase_crud.dart';
import 'package:travel_application/constants.dart';
import 'package:travel_application/constants.dart';

class Bookmark extends StatefulWidget {
  @override
  _BookmarkState createState() => _BookmarkState();
}

class _BookmarkState extends State<Bookmark> {
  CrudMethods crudMethods = CrudMethods();
  // user ->userId (document)->save
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Bookmark"),
      drawer: DrawerScreen(),
      body: Container(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(50, 30, 0, 0),
              child: Text(
                "Your Favorite Place are here!!!",
                style: constant.boldHeading,
                textAlign: TextAlign.center,
              ),
            ),
            FutureBuilder<QuerySnapshot>(
              future: crudMethods.userRef
                  .doc(crudMethods.getUserId())
                  .collection("bookmark")
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error: ${snapshot.error}"),
                    ),
                  );
                }

                // Collection Data ready to display
                if (snapshot.connectionState == ConnectionState.done) {
                  // Display the data inside a list view
                  return ListView(
                    padding: EdgeInsets.only(
                      top: 60.0,
                      bottom: 12.0,
                    ),
                    children: snapshot.data.docs.map((document) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DestinationPage(
                                  destinationId: document.id,
                                ),
                              ));
                        },
                        child: FutureBuilder(
                          future:
                              crudMethods.destinationRef.doc(document.id).get(),
                          builder: (context, bookmarksnap) {
                            if (bookmarksnap.hasError) {
                              return Scaffold(
                                body: Container(
                                  child: Center(
                                    child: Text('${bookmarksnap.error}'),
                                  ),
                                ),
                              );
                            }

                            if (bookmarksnap.connectionState ==
                                ConnectionState.done) {
                              Map _bookmarkMap = bookmarksnap.data.data();

                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                margin: EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal: 15.0,
                                ),
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 5, top: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.black45.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomLeft: Radius.circular(8)),
                                        child: Image.network(
                                          "${_bookmarkMap['imgURL'][0]}",
                                          height: 220,
                                          width: 190,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        width: 170,
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _bookmarkMap['title'][0]
                                                      .toUpperCase() +
                                                  _bookmarkMap['title']
                                                      .substring(1),
                                              overflow: TextOverflow.ellipsis,
                                              style: constant.regularHeading,
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Container(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Type of Location: ${_bookmarkMap['type'][0]}"
                                                            .toUpperCase() +
                                                        _bookmarkMap['type']
                                                            .substring(1),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.black54),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              );
                            }

                            return Container(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                        ),
                      );
                    }).toList(),
                  );
                }

                // Loading State
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
