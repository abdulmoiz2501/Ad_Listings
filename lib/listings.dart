import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:listings/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class Listings extends StatefulWidget {
  const Listings({Key? key}) : super(key: key);

  @override
  State<Listings> createState() => _ListingsState();
}

class _ListingsState extends State<Listings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          centerTitle: true,
          backgroundColor: kOrange,
          title: Text(
            'Listings',
            style: TextStyle(
              color: kTextColor,
            ),
          ),
        ),
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        child: new Column(
          children: [
            SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 15,
            ),

            // ),

            SizedBox(
              height: 4,
            ),

            Expanded(
                child: FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance.collection('Ads').get(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final List<DocumentSnapshot> documents =
                            snapshot.data!.docs;
                        if (snapshot.data != null) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView(
                                children: documents
                                    .map((doc) => Card(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border:
                                                  Border.all(color: kContrast),
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (ctx) => AlertDialog(
                                                    title: Column(
                                                      children: [
                                                        Align(
                                                            //Container to show picture HERE
                                                            ),
                                                        Row(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Container(
                                                              child:
                                                                  Image.network(
                                                                doc['image'],
                                                                fit: BoxFit
                                                                    .cover,
                                                                height: 200,
                                                                width: 200,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                              ),
                                                            ),
                                                            Align(
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  Navigator.of(
                                                                          ctx)
                                                                      .pop();
                                                                },
                                                                child: Icon(
                                                                  Icons.close,
                                                                  color:
                                                                      kPrimaryColor,
                                                                ),
                                                              ),
                                                              alignment: Alignment
                                                                  .topRight,
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 5,),
                                                        Align(
                                                          child: Container(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(3.0),
                                                              child: Text(
                                                                doc["title"],
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black54,
                                                                  fontSize: 23,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          alignment: Alignment
                                                              .centerLeft,
                                                        ),
                                                      ],
                                                    ),
                                                    content: Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              3,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Column(
                                                        children: [
                                                          SizedBox(
                                                            height: 3,
                                                          ),
                                                          Container(
                                                            child: Align(
                                                              alignment: Alignment.centerLeft,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                            0.0),
                                                                child: Text(
                                                                  doc["description"],
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black54,
                                                                        fontSize: 15,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 9,
                                                          ),
                                                              Align(
                                                                child: Container(
                                                                  child: Padding(
                                                                    padding:
                                                                    const EdgeInsets
                                                                        .all(3.0),
                                                                    child: Text(
                                                                      "Price: "+
                                                                      doc["price"],
                                                                      style:
                                                                      TextStyle(
                                                                        color: Colors
                                                                            .black54,
                                                                        fontSize: 15,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                              ),
                                                          SizedBox(
                                                            height: 9,
                                                          ),
                                                              Align(
                                                                child: Container(
                                                                  child: Padding(
                                                                    padding:
                                                                    const EdgeInsets
                                                                        .all(0.0),
                                                                    child: TextButton(
                                                                      onPressed: () => launch("tel://${doc["Phone"]}"),
                                                                      child: Text(
                                                                        "Contact: "+
                                                                        doc["Phone"],
                                                                        style:
                                                                        TextStyle(
                                                                          color: Colors
                                                                              .black54,
                                                                          fontSize: 15,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                              ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Column(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.black87,
                                                      border: Border.all(
                                                          color: kContrast),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(
                                                                12.0),
                                                        topLeft:
                                                            Radius.circular(
                                                                12.0),
                                                      ),
                                                    ),
                                                    child: doc['image'] == null
                                                        ? Center(
                                                            child: Text(
                                                              "No Image",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 24,
                                                              ),
                                                            ),
                                                          )
                                                        : Image.network(
                                                            doc['image'],
                                                            fit: BoxFit.cover,
                                                            height:
                                                                double.infinity,
                                                            width:
                                                                double.infinity,
                                                            alignment: Alignment
                                                                .center,
                                                          ),
                                                    height: 150,
                                                    width: double.infinity,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        doc['title'],
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.black87,
                                                          // fontFamily: "Montserrat Medium",
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(6.0),
                                                        child: Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              "Click for more information",
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black54,
                                                              ),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ))
                                    .toList()),
                          );
                        } else {
                          return Text('no data');
                        }
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                kPrimaryColor),
                          ),
                        );
                      }
                    })),
          ],
        ),
      ),
    );
  }
}
