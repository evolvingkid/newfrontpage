import 'package:exam/provider/rest_api_calls.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './exta_btn_in_iteam_list.dart';

class ItemListViews extends StatefulWidget {
  final category;
  ItemListViews({@required this.category});

  @override
  _ItemListViewsState createState() => _ItemListViewsState();
}

class _ItemListViewsState extends State<ItemListViews> {
  List _dish = [];
  List _counterForDish = [];
  _dataCollections() {
    _dish = Provider.of<RestApiCalss>(context, listen: false).iteamFilter(widget.category);
    for (int i = 0; i < _dish.length; i++) {
      _counterForDish.insert(i, 0);
    }
  }
 
  @override
  void didChangeDependencies() {
    _dataCollections();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidhth = MediaQuery.of(context).size.width;
    return Container(
        child: _dish.length == 0
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                        'No Items are added to this category Will be Back soon '),
                    RaisedButton(
                        color: Colors.redAccent,
                        onPressed: _dataCollections,
                        child: Text(
                          'Reload',
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: _dish.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                      ),
                                      child: CircleAvatar(
                                        backgroundColor:
                                            _dish[index]['dishtype'] == '2'
                                                ? Colors.greenAccent
                                                : Colors.redAccent,
                                        radius: 5,
                                      ),
                                    ),
                                    Container(
                                      width: screenWidhth * 0.5,
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        _dish[index]['dishname'],
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black38),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      '${_dish[index]['dish_currency']}' +
                                          ' ${_dish[index]['dishprice']}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black38)),
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                    '${_dish[index]['dish_calories']} calories'),
                                Container(
                                    margin: EdgeInsets.only(left: 5),
                                    height: 50,
                                    width: 50,
                                    child: _dish[index]['dishImg'] != '[]'
                                        ? Image.network(
                                            _dish[index]['dishImg'],
                                            fit: BoxFit.cover,
                                          )
                                        : Padding(
                                            padding: EdgeInsets.all(10),
                                          )),
                              ],
                            )
                          ],
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 8.0),
                            width: screenWidhth * 0.8,
                            child: Text(_dish[index]['dishDesc'])),
                        ItemsExtraBtn(
                          screenWidhth: screenWidhth,
                          counterForDish: _counterForDish,
                          index: index,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, left: 20),
                          child: _dish[index]['addoncat'] != '[]'
                              ? Text(
                                  'Customizations available',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.redAccent,
                                  ),
                                )
                              : Text(''),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(),
                      ],
                    ),
                  );
                }));
  }
}
