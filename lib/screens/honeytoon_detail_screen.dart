import 'package:flutter/material.dart';
import 'package:honeytoon/screens/honeytoon_view_screen.dart';


class HoneytoonDetailScreen extends StatelessWidget {
  static final routeName = 'honeytoon-detail';

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final height = mediaQueryData.size.height - (mediaQueryData.padding.top + mediaQueryData.padding.bottom);

    return Scaffold(
  
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){Navigator.of(context).pop();}),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: (){},
          )
        ],
        
      ),
      body: SafeArea( 
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: mediaQueryData.size.height * 0.4,
                      child: Column(children: <Widget>[
                        Expanded(
                          flex: 2,
                          child :Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage('assets/images/two.jpg'),
                              )
                            ),
                          )
                        ),                      
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('단짠남녀', style: TextStyle(fontSize: 20),),
                              Text('이노우, 근영'),
                            ]
                          ),
                        ),
                      ],)
                    ),
                    Container(
                      child: GridView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: 10,
                        itemBuilder: (ctx, index) => ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: GridTile(
                            child: GestureDetector(
                              onTap: (){ Navigator.of(context).pushNamed(HoneytoonViewScreen.routeName); },
                              child: Image.asset('assets/images/three.jpg', fit: BoxFit.cover),
                            ),
                            footer: GridTileBar(
                              backgroundColor: Colors.white70,
                              title: Text('${index}화', textAlign: TextAlign.start, style: TextStyle(color: Colors.black),),
                              subtitle: Text('20.07.04', style: TextStyle(color: Colors.black45),),
                            ),
                          ),
                            
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1.5/2, 
                          crossAxisSpacing: 5, 
                          mainAxisSpacing: 5
                        ),
                    ),
                    )
                  ]
              ),
            ),
          )
          
          

      )
    );
  }
}