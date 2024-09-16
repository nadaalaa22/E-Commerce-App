import 'package:e_commerce_app/features/e_commerce/presentation/pages/contact_page.dart';
import 'package:e_commerce_app/features/e_commerce/presentation/pages/fav_page.dart';
import 'package:e_commerce_app/features/e_commerce/presentation/pages/home_page.dart';
import 'package:e_commerce_app/features/e_commerce/presentation/pages/product_page.dart';
import 'package:flutter/material.dart';
import 'package:responsive_navigation_bar/responsive_navigation_bar.dart';

import '../../../../core/app_theme.dart';

class ControllerPage extends StatefulWidget {
  const ControllerPage({Key? key}) : super(key: key);

  @override
  _ControllerPageState createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  int _selectedIndex = 0;

  void changeTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getSelectedPage() {
    switch (_selectedIndex) {
      case 0:
        return HomePage();
      case 1:
        return ProductPage();
      case 2:
        return FavPage();
      case 3:
        return ContactPage();
      default:
        return HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _getSelectedPage(),
      bottomNavigationBar: ResponsiveNavigationBar(
        selectedIndex: _selectedIndex,
        onTabChange: changeTab,
        textStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: 'title',
        ),
        backgroundColor: Colors.grey[850],
        navigationBarButtons: <NavigationBarButton>[
          NavigationBarButton(
            text: 'Home',
            icon: Icons.home,
            backgroundGradient: LinearGradient(
              colors: [primaryColor, secondaryColor],
            ),
          ),
          NavigationBarButton(
            text: 'Products',
            icon: Icons.mode,
            backgroundGradient: LinearGradient(
              colors: [primaryColor, secondaryColor],
            ),
          ),
          NavigationBarButton(
            text: 'Favorite',
            icon: Icons.favorite,
            backgroundGradient: LinearGradient(
              colors: [primaryColor, secondaryColor],
            ),
          ),
          NavigationBarButton(
            text: 'Contact',
            icon: Icons.person,
            backgroundGradient: LinearGradient(
              colors: [primaryColor, secondaryColor],
            ),
          ),
        ],
      ),
    );
  }
}
