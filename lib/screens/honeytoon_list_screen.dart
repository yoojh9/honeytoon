import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../helpers/db.dart';
import './honeytoon_detail_screen.dart';
import '../widgets/honeytoon_list_header.dart';
import '../widgets/honeytoon_list_sort.dart';

class HoneyToonListScreen extends StatefulWidget {
  @override
  _HoneyToonListScreenState createState() => _HoneyToonListScreenState();
}

class _HoneyToonListScreenState extends State<HoneyToonListScreen> {
  void _onTabEvent(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(HoneytoonDetailScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final height = mediaQueryData.size.height -
        (kToolbarHeight +
            kBottomNavigationBarHeight +
            mediaQueryData.padding.top +
            mediaQueryData.padding.bottom);

    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(children: <Widget>[
              HoneytoonListHeader(height: height),
              HoneytoonListSort(),
              Container(
                margin: EdgeInsets.only(top: 16),
                height: height * 0.6,

                child: StreamBuilder(
                    stream: DB.getHoneytoonList(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasData) {
                        return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: 8 / 10),
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (_, index) {
                              var data = snapshot.data.documents[index];
                              return Card(
                                clipBehavior: Clip.antiAlias,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    AspectRatio(
                                      aspectRatio: 4 / 3,
                                      child: CachedNetworkImage(
                                        imageUrl: data["cover_img"],
                                        placeholder: (context, url) => Image.asset(
                                            'assets/images/image_spinner.gif'),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Expanded(
                                        child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text("${data['title']}",
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        fontSize: 16)),
                                                Text(
                                                  "${data['displayName']}",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.grey),
                                                )
                                                // Text('제목2')
                                              ],
                                            )))
                                  ],
                                ),
                              );
                            });

                        // GridView.count(
                        //   crossAxisCount: 3,
                        //   //crossAxisSpacing: 3,
                        //   //mainAxisSpacing: 3,
                        //   childAspectRatio: 8.0 / 10,
                        //   children: Card(
                        //     clipBehavior: Clip.antiAlias,
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: <Widget>[
                        //         AspectRatio(
                        //           aspectRatio: 4/3,
                        //           child: Image.network("${futureSnapshot.data['coverImgUrl']}",
                        //             fit: BoxFit.cover
                        //           )
                        //         ),
                        //         Expanded(
                        //           child: Padding(
                        //             padding: EdgeInsets.all(10),
                        //             child: Column(
                        //           crossAxisAlignment: CrossAxisAlignment.start,
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           children: <Widget>[
                        //             Text("${futureSnapshot.data['title']}", maxLines: 1, style: TextStyle(fontSize: 16)),
                        //             Text("${futureSnapshot.data['displayName']}", style: TextStyle(fontSize: 14, color: Colors.grey),)
                        //           // Text('제목2')
                        //           ],
                        //             )
                        //           )
                        //         )
                        //       ],
                        //     ),
                        //   );
                        // )
                      } else {
                        return Center(
                            child: Text('허니툰을 불러오는 데 실패했습니다. 잠시 후 다시 시도해주세요'));
                      }
                    }),

                // child: GridView.count(
                //   crossAxisCount: 3,
                //   //crossAxisSpacing: 3,
                //   //mainAxisSpacing: 3,
                //   childAspectRatio: 8.0 / 10,

                //   children:
                //     [
                //     FutureBuilder(
                //     future: DB.getHoneytoonList(),
                //     builder: (context, futureSnapshot){
                //       print(futureSnapshot.data);
                //       if(futureSnapshot.connectionState == ConnectionState.waiting){
                //         return Center(
                //           child: CircularProgressIndicator()
                //         );
                //       } else if(futureSnapshot.hasData){
                //         return Card(
                //           clipBehavior: Clip.antiAlias,
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: <Widget>[
                //               AspectRatio(
                //                 aspectRatio: 4/3,
                //                 child: Image.network("${futureSnapshot.data['coverImgUrl']}",
                //                   fit: BoxFit.cover
                //                 )
                //               ),
                //               Expanded(
                //                 child: Padding(
                //                   padding: EdgeInsets.all(10),
                //                   child: Column(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 mainAxisAlignment: MainAxisAlignment.center,
                //                 children: <Widget>[
                //                   Text("${futureSnapshot.data['title']}", maxLines: 1, style: TextStyle(fontSize: 16)),
                //                   Text("${futureSnapshot.data['displayName']}", style: TextStyle(fontSize: 14, color: Colors.grey),)
                //                 // Text('제목2')
                //                 ],
                //                   )
                //                 )
                //               )
                //             ],
                //           ),
                //         );
                //       } else {
                //         return Center(
                //           child: Text('허니툰을 불러오는 데 실패했습니다. 잠시 후 다시 시도해주세요')
                //         );
                //       }
                //     },
                //   ),
                // ]
                // ),
              )
            ])

            // Expanded(
            //   child: GridView.count(
            //     crossAxisCount: 2,
            //     crossAxisSpacing: 5,
            //     mainAxisSpacing: 5,
            //     children: _listItem.map((item) => GestureDetector(
            //       onTap: (){_onTabEvent(context);},
            //         child: Card(
            //           color: Colors.transparent,
            //           elevation: 0,
            //           child: Container(
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(20),
            //               image: DecorationImage(
            //                 image: AssetImage(item),
            //                 fit: BoxFit.cover
            //               )
            //             ),
            //             child:

            //             Transform.translate(
            //               offset: Offset(50, -50),
            //               child: Container(
            //                 //margin: EdgeInsets.symmetric(horizontal: 65, vertical: 63),
            //                 // decoration: BoxDecoration(
            //                 //   borderRadius: BorderRadius.circular(10),
            //                 //   color: Colors.white
            //                 // ),
            //                 child: Text('제목', style: TextStyle(color: Colors.white),)
            //                 //child: Icon(Icons.bookmark_border, size: 15,),
            //               ),
            //             ),
            //           ),
            //         ),
            //     )).toList(),
            //   )
            // ),
            // ],
            // ),
            ),
      ),
    );
  }
}
