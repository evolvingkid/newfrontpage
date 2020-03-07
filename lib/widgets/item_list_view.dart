import 'package:exam/provider/cart.dart';
import 'package:exam/provider/rest_api_calls.dart';
import 'package:exam/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class ItemListViews extends StatefulWidget {
  final category;
  ItemListViews({
    @required this.category});

  @override
  _ItemListViewsState createState() => _ItemListViewsState();
}

class _ItemListViewsState extends State<ItemListViews> {
  List _dish = [];
  @override
  void didChangeDependencies() {
    _dish = Provider.of<RestApiCalss>(context).iteamFilter(widget.category);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidhth = MediaQuery.of(context).size.width;
    return Container(
      child: ListView.builder(
        itemCount: _dish.length,
        itemBuilder: (BuildContext ctx, int index){
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
                        Container(
                          width: screenWidhth * 0.6,
                          padding: const EdgeInsets.all(8.0),
                          child: Text(_dish[index]['dishname'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: Colors.black38),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('${_dish[index]['dish_currency']}'+' ${_dish[index]['dishprice']}',
                          style: TextStyle(fontSize: 16 ,fontWeight: FontWeight.bold,color: Colors.black38) ),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text('${_dish[index]['dish_calories']} calories'),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          height: 50,
                          width: 50,
                          child: Image.network(_dish[index]['dishImg'], fit: BoxFit.cover,)),
                      ],
                    )
                  ],
                ),
                
                Container(
                  padding: EdgeInsets.only(left: 8.0),
                    width: screenWidhth * 0.8,
                  child: Text(_dish[index]['dishDesc'])),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.all(Radius.circular(50))
                    ),
                    
                    width: screenWidhth * 0.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FlatButton(onPressed: (){
                          setState(() {
                            _dish[index]['indexCount'] ++;
                            MainScreenPages.cartCount++;
                           
                          });
                          
                        }, child: Icon(Icons.add)),
                        Container(child: Text(_dish[index]['indexCount'].toString()),),
                        FlatButton(onPressed: (){
                           setState(() {
                             if(_dish[index]['indexCount'] != 0){
_dish[index]['indexCount'] --;
MainScreenPages.cartCount--;
                             }
                             
                          });
                         
                        }, child: Text('-', style: TextStyle(fontSize: 30),)),
                      ],
                    ),
                  ),
                SizedBox(height: 10,),
                Divider(),
              ],
            ),
          );
        }
        )
  );
  }
}