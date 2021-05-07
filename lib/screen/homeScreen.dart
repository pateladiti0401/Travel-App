import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_application/auth/Start.dart';
import 'package:travel_application/components/app_bar.dart';
import 'package:travel_application/components/drawer.dart';
import 'package:travel_application/constants.dart';
import 'package:travel_application/screen/homePage.dart';
import 'package:travel_application/screen/subScreen/destinationPage.dart';
import 'package:travel_application/services/firebase_crud.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CrudMethods crudMethods = CrudMethods();
  //for authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isloggedIn = false;
  User user;

  bool _isLoading = true;

  get $ => null;

  checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Start()));
      }
    });
  }

  //check getuser

  @override
  void initState() {
    super.initState();
    this.checkAuthentification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Home page"),
      drawer: DrawerScreen(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 60.0),
              child: Text(
                "Find Your Best Place",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Row(
                children: [
                  Text(
                    "Featured Places",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black45,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Text(
                      'See All',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            //featured palces container
            FutureBuilder<QuerySnapshot>(
              future: crudMethods.desRefFeaturedPlaces.get(),
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
                    scrollDirection: Axis.horizontal,
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
                          height: 200,
                          margin: EdgeInsets.only(top: 80, right: 10),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                //child: Image.asset(imgData,
                                //"images/abd.png",
                                child: CachedNetworkImage(
                                    imageUrl: document.data()['imgURL'][0],
                                    filterQuality: FilterQuality.low,
                                    color: Colors.white.withOpacity(0.7),
                                    colorBlendMode: BlendMode.dst,
                                    height: 200,
                                    width: 170,
                                    fit: BoxFit.cover),
                              ),
                              Container(
                                height: 240,
                                width: 170,
                                child: Column(
                                  children: [
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 164, left: 6),
                                          //padding: EdgeInsets.only(top: 210),
                                          child: Text(
                                              document.data()['title'] ??
                                                  "Title",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14)),
                                        ),
                                        Spacer(),
                                        Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(
                                            top: 162,
                                            right: 4,
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              backgroundBlendMode:
                                                  BlendMode.colorDodge,
                                              color: Colors.white60),
                                          child: Row(
                                            children: [
                                              Text(
                                                document
                                                    .data()['rating']
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 12),
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
                                  ],
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
            Container(
              margin: EdgeInsets.only(top: 300),
              height: 25,
              child: Row(
                children: <Widget>[
                  Text(
                    "Popular Tours",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600),
                  ),
                  Spacer(),
                  GestureDetector(
                    // ignore: deprecated_member_use
                    // onTap: () {
                    //   Navigator.push(context,
                    //       MaterialPageRoute(builder: (context) => HomePage()));
                    // },

                    child: Text(
                      'See All',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //popular places container
            Container(
              margin: EdgeInsets.only(top: 340),
              child: FutureBuilder<QuerySnapshot>(
                future: crudMethods.desRefPopularPlaces.get(),
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
                            margin: EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                                color: Color(0xffE9F4F9),
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      bottomLeft: Radius.circular(20)),
                                  child: CachedNetworkImage(
                                    imageUrl: document.data()['imgURL'][0],
                                    width: 100,
                                    height: 90,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        document.data()['title'],
                                        overflow: TextOverflow.ellipsis,
                                        style: constant.regularHeading,
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Container(
                                        width: 200,
                                        child: Text(
                                          document.data()['desc'],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff89A097)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Column(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(
                                            bottom: 2, left: 2, right: 14),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Color(0xff007580)),
                                        child: Row(
                                          children: [
                                            Text(
                                              document
                                                  .data()['rating']
                                                  .toString(),
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              CupertinoIcons.star,
                                              color: Colors.white,
                                              size: 12,
                                            )
                                          ],
                                        )),
                                  ],
                                ),
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
          ],
        ),
      ),
    );
  }
}
