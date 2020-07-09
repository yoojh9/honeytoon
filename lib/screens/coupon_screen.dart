import 'package:flutter/material.dart';

class CouponScreen extends StatelessWidget {
  static final routeName = 'coupon-screen';
  
  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final height = mediaQueryData.size.height - (mediaQueryData.padding.top + mediaQueryData.padding.bottom + 50);

    return Scaffold(
      appBar: AppBar(
        title: Text('내 쿠폰함'),
      ),
      body: 
        SafeArea(child: SingleChildScrollView(
        child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Text('미 사용 쿠폰'), 
                alignment: Alignment.centerLeft,
              ),
              ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemBuilder: (ctx, index) => 
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: ClipRRect(
                        child: Image.asset('assets/images/americano.jpg'),
                      ),
                      title: Text('[스타벅스] 아이스 아메리카노'),
                      subtitle: Text('2020-07-12까지'),
                      trailing: FlatButton(onPressed: null, child: Text('사용하기')),
                    ),
                  ),            
                itemCount: 2,
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Text('사용 완료 | 유효기간 만료'), 
                alignment: Alignment.centerLeft,
              ),
              ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) => 
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: ClipRRect(
                          child: 
                           Image.asset('assets/images/americano.jpg', color: Colors.grey[50], colorBlendMode: BlendMode.color,),
                        ),
                        title: Text('[스타벅스] 아이스 아메리카노', style: TextStyle(color: Colors.grey, fontSize: 15),),
                        subtitle: Text('2020-07-12까지'),
                        trailing: FlatButton(onPressed: null, child: Text('사용하기')),
                      ),
                    ),            
                  itemCount: 5,
              ),
          ]
        )
        ),
      )
    );
  }
}