import 'package:flutter/material.dart';

class CharacterListItem extends StatelessWidget {
  final int index;
  final String name;
  final String description;
  final String imgUrl;

  const CharacterListItem({Key key, this.index, this.name, this.description, this.imgUrl});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
      child: Row(
        children: <Widget>[
          Container(
            width: 50.0,
            height: 50.0,
            margin: EdgeInsets.only(right: 15.0),
            color: Colors.blue,
            child: (imgUrl != null && imgUrl.isNotEmpty) ? Image.network(imgUrl) : null,
          ),
          index != -1
              ? Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '$name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('$description',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
              : Expanded(
            child: Container(
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
