import 'package:flutter/material.dart';
import 'Imunisasi.dart';

  class EntryImun extends StatefulWidget {
  final Imunisasi imun;
  EntryImun(this.imun);
    @override
  EntryImunState createState() => EntryImunState(this.imun);
  }
//class controller
    class EntryImunState extends State<EntryImun> {
    Imunisasi imun;
    EntryImunState(this.imun);
    TextEditingController nameimController = TextEditingController();
    TextEditingController priceController = TextEditingController();
 
    @override
    Widget build(BuildContext context) {
    //kondisi
        if (imun != null) {
        nameimController.text = imun.nameim;
        priceController.text = imun.price.toString();
        }
    //rubah
      return Scaffold(
          appBar: AppBar(
          title: imun == null ? Text('Tambah') : Text('Ubah'),
          leading: Icon(Icons.keyboard_arrow_left),
          ),
       body: Padding(
          padding: EdgeInsets.only(top: 15.0, left:10.0, right:10.0),
          child: ListView(
          children: <Widget> [
          // nama
          Padding (
          padding: EdgeInsets.only(top:20.0, bottom:20.0),
          child: TextField(
       controller: nameimController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
          labelText: 'Jenis Imunisasi', 
          border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          ),
          ),
          onChanged: (value) {
          //
          },
          ),
          ),
          // harga
      Padding (
      padding: EdgeInsets.only(top:20.0, bottom:20.0),
      child: TextField(
      controller: priceController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
      labelText: 'Harga',
      border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      ),
      ),
       onChanged: (value) {
    //
    },
    ),
    ),
 // tombol button
    Padding (
    padding: EdgeInsets.only(top:20.0, bottom:20.0),
    child: Row(
    children: <Widget> [
    // tombol simpan
    Expanded(
    child: RaisedButton(
    color: Theme.of(context).primaryColorDark,
    textColor: Theme.of(context).primaryColorLight,
    child: Text(
          'Save',
          textScaleFactor: 1.5,
          ),
          onPressed: () {
            if (imun == null) {
            // tambah data
            imun = Imunisasi(nameimController.text, int.parse(priceController.text));
            } else {
            // ubah data
            imun.nameim = nameimController.text;
            imun.price = int.parse(priceController.text);
            }
            // kembali ke layar sebelumnya dengan membawa objek item
            Navigator.pop(context, imun);
            },
 ),
 ),
      Container(width: 5.0,),
      // tombol batal
      Expanded(
        child: RaisedButton(
        color: Theme.of(context).primaryColorDark,
        textColor: Theme.of(context).primaryColorLight,
        child: Text(
        'Cancel',
        textScaleFactor: 1.5,
        ),
      onPressed: () {
      Navigator.pop(context);
      },
 ),
 ),
 ],
 ),
 ),
 ],
 )
 )
 );
 }
    }