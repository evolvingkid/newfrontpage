import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart';
class ItemsExtraBtn extends StatefulWidget {
  const ItemsExtraBtn({
    Key key,
    @required this.screenWidhth,
    @required List counterForDish,
   @required  this.index
  }) : _counterForDish = counterForDish, super(key: key);

  final double screenWidhth;
  final List _counterForDish;
  final int index;

  @override
  _ItemsExtraBtnState createState() => _ItemsExtraBtnState();
}

class _ItemsExtraBtnState extends State<ItemsExtraBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: Colors.greenAccent,
          borderRadius: BorderRadius.all(Radius.circular(50))),
      width: widget.screenWidhth * 0.6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FlatButton(
              onPressed: () {
                setState(() {
                  widget._counterForDish[widget.index]++;
                  Provider.of<Cart>(context, listen: false)
                      .addCount();
                });
              },
              child: Icon(Icons.add, size: 20,)),
          Container(
            child: Text(widget._counterForDish[widget.index].toString()),
          ),
          FlatButton(
              onPressed: () {
                setState(() {
                  if (widget._counterForDish[widget.index] != 0) {
                    widget._counterForDish[widget.index]--;
                    Provider.of<Cart>(context, listen: false)
                        .subCount();
                  }
                });
              },
              child: Text(
                '-',
                style: TextStyle(fontSize: 30),
              )),
        ],
      ),
    );
  }
}
