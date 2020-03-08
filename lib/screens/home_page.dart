import 'package:exam/provider/cart.dart';
import 'package:exam/provider/rest_api_calls.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class MainScreenPages extends StatefulWidget {
  @override
  _MainScreenPagesState createState() => _MainScreenPagesState();
}

class _MainScreenPagesState extends State<MainScreenPages> {
  List fetchData = [];

  bool _isLoading = true;

  int catLength = 1;

  String _restaurantName = '';

  List<Widget> _listWdgets = new List<Widget>();

  List<Widget> _bottomlistWdgets = new List<Widget>();

  Future<void> dataManagements() async {
    await Provider.of<RestApiCalss>(context).fetchandSetData();
    fetchData = Provider.of<RestApiCalss>(context, listen: false).fetchData;

  //  print(fetchData[0][0]['restaurant_name']);

    _restaurantName = fetchData[0][0]['restaurant_name'];
    //print(fetchData);
    List _category =
        Provider.of<RestApiCalss>(context, listen: false).selectCategory();
    //print(_category);
    _listWdgets = Provider.of<RestApiCalss>(context, listen: false).listWdgets;
    _bottomlistWdgets =
        Provider.of<RestApiCalss>(context, listen: false).bottomListWdgets;
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
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : DefaultTabController(
              length: catLength,
              child: Scaffold(
                appBar: mainAppBar(context),
                body: TabBarView(
                  children: _bottomlistWdgets,
                ),
              ),
            ),
    );
  }

  AppBar mainAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        _restaurantName,
        style: Theme.of(context).textTheme.title,
      ),
      elevation: 0,
      actions: <Widget>[
        FlatButton(
          onPressed: () {},
          child: Text('My Orders',
              style: TextStyle(fontSize: 15, color: Colors.black45)),
        ),
        cartIconWidget()
      ],
      bottom: TabBar(
        labelColor: Colors.redAccent,
        unselectedLabelColor: Colors.black54,
        indicatorPadding: EdgeInsets.only(left: 30, right: 30),
        indicator: BoxDecoration(
            border: Border(
          bottom: BorderSide(width: 3.0, color: Colors.redAccent),
        )),
        labelStyle: TextStyle(color: Colors.redAccent),
        isScrollable: true,
        tabs: _listWdgets,
      ),
    );
  }

  Container cartIconWidget() {
    return Container(
      child: Stack(
        children: <Widget>[
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: null),
          Positioned(
              right: 5,
              top: 5,
              child: CircleAvatar(
                radius: 8,
                backgroundColor: Colors.redAccent,
                child: Consumer<Cart>(
                  builder: (_, cart, ch) => FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          cart.cartCount.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ),
              ))
        ],
      ),
    );
  }
}
