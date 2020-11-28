import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  int _id;
  String _itemName;
  String _dateCreated;

  TodoItem(this._itemName, this._dateCreated);

  TodoItem.map(dynamic obj) {
    this._itemName = obj['itemname'];
    this._dateCreated = obj['datecreated'];
    this._id = obj['id'];
  }

  int get id => _id;

  String get itemName => _itemName;

  String get dateCreated => _dateCreated;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['itemname'] = this._itemName;
    map['datecreated'] = this._dateCreated;

    if (this._id != null) {
      map['id'] = this._id;
    }
    return map;
  }

  TodoItem.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._itemName = map['itemname'];
    this._dateCreated = map['datecreated'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            _itemName,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.9),
          ),
          Padding(
            padding: const EdgeInsets.only(top : 8.0),
            child: Text(
              _dateCreated,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.5,
                fontStyle: FontStyle.italic,
              ),
            ),
          )
        ],
      ),
    );
  }
}
