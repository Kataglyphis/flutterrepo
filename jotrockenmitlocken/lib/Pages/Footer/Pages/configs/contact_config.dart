import 'package:flutter/src/widgets/framework.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer_pages_creator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContactPagesConfig extends FooterPagesConfig {
  ContactPagesConfig({required super.routingName, required super.pagesCreator});

  @override
  String getHeading(BuildContext context) {
    return AppLocalizations.of(context)!.contact;
  }
}
