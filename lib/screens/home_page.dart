import 'package:exam/provider/cart.dart';
import 'package:exam/provider/rest_api_calls.dart';
import 'package:exam/widgets/item_list_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class MainScreenPages extends StatefulWidget {

static int cartCount = 0;
  @override
  _MainScreenPagesState createState() => _MainScreenPagesState();
}

class _MainScreenPagesState extends State<MainScreenPages> {
  List fetchData = [];
  bool _isLoading = true;
  int catLength = 1;

List <Widget> _listWdgets= new List<Widget>();
  
List <Widget> _bottomlistWdgets= new List<Widget>();

   Future<void> dataManagements() async {
await Provider.of<RestApiCalss>(context).fetchandSetData();
fetchData = Provider.of<RestApiCalss>(context ,listen: false).fetchData;
print(fetchData);
List _category = Provider.of<RestApiCalss>(context ,listen: false).selectCategory();
print(_category);
_listWdgets = Provider.of<RestApiCalss>(context ,listen: false).listWdgets;
_bottomlistWdgets = Provider.of<RestApiCalss>(context ,listen: false).bottomListWdgets;
Provider.of<RestApiCalss>(context, listen: false).itemDatas();
    setState(() {
      catLength = _category.length;
      _isLoading = false;
    });
   }


  @override
      void didChangeDependencies() {
    super.didChangeDependencies();
    
    dataManagements();
  }
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
         length: catLength,
         child: Scaffold(
           appBar: mainAppBar(context),
           body: _isLoading ? Center(child: CircularProgressIndicator()) :
           TabBarView(
             children: _bottomlistWdgets,
           ),
         ),
    );
  }

  AppBar mainAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text('UNI Restro Soup', style: Theme.of(context).textTheme.title,),
      elevation: 0,
      actions: <Widget>[
        FlatButton(onPressed: () {}, child: Text('My Orders', style: TextStyle(fontSize: 15, color: Colors.black45)),),
        Container(
          child: Stack(
          children: <Widget>[
            IconButton(icon: Icon(Icons.shopping_cart), onPressed: null),
            Positioned(
              right: 5,
              top: 5,
            child: CircleAvatar(
                radius: 10,
                backgroundColor: Colors.redAccent,
                child: Text(MainScreenPages.cartCount.toString()),),
            )
          ],
        ),)
      ],
      bottom: TabBar(
         unselectedLabelColor: Colors.redAccent,
        isScrollable: true,
              tabs: _listWdgets,
            ),
    );
  }
}