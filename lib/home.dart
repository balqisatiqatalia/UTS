import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dbhelper.dart';
import 'entryform.dart';
import 'Biodata.dart';

    class Home extends StatefulWidget {
    @override
    HomeState createState() => HomeState();
    }
    class HomeState extends State<Home> {
    DbHelper dbHelper = DbHelper();
    int count = 0;
    List<Biodata> bioList;
  @override
      Widget build(BuildContext context) {
      if (bioList == null) {
      bioList = List<Biodata>();
      updateListView();
      }
    return Scaffold(
    appBar: AppBar(
    title: Text('Daftar Pasien'),
    ),
      body: Column(children : [
      Expanded(child: createListView(),),
      Container(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
      width: double.infinity,
      child: RaisedButton(
      child: Text("Tambah Data"),
      onPressed: () async {
        var bio = await navigateToEntryForm(context, null);
        if (bio != null) {
        //TODO 2 Panggil Fungsi untuk Insert ke DB
        int result = await dbHelper.insert(bio);
        if (result > 0) {
          updateListView();
        }
 }
 },
 ),
 ),
 ),
 ]),
 );
 }
      Future<Biodata> navigateToEntryForm(BuildContext context, Biodata bio) async {
        var result = await Navigator.push(
        context,
        MaterialPageRoute(
        builder: (BuildContext context) {
        return EntryForm(bio);
      }
      )
      );
      return result;
      }
      ListView createListView() {
      TextStyle textStyle = Theme.of(context).textTheme.headline5;
       return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
       return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
          leading: CircleAvatar(
          backgroundColor: Colors.red,
          child: Icon(Icons.ad_units),
          ),
          title: Text(this.bioList[index].id.toString(),
          style: textStyle,
          ),
          subtitle: Text(this.bioList[index].name.toString()),
           trailing: GestureDetector(
      child: Icon(Icons.delete),
      onTap: ()async {
         int result = await dbHelper.delete(this.bioList[index].id);
          if(result > 0){
            updateListView();
          } 
      //TODO 3 Panggil Fungsi untuk Delete dari DB berdasarkan Item
      },
 ),
          onTap: () async {
          var bio = await navigateToEntryForm(context, this.bioList[index]);
          int result = await dbHelper.update(bio);
          if(result > 0){
            updateListView();
          } 
          //TODO 4 Panggil Fungsi untuk Edit data
          },
 ),
 );
 },
 );
 }
 //update List item
      void updateListView() {
      final Future<Database> dbFuture = dbHelper.initDb();
      dbFuture.then((database) {
      //TODO 1 Select data dari DB
      Future<List<Biodata>> bioListFuture = dbHelper.getBiodataList();
      bioListFuture.then((bioList) {
      setState(() {
      this.bioList = bioList;
      this.count = bioList.length;
 });
 });
 });
 }
}
