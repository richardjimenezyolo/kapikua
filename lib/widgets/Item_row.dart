import 'dart:async';

import 'package:kapicua/models/points.dart';
import 'package:kapicua/models/match.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class ItemRow extends StatelessWidget {
  final int index;
  final Points item;

  const ItemRow({
    super.key,
    required this.index,
    required this.item,
  });

  Future<bool> confirmDismiss(context) {
    var completer = Completer<bool>();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm'),
        content: Text('Are you sure you want to remove this item?'),
        actions: [
          TextButton(
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              completer.complete(false);
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text('Confirm'),
            onPressed: () {
              completer.complete(true);
              Navigator.pop(context);
            },
          )
        ],
      ),
    ).then((c) => completer.complete(false));

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<Match>(context);

    return Dismissible(
      key: Key(Uuid().v4()),
      confirmDismiss: (ev) => confirmDismiss(context),
      onDismissed: (e) {
        provider.removeByIndex(index);
      },
      child: Container(
        height: 60,
        color: index % 2 == 0 ? Color(0xFF0f172a) : Color(0xff030712),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  item.theirs.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    // color: winner ? Color(0xff22c55e) : Color(0xffef4444),
                    fontSize: 18,
                  ),
                  textDirection: TextDirection.rtl,
                ),
              ),
              const VerticalDivider(
                thickness: 2,
                width: 40,
                color: Colors.grey,
              ),
              SizedBox(
                width: 100,
                child: Text(
                  item.us.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    // color: winner ? Color(0xff22c55e) : Color(0xffef4444),
                    fontSize: 18,
                  ),
                  textDirection: TextDirection.ltr,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
