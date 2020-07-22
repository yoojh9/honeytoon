import 'package:flutter/material.dart';
import './add_contentmeta_screen.dart';
import '../auth_screen.dart';
import '../../widgets/my_honeytoon_listview.dart';
import '../../widgets/my_honeytoon_info.dart';
import 'package:provider/provider.dart';
import '../../providers/auth.dart';

class HoneytoonMyScreen extends StatelessWidget {

  Future<void> _loginPage(BuildContext ctx) async {
    await Navigator.of(ctx).pushNamed(AuthScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final height = mediaQueryData.size.height -
        (mediaQueryData.padding.top + mediaQueryData.padding.bottom + 50);

    return FutureBuilder(
        future: Provider.of<Auth>(context, listen: false).getUserFromDB(),
        builder: (context, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (futureSnapshot.hasData) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(children: [
                  MyHonetoonInfo(height: height, user: futureSnapshot.data),
                  FlatButton.icon(
                    icon: Icon(Icons.add, color: Colors.grey,),
                    label: Text('작품 추가', style: TextStyle(color: Colors.grey),),
                    onPressed: (){
                      Navigator.of(context).pushNamed(AddContentMetaScreen.routeName);
                    },
                  ),
                  MyHoneytoonListView(height: height),
                ]),
              ),
            );
          } else {
            return Scaffold(
                body: Center(
              child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text('로그인'),
                  onPressed: () => _loginPage(context)),
            ));
          }
        });
  }
}
