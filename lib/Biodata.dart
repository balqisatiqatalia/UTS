class Biodata{

  int _id;
  String _name;
  int _age;
  String _address;

    int get id => _id;

    String get name => this._name;
    set name(String value) => this._name = value;

    get age => this._age;
    set age( value) => this._age = value;

    String get address => this._address;
    set address(String value) => this._address = value;
    
    // konstruktor versi 1
    Biodata(this._name, this._age,this._address);
    // konstruktor versi 2: konversi dari Map ke Item
    Biodata.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._age = map['age'];
    this._address = map['address'];
    
    }
    // konversi dari Item ke Map
    Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['name'] = name;
    map['age'] = age;
    map['address'] = address;
    return map;
 } 
 }

 