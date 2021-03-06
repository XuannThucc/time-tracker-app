import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../models/entry.dart';
import '../models/job.dart';
import 'firestore_services.dart';
import 'api_path.dart';

abstract class Database {
  Future<void> setJobs(Job job);

  Stream<List<Job>> jobsStream();

  Future<void> delete(Job job);

  Future<void> setEntry(Entry entry);

  Future<void> deleteEntry(Entry entry);

  Stream<List<Entry>> entriesStream({Job job});
}
String documentIdFromCurrentDate() => DateTime.now().toIso8601String();
class FirebaseDatabase implements Database {
  FirebaseDatabase({
    @required this.uid,
  }) : assert(uid != null);
  final String uid;
  final _services = FirestoreService.instance;

  Future<void> delete(Job job) async => _services.delete(path: APIPath.job(uid, job.id));
  Stream<List<Job>> jobsStream() => _services.collectionStream(
      path: APIPath.jobs(uid), builder: (data, documentId) => Job.fromMap(data, documentId));

  // {
  //   final path = APIPath.jobs(uid);
  //   final reference = Firestore.instance.collection(path);
  //   final snapshots = reference.snapshots();
  //   return snapshots.map(
  //     //tao map qua luong snapshot va moi muc ben trong map la mot collection (snapshot)
  //     (snapshot) => snapshot.documents
  //         .map(
  //           //truy cap tai lieu ben collection (snapshot) va goi map de convert map vao mot danh sach Job
  //           (snapshot) => Job.fromMap(snapshot.data),
  //         ).toList());
  //   // snapshots.listen((event) {event.documents.forEach((element) {print(element.data);});});
  // }

  Future<void> setJobs(Job job) async
      // {
      //   final path = APIPath.job(uid, 'job_123');
      //
      //   final documentReference = Firestore.instance.document(path);  //tham chieu tai lieu
      //   //ghi du lieu vao vi tri tham chieu
      //   await documentReference.setData(job.toMap());
      // }
      =>
      await _setData(path: APIPath.job(uid,job.id ), data: job.toMap());

  Future<void> _setData({String path, Map<String, dynamic> data}) async {
    final reference = Firestore.instance.document(path);
    await reference.setData(data);
  }

  //Entry
  @override
  Future<void> setEntry(Entry entry) async => await _services.setData(
    path: APIPath.entry(uid, entry.id),
    data: entry.toMap(),
  );

  @override
  Future<void> deleteEntry(Entry entry) async => await _services.delete(path: APIPath.entry(uid, entry.id));

  @override
  Stream<List<Entry>> entriesStream({Job job}) => _services.collectionStream<Entry>(
    path: APIPath.entries(uid),
    queryBuilder: job != null ? (query) => query.where('jobId', isEqualTo: job.id) : null,
    builder: (data, documentID) => Entry.fromMap(data, documentID),
    sort: (lhs, rhs) => rhs.start.compareTo(lhs.start),
  );
}
