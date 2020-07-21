import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../auth_screen.dart';

class CouponScreen extends StatefulWidget {
  static final routeName = 'coupon-screen';

  @override
  _CouponScreenState createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {
  var _user;

  void _loginPage(BuildContext ctx) async {
    final authUser = await Navigator.of(ctx).pushNamed(AuthScreen.routeName);

    setState(() {
      _user = authUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final height = mediaQueryData.size.height -
        (mediaQueryData.padding.top + mediaQueryData.padding.bottom + 50);

    return Scaffold(
        appBar: AppBar(
          title: Text('내 쿠폰함'),
        ),
        body: StreamBuilder<FirebaseUser>(
            stream: FirebaseAuth.instance.onAuthStateChanged,
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (!snapshot.hasData) {
                return Center(
                  child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text('로그인'),
                      onPressed: () => _loginPage(context)),
                );
              } else {
                return SafeArea(
                  child: SingleChildScrollView(
                      child: Column(children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      child: Text('미 사용 쿠폰'),
                      alignment: Alignment.centerLeft,
                    ),
                    ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemBuilder: (ctx, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: ClipRRect(
                            child: Image.asset('assets/images/americano.jpg'),
                          ),
                          title: Text('[스타벅스] 아이스 아메리카노'),
                          subtitle: Text('2020-07-12까지'),
                          trailing:
                              FlatButton(onPressed: null, child: Text('사용하기')),
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
                      itemBuilder: (ctx, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: ClipRRect(
                            child: Image.asset(
                              'assets/images/americano.jpg',
                              color: Colors.grey[50],
                              colorBlendMode: BlendMode.color,
                            ),
                          ),
                          title: Text(
                            '[스타벅스] 아이스 아메리카노',
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                          subtitle: Text('2020-07-12까지'),
                          trailing:
                              FlatButton(onPressed: null, child: Text('사용하기')),
                        ),
                      ),
                      itemCount: 5,
                    ),
                  ])),
                );
              }
            }));
  }
}
