import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_application/Services/auth.dart';
import 'package:time_tracker_application/Services/database.dart';
import 'package:time_tracker_application/widgets/platoform_exception_alert_dialog.dart';

 import 'package:time_tracker_application/app/home/models/job.dart';



class JobsPage extends StatelessWidget {

  Future<void>  _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context);
      await auth.signOut();
    }
    catch (e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home : Scaffold(
        appBar: AppBar(
          title:Text('Jobs'),
          actions: <Widget>[
            FlatButton(
              child: Text('Logout',style: TextStyle(fontSize: 15.0,color:Colors.white),),
              onPressed: () => _signOut(context),
            )

          ],
        ),
          floatingActionButton: FloatingActionButton(onPressed:() => _createJob(context),child: Icon(Icons.add),),
      ),
    );
  }

  Future<void> _createJob(BuildContext context) async{
    try {
      final database = Provider.of<Database>(context);
      await database.createJob(Job(name:'Gaming', ratePerHour:5));
    }
    on PlatformException catch (e){
      PlatformExceptionAlertDialog(
        title: 'Operation failed',
        exception: e,
      ).show(context);
    }
  }
}
