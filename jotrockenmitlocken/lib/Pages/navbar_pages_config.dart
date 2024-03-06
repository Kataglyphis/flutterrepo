import 'package:jotrockenmitlocken/Pages/nav_bar_pages_factory.dart';
import 'package:jotrockenmitlocken/Pages/pages_factory.dart';
import 'package:jotrockenmitlocken/Routing/stateful_branch_info_provider.dart';

class NavBarPagesConfig extends StatefulBranchInfoProvider {
  String routingName;
  NavBarPagesFactory pagesCreator;
  NavBarPagesConfig({required this.routingName, required this.pagesCreator});

  @override
  String getRoutingName() {
    return routingName;
  }

  @override
  PagesFactory getPagesFactory() {
    return pagesCreator;
  }
}