import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helpers/db.dart';
import '../screens/my/add_content_screen.dart';
import '../providers/honeytoon_meta_provider.dart';

class MyHoneytoonListView extends StatelessWidget {
  const MyHoneytoonListView({
    Key key,
    @required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    HoneytoonMetaProvider _metaProvider = Provider.of<HoneytoonMetaProvider>(context);

    return Container(
      child: FutureBuilder(
          future: _metaProvider.getHoneytoonMetaList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  print('snapshot.data: ${snapshot.data[index]}');
                  var data = snapshot.data[index];
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Row(children: [
                      Expanded(
                        flex: 2,
                        child: AspectRatio(
                            aspectRatio: 4 / 3,
                            child: CachedNetworkImage(
                              imageUrl: data.coverImgUrl,
                              placeholder: (context, url) => Image.asset('assets/images/image_spinner.gif'),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                              fit: BoxFit.cover
                            )
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '${data.title}',
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text((data.totalCount == 0)
                                      ? "- 화"
                                      : '${data.totalCount}화'),
                                  Text('3일전'),
                                ]),
                          )),
                      Expanded(
                          flex: 1,
                          child: IconButton(
                              icon: Icon(
                                Icons.add,
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(AddContentScreen.routeName, arguments: {'id': data.workId, 'title': data.title, 'total': data.totalCount});
                              }))
                    ]),
                  );
                },
                itemCount: snapshot.data.length,
              );
            } else {
              return Center(child: Text('허니툰을 불러오는 데 실패했습니다. 잠시 후 다시 시도해주세요'));
            }
          }),
    );
  }
}
