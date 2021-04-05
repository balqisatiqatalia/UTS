import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dbhelper.dart';
import 'entryimun.dart';
import 'Imunisasi.dart';

    class HomeImun extends StatefulWidget {
    @override
    HomeImunState createState() => HomeImunState();
    }
    class HomeImunState extends State<HomeImun> {
    DbHelper dbHelper = DbHelper();
    int count = 0;
    List<Imunisasi> imunList;
  @override
      Widget build(BuildContext context) {
      if (imunList == null) {
      imunList = List<Imunisasi>();
      updateListView();
      }
    return Scaffold(
    appBar: AppBar(
    title: Text('Daftar Imunisasi'),
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
        var imun = await navigateToEntryImun(context, null);
        if (imun != null) {
        //TODO 2 Panggil Fungsi untuk Insert ke DB
        int result = await dbHelper.insertimun(imun);
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
      Future<Imunisasi> navigateToEntryImun(BuildContext context, Imunisasi imun) async {
        var result = await Navigator.push(
        context,
        MaterialPageRoute(
        builder: (BuildContext context) {
        return EntryImun(imun);
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
         title: Text(this.imunList[index].id.toString(),
          style: textStyle,
          ),
          subtitle: Text(this.imunList[index].nameim.toString()),
           trailing: GestureDetector(
      child: Icon(Icons.delete),
      onTap: ()async {
         int result = await dbHelper.deleteimun(this.imunList[index].id);
          if(result > 0){
            updateListView();
          } 
      //TODO 3 Panggil Fungsi untuk Delete dari DB berdasarkan Item
      },
 ),
          onTap: () async {
          var imun = await navigateToEntryImun(context, this.imunList[index]);
          int result = await dbHelper.updateimun(imun);
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
      Future<List<Imunisasi>> imunListFuture = dbHelper.getImunisasiList();
      imunListFuture.then((imunList) {
      setState(() {
      this.imunList = imunList;
      this.count = imunList.length;
 });
 });
 });
 }
}
