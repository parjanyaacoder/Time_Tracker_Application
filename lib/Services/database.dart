import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:time_tracker_application/Services/api_path.dart';
import 'package:time_tracker_application/app/home/models/job.dart';
abstract class Database {
  Future<void> createJob(Job job);
}

class FirestoreDatabase implements Database {
  @required final String uid;

  Future<void> _setData ({String path, Map<String, dynamic> data}) async {
  final reference = Firestore.instance.document(path);
  await reference.setData(data); }
 FirestoreDatabase({ this.uid}) : assert (uid!=null);


 Future<void> createJob(Job job) async => await _setData (path:APIPath.job(uid, 'job_abc'),data:job.toMap());
}