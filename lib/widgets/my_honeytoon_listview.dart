import 'package:flutter/material.dart';
import '../helpers/db.dart';

class MyHoneytoonListView extends StatelessWidget {
  const MyHoneytoonListView({
    Key key,
    @required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: DB.getHoneytoonList(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          } else if(snapshot.hasData){
          return ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemBuilder: (_, index) {
                var data = snapshot.data.documents[index];
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: 
                        AspectRatio(
                          aspectRatio: 4/3,
                          child: FadeInImage( 
                            placeholder: AssetImage('assets/images/placeholder.png'),
                            image: NetworkImage(data["cover_img"]),
                            fit: BoxFit.cover,
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
                              Text('${data['title']}', style: TextStyle(fontSize:20,),),
                              Text((data['total_count'] == 0) ? "- 화": '${data['total_count']}화'),
                              Text('3일전'),
                            ]
                          ),
                        )),
                      Expanded(
                        flex: 1,
                        child: Icon(Icons.add))
                    ]
                  ),
                );
              },
              itemCount: snapshot.data.documents.length,
            );
          } else {
            return Center(
              child: Text('허니툰을 불러오는 데 실패했습니다. 잠시 후 다시 시도해주세요')
            );
          }

        }
      ),
    );
  }
}