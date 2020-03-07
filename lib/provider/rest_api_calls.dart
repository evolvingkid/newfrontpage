import 'dart:convert';
import 'dart:io';

import 'package:exam/widgets/item_list_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class RestApiCalss with ChangeNotifier {
      
      List fetchData = [];
      List catergoryData = [];
      List <Widget> listWdgets= new List<Widget>();
       List <Widget> bottomListWdgets= new List<Widget>();
      List dish = [];
  Future<void> fetchandSetData() async{
   HttpClient client = new HttpClient();
client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
String url ='https://www.mocky.io/v2/5dfccffc310000efc8d2c1ad';
Map map = { };
HttpClientRequest request = await client.postUrl(Uri.parse(url));
request.headers.set('content-type', 'application/json');
request.add(utf8.encode(json.encode(map)));
HttpClientResponse response = await request.close();
List reply = await response.transform(utf8.decoder).toList() ;

var lists = json.decode('$reply');
//print(lists);

print(lists[0][0]['restaurant_name']);

fetchData = lists;

}

List selectCategory(){
for(int i = 0; i < fetchData[0][0]['table_menu_list'].length ; i++){
 catergoryData.insert(i,fetchData[0][0]['table_menu_list'][i]['menu_category']) ;
listWdgets.add(Padding(
  padding: const EdgeInsets.all(8.0),
  child:   new Text(fetchData[0][0]['table_menu_list'][i]['menu_category'], style: TextStyle(color: Colors.black),),
));
bottomListWdgets.add(ItemListViews(category: fetchData[0][0]['table_menu_list'][i]['menu_category'],));
}
//print('cat: $catergoryData');
return catergoryData;
}

 itemDatas(){
  //print('dish : ${fetchData[0][0]['table_menu_list'][0]['category_dishes'][0]['dish_name']}');
  for(int i=0;  i < fetchData[0][0]['table_menu_list'].length ; i++){
    for(int j=0;  j < fetchData[0][0]['table_menu_list'][i]['category_dishes'].length ; j++){
      print('dish : ${fetchData[0][0]['table_menu_list'][i]['category_dishes'][j]['dish_name']}');
      dish.add({
        'category': '${fetchData[0][0]['table_menu_list'][i]['menu_category']}',
        'dishname': '${fetchData[0][0]['table_menu_list'][i]['category_dishes'][j]['dish_name']}',
        'dishImg': '${fetchData[0][0]['table_menu_list'][i]['category_dishes'][j]['dish_image']}',
        'dishprice': '${fetchData[0][0]['table_menu_list'][i]['category_dishes'][j]['dish_price']}',
        'dish_currency': '${fetchData[0][0]['table_menu_list'][i]['category_dishes'][j]['dish_currency']}',
        'dish_calories': '${fetchData[0][0]['table_menu_list'][i]['category_dishes'][j]['dish_calories']}',
        'dishDesc': '${fetchData[0][0]['table_menu_list'][i]['category_dishes'][j]['dish_description']}',
        'dishAvailibility': '${fetchData[0][0]['table_menu_list'][i]['category_dishes'][j]['dish_Availability']}',
      });
  }
  }
  //print('whole Dish: $dish');
}


List iteamFilter(filterVal){
  List _filters = [];
  //print('fil : ${dish[0]['category']}');
  for(int i=0;  i < dish.length ; i++){
    if(dish[i]['category'] == filterVal){
_filters.add({
     'category': '${dish[i]['category']}',
     'dishname': '${dish[i]['dishname']}',
     'dishImg': '${dish[i]['dishImg']}',
     'dishprice': '${dish[i]['dishprice']}',
     'dish_currency': '${dish[i]['dish_currency']}',
     'dish_calories': '${dish[i]['dish_calories']}',
     'dishDesc': '${dish[i]['dishDesc']}',
      'dishAvailibility': '${dish[i]['dishAvailibility']}',
      'indexCount' : 0,
    });
    }
    
}
return _filters;
}
}
