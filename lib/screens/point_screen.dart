import 'package:flutter/material.dart';
import './coupon_screen.dart';

class PointScreen extends StatelessWidget {

  void _tapMyCouponBtn(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(CouponScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final height = mediaQueryData.size.height - (kToolbarHeight + kTextTabBarHeight + kBottomNavigationBarHeight);

    return Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              alignment: Alignment.center,
              height: height * 0.4,
              child: 
                Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          Text('나의 꿀단지', 
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            )
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: 
                              [
                                Text('45', 
                                  style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text('꿀', 
                                  style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ]
                          ),
                        ]
                      )
                    ),
                    Expanded(
                      flex: 5,
                      child:
                       Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/honey_pot.png'),
                            fit: BoxFit.contain)
                        ),
                        child: null,
                      ),
                  ),
                  Expanded(
                    flex:1,
                    child: Container(
                        margin: EdgeInsetsDirectional.only(end: 20),
                        alignment: Alignment.centerRight,
                        child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)
                          ),
                          child: Text('내 쿠폰함'),
                          onPressed: (){ _tapMyCouponBtn(context); }, 
                        ),
                    )
                  ),
                ]
              ),
            ),
            SingleChildScrollView(
              child:  Container(
              height: height * 0.5,
              child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemBuilder: (ctx, index) => 
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile( 
                      leading: CircleAvatar(
                        child: ClipRRect(
                          borderRadius:BorderRadius.circular(50),
                          child: Image.asset('assets/images/honey_pot.png'),
                        )
                      ),
                      title: Text('10꿀'),
                      subtitle: Text('2020-07-08'),
                    ),
                  ),            
                itemCount: 5,
              ),
            ),
            )
          ]
        );
  }
}
