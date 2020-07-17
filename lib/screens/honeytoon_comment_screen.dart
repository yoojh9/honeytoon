import 'package:flutter/material.dart';

class HoneytoonCommentScreen extends StatefulWidget {
  static const routeName = '/comment';

  @override
  _HoneytoonCommentScreenState createState() => _HoneytoonCommentScreenState();
}

class _HoneytoonCommentScreenState extends State<HoneytoonCommentScreen> {
  final TextEditingController _textController = new TextEditingController();

  void _handleSubmitted(String text){
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final height = mediaQueryData.size.height - (kToolbarHeight + mediaQueryData.padding.top + mediaQueryData.padding.bottom);

    return Scaffold(
      appBar: AppBar(
        title: Text('댓글'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                height: height * 0.1,
                child: TextField(
                  controller: _textController,
                  onSubmitted: _handleSubmitted,
                  decoration: InputDecoration(
                    hintText: '댓글을 입력해주세요', 
                    suffixIcon: Icon(Icons.add)
                  ),
                ),
              ),
              Container(
                height: height * 0.75,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  itemBuilder: (ctx, index) => ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 6),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/images/one.jpg'),
                    ),
                    title: Container(
                      child: Row(
                        children: <Widget>[
                          Text('유저혀', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          SizedBox(width: 25,),
                          Text('20.07.12 05:51', style: TextStyle(color: Colors.grey))
                      ],)
                    ),
                    subtitle: Text('재밌어요', style: TextStyle(color: Colors.grey, fontSize: 16),),
                  ),
                  itemCount: 7,
                ),
              )
            ]
          ),
        )
      
      )
    );
  }
}