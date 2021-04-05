class Imunisasi{

  int _id;
  String _nameim;
  int _price;

    int get id => _id;

    String get nameim => this._nameim;
    set nameim(String value) => this._nameim = value;

    get price => this._price;
    set price( value) => this._price = value;
    
    // konstruktor versi 1
    Imunisasi(this._nameim, this._price);
    // konstruktor versi 2: konversi dari Map ke Item
    Imunisasi.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nameim = map['nameim'];
    this._price = map['price'];
   
    }
    // konversi dari Item ke Map
    Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['nameim'] = nameim;
    map['price'] = price;
    return map;
 } 
 }

 