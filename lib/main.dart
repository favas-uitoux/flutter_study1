import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_ui/firebase_auth_ui.dart';
import 'package:firebase_auth_ui/providers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study1/state/state_management.dart';


Future<void> main() async {
WidgetsFlutterBinding.ensureInitialized();
Firebase.initializeApp();
  runApp(    ProviderScope(child: MaterialApp(home: MyApp())));
//  runApp(    ProviderScope(child: MyApp() ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalKey<ScaffoldState> scaffoldstate=new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldstate,
      appBar: AppBar(
        title: Text("Study1"),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('asset/images/my_bg.png'),
            fit: BoxFit.contain,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton.icon(
                 onPressed: () => attempt_login(context),

                icon: Icon(
                  Icons.phone,
                  color: Colors.white,
                ),
                label: Text(
                  'Login with phone no',
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black)),
              ),
            )
          ],
        ),
      ),
    );
  }

  attempt_login(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;

    if(user==null)
      {
        //user not login, show login
        FirebaseAuthUi.instance().launchAuth([AuthProvider.phone()]).
        then((firebaseuser){
          //refresh state
          context.read(user_logged).state=FirebaseAuth.instance.currentUser;
          print('user login ok');

        }).catchError((e){
          if(e is PlatformException)
            if(e.code==FirebaseAuthUi.kUserCancelledError)
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${e.message}')));

              print('user login ok');


        });

      }
    else{
      //user already login, show homepage

    }
  }
}
