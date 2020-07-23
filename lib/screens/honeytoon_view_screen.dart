import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './honeytoon_comment_screen.dart';

class HoneytoonViewScreen extends StatefulWidget {
  static final routeName = 'honeytoon-view';

  @override
  _HoneytoonViewScreenState createState() => _HoneytoonViewScreenState();
}

class _HoneytoonViewScreenState extends State<HoneytoonViewScreen> with SingleTickerProviderStateMixin{
  ScrollController _scrollController;
  var _isVisible = true;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if(_scrollController.position.userScrollDirection == ScrollDirection.reverse && _isVisible){
        setState(() {
          _isVisible = false;
        });
      }
      if(_scrollController.position.userScrollDirection == ScrollDirection.forward && !_isVisible){
        setState(() {
          _isVisible = true;
        });
      }
    });
  }

  void _onTap(BuildContext context, int index){
    setState(() {
      print(index);
      if(index==1){
        Navigator.of(context).pushNamed(HoneytoonCommentScreen.routeName);
      }
    });
  }

  Widget buildImage(List<String> images){
    return Container(
      child: Column(
          children: 
            images.map((image) => CachedNetworkImage(
              imageUrl: image,
              placeholder: (context, url) => Image.asset('assets/images/image_spinner.gif'),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover
            )).toList()
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    final mediaQueryData = MediaQuery.of(context);
    final height = mediaQueryData.size.height - (mediaQueryData.padding.top + mediaQueryData.padding.bottom + 160 );

    return Scaffold(
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              expandedHeight: 30,
              backgroundColor: Colors.transparent,
              floating: false,
              pinned: false,
              leading: IconButton(icon: Icon(Icons.list), onPressed: (){Navigator.of(context).pop();}),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text('${args['times']}화', style: TextStyle(fontSize:20),),
              ),
            ),
 
            SliverList(
              delegate: SliverChildListDelegate([
                buildImage(args['images'])
              ])
            )
           
          ]
        ),
        bottomNavigationBar: 
        
        AnimatedContainer(
            duration: Duration(milliseconds: 500),
            height: _isVisible ? 60 : 0,
            child: _isVisible
            ? Wrap(
                children: [ BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(icon: Icon(Icons.arrow_back), title: Text('이전화')),
                  BottomNavigationBarItem(icon: Icon(Icons.mode_comment), title: Text('댓글')),
                  BottomNavigationBarItem(icon: Icon(Icons.arrow_forward), title: Text('다음화')),
                ],
                currentIndex: _currentIndex,
                onTap: (index) {
                  _onTap(context, index);
                },
                ),
              ]
            ) 
            : Container(
              color: Colors.transparent,
              width: mediaQueryData.size.width
            )
        ), 

      );
  }
}