import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HoneytoonFavoriteScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final height = mediaQueryData.size.height - (mediaQueryData.padding.top + mediaQueryData.padding.bottom);

    return SingleChildScrollView(
      child: ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemBuilder: (ctx, index) => 
            Padding(padding: const EdgeInsets.all(16),
            child: Container(
              height: height * 0.15,
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('단짠남녀', style: TextStyle(fontSize:20,),),
                        Text('102화'),
                        Text('3일전')
                      ]

                    )),

                  Expanded(
                    flex: 2,
                    child:  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/two.jpg'),
                        fit: BoxFit.cover,
                      )
                    ),
                  ),),

                ]
              ),
            ),
          ),
          itemCount: 6,
        )
    );
  }
}