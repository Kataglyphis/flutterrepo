import 'package:jotrockenmitlockenrepo/Url/external_link_config.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jotrockenmitlockenrepo/user_settings.dart';

class JotrockenmitlockenFooter extends Footer {
  const JotrockenmitlockenFooter(
      {super.key,
      required super.footerPagesConfig,
      required super.userSettings});

  @override
  JotrockenmitlockenFooterState createState() =>
      JotrockenmitlockenFooterState();
}

class JotrockenmitlockenFooterState extends FooterState {
  @override
  List<ExternalLinkConfig> getExternalLinks() {
    return [
      ExternalLinkConfig(host: 'johannes-heinle.de', path: ''),
      ExternalLinkConfig(host: 'dom-wuest.de', path: '')
    ];
  }

  @override
  String getExternalLinksTitle() {
    return AppLocalizations.of(context)!.externalLinks;
  }

  @override
  String getLiabilityText() {
    return "${AppLocalizations.of(context)!.disclaimer}\n${AppLocalizations.of(context)!.copyright}";
  }

  @override
  Map<String, ExternalLinkConfig> getUserLevelSocialMediaLinksConfig() {
    return widget.userSettings.socialMediaLinksConfig!;
  }
}
