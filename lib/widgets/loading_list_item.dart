import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class LoadingListItem extends StatelessWidget {
  final int index;

  const LoadingListItem({Key key, this.index});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
      alignment: Alignment.center,
      child: CircularProgressIndicator(strokeWidth: 1.0,)
    );
  }
}
