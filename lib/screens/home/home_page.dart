import 'package:flutter/material.dart';
import 'package:project_1/models/restaurant.dart';
import 'package:project_1/repositories/restaurant_repository.dart';
import 'package:project_1/screens/home/add_menu.dart';
import 'package:project_1/screens/home/menu_list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Menu>? _menu;
  var _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    getMenu();
  }

  getMenu() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    await Future.delayed(Duration(seconds: 2));

    try {
      var menus = await RestaurantRepository().getMenu();
      debugPrint('Number of menus: ${menus.length}');

      setState(() {
        _menu = menus;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  buildLoadingOverlay() => Container(
        color: Colors.black.withOpacity(0.2),
        child: Center(child: CircularProgressIndicator()),
      );

  buildError() => Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_errorMessage ?? '', textAlign: TextAlign.center),
              SizedBox(height: 32.0),
              ElevatedButton(onPressed: getMenu, child: Text('Retry')),
            ],
          ),
        ),
      );

  buildList() => ListView.builder(
        itemCount: _menu!.length,
        itemBuilder: (ctx, i) {
          Menu menu = _menu![i];
          return MenuListItem(menu: menu);
        },
      );

  handleClickAdd() {
    Navigator.pushNamed(context, AddMenuPage.routeName).whenComplete(() {
      getMenu();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Row(
          children: <Widget>[
            Text("Restaurant Menu ' Main Course '"),
            SizedBox(width: 15),
            Icon(Icons.fastfood_sharp),
          ],
        ),
      ),
      body: Stack(
        children: [
          if (_menu?.isNotEmpty ?? false) buildList(),
          if (_errorMessage != null) buildError(),
          if (_isLoading) buildLoadingOverlay(),
        ],
      ),
      floatingActionButton: AddButton(onPressed: handleClickAdd),
      drawer: DrawerPage(),
      backgroundColor: Colors.orangeAccent.shade100,
    );
  }
}

class AddButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: onPressed,
        child: Icon(Icons.add),
        backgroundColor: Colors.brown.shade600,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ));
  }
}

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              children: <Widget>[
                Text(" Menu "),
                Icon(Icons.library_books_sharp),
              ],
            ),
            backgroundColor: Colors.grey.shade800,
          ),
          SizedBox(height: 10),
          ListTile(
            leading: Container(
              width: 50,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.orangeAccent.shade200,
              ),
              child: Icon(Icons.fastfood_sharp, color: Colors.black),
            ),
            title: Text(
              "Main Course",
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.pop(context); // Close the drawer
            },
          ),
          SizedBox(height: 10),
          ListTile(
            leading: Container(
              width: 50,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.pink.shade200,
              ),
              child: Icon(Icons.bakery_dining_rounded, color: Colors.black),
            ),
            title: Text(
              "Dessert",
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DessertPage()),
              );
            },
          ),
          SizedBox(height: 10),
          ListTile(
            leading: Container(
              width: 50,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.lightBlue.shade200,
              ),
              child: Icon(Icons.emoji_food_beverage, color: Colors.black),
            ),
            title: Text(
              "Drink Caffee",
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DrinkCaffeePage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class MainCoursePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: <Widget>[
            Text("Restaurant Menu ' Main Course ' "),
            SizedBox(width: 15),
            Icon(Icons.fastfood_sharp),
          ],
        ),
        actions: [
          AddButton(
            onPressed: () {
              Navigator.pushNamed(context, AddMenuPage.routeName)
                  .whenComplete(() {});
            },
          ),
        ],
      ),
      body: Center(),
      backgroundColor: Colors.orange.shade50,
    );
  }
}

class DessertPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: <Widget>[
            Text("Restaurant Menu ' Dessert ' "),
            SizedBox(width: 15),
            Icon(Icons.bakery_dining_rounded),
          ],
        ),
        actions: [
          AddButton(
            onPressed: () {
              Navigator.pushNamed(context, AddMenuPage.routeName)
                  .whenComplete(() {});
            },
          ),
        ],
      ),
      body: Center(),
      backgroundColor: Colors.pink.shade50,
    );
  }
}

class DrinkCaffeePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: <Widget>[
            Text("Restaurant Menu ' Drink Caffee '"),
            SizedBox(width: 15),
            Icon(Icons.emoji_food_beverage),
          ],
        ),
        actions: [
          AddButton(
            onPressed: () {
              Navigator.pushNamed(context, AddMenuPage.routeName)
                  .whenComplete(() {});
            },
          ),
        ],
      ),
      body: Center(),
      backgroundColor: Colors.blue.shade50,
    );
  }
}
