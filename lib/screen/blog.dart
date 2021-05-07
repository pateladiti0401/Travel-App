/**
 * HTML elements and other resources for web-based applications that need to
 * interact with the browser and the DOM (Document Object Model).
 *
 * This library includes DOM element types, CSS styling, local storage,
 * media, speech, events, and more.
 * To get started,
 * check out the [Element] class, the base class for many of the HTML
 * DOM types.
 *
 * For information on writing web apps with Dart, see https://dart.dev/web.
 *
 * {@category Web}
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:travel_application/components/app_bar.dart';
import 'package:travel_application/components/drawer.dart';
import 'package:travel_application/screen/subScreen/createBlog.dart';
import 'package:travel_application/screen/subScreen/showBlog.dart';
import 'package:travel_application/services/firebase_crud.dart';
import 'package:travel_application/constants.dart';

class BlogPage extends StatefulWidget {
  @override
  _BlogPageState createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  CrudMethods crudMethods = CrudMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Blog"),
      drawer: DrawerScreen(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: Container(
                margin: EdgeInsets.only(top: 7),
                child: FutureBuilder<QuerySnapshot>(
                  future: crudMethods.blogRef.get(),
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
                                  builder: (context) => ShowBLog(
                                    blogId: document.id,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 5, top: 10),
                              decoration: BoxDecoration(
                                  color: Colors.black45.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        bottomLeft: Radius.circular(8)),
                                    child: Image.network(
                                      document.data()['imgURL'],
                                      width: 175,
                                      height: 160,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    width: 200,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          document
                                                  .data()['title'][0]
                                                  .toUpperCase() +
                                              document
                                                  .data()['title']
                                                  .substring(1),
                                          overflow: TextOverflow.ellipsis,
                                          style: constant.regularHeading,
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Container(
                                          child: Text(
                                            document
                                                    .data()['authorName'][0]
                                                    .toUpperCase() +
                                                document
                                                    .data()['authorName']
                                                    .substring(1),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black54),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            document.data()['date'],
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black54),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            document.data()['time'],
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black54),
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
      floatingActionButton: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 25, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreateBlog()));
                },
                child: Icon(Icons.add),
                backgroundColor: Color(0xff007580),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BlogTiles extends StatelessWidget {
  String imgURL, title, description, authorName, date, time;

  BlogTiles(
      {@required this.imgURL,
      @required this.title,
      @required this.description,
      @required this.authorName,
      @required this.date,
      @required this.time});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5, top: 10),
      decoration: BoxDecoration(
          color: Colors.black45.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
            child: CachedNetworkImage(
              imageUrl: imgURL,
              width: 175,
              height: 160,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: 200,
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title[0].toUpperCase() + title.substring(1),
                  overflow: TextOverflow.ellipsis,
                  style: constant.regularHeading,
                ),
                SizedBox(
                  height: 3,
                ),
                Container(
                  child: Text(
                    authorName[0].toUpperCase() + authorName.substring(1),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54),
                  ),
                ),
                Container(
                  child: Text(
                    date,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54),
                  ),
                ),
                Container(
                  child: Text(
                    time,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.black54),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
