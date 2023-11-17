import 'package:flutter/material.dart';
import 'package:project_1/repositories/restaurant_repository.dart';

class AddMenuPage extends StatefulWidget {
  static const routeName = 'add_Menu';

  const AddMenuPage({Key? key}) : super(key: key);

  @override
  State<AddMenuPage> createState() => _AddMenuPageState();
}

class _AddMenuPageState extends State<AddMenuPage> {
  var _isLoading = false;
  String? _errorMessage;

  final _menuNameController = TextEditingController();
  final _priceController = TextEditingController();

  validateForm() {
    return _menuNameController.text.isNotEmpty &&
        _priceController.text.isNotEmpty;
  }

  saveMenu() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    await Future.delayed(Duration(seconds: 2));

    try {
      var menuName = _menuNameController.text;
      var price = double.parse(_priceController.text);

      await RestaurantRepository().addMenu(name: menuName, price: price);

      if (mounted) Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    buildLoadingOverlay() => Container(
        color: Colors.black.withOpacity(0.2),
        child: Center(child: CircularProgressIndicator()));

    handleClickSave() {
      if (validateForm()) {
        saveMenu();
      }
    }

    buildForm() => SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _menuNameController,
                    decoration: InputDecoration(
                      hintText: 'Menu name',
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.brown.shade900),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.brown.shade200),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _priceController,
                    decoration: InputDecoration(
                      hintText: 'Price',
                      hintStyle: TextStyle(color: Colors.grey),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.brown.shade900),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.brown.shade200),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: handleClickSave,
                    child: Text('SAVE'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black87,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );

    return Scaffold(
      appBar: AppBar(
        title: Text('ADD Menu'),
        backgroundColor: Colors.brown.shade600,
        actions: [
          IconButton(
            icon: Icon(Icons.restaurant_menu),
            onPressed: () {},
          )
        ],
      ),
      body: Stack(
        children: [
          buildForm(),
          if (_isLoading) buildLoadingOverlay(),
        ],
      ),
    );
  }
}
