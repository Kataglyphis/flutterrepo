import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Pages/pages_factory.dart';

abstract class NavBarPagesFactory extends PagesFactory {
  NavigationDestination getNavigationDestination(BuildContext context);
}
