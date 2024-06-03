import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mindmemo_app/theme/colors.dart';
import 'package:mindmemo_app/widgets/app_container.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgGrey,
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: AppColors.black10,
            height: 1.0,
          ),
        ),
        leadingWidth: 150,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            'Settings',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            AppContainer(
                child: Column(
              children: [
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                          builder: (BuildContext context) => const cdsfsdfs(
                                link: 'https://forms.gle/8dkzwwfTVS8wrPHNA',
                              )),
                    );
                  },
                  leading: SvgPicture.asset('assets/images/settings/terms.svg'),
                  title: Text(
                    'Contact Support',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing:
                      Icon(Icons.arrow_forward_ios, color: AppColors.black40),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                          builder: (BuildContext context) => const cdsfsdfs(
                                link:
                                    'https://docs.google.com/document/d/147pyMHQh9MH0wwGoLq-GhWsDg2wVWq1AGQPyi2n6M1w/edit?usp=sharing',
                              )),
                    );
                  },
                  leading: SvgPicture.asset('assets/images/settings/terms.svg'),
                  title: Text(
                    'Terms of use',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing:
                      Icon(Icons.arrow_forward_ios, color: AppColors.black40),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                          builder: (BuildContext context) => const cdsfsdfs(
                                link:
                                    'https://docs.google.com/document/d/1C-tf7I4lslnRp34blIbK1K23kRXRTwU9SDsiMpvJv44/edit?usp=sharing',
                              )),
                    );
                  },
                  leading: SvgPicture.asset('assets/images/settings/terms.svg'),
                  title: Text(
                    'Privacy Policy',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing:
                      Icon(Icons.arrow_forward_ios, color: AppColors.black40),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

class cdsfsdfs extends StatelessWidget {
  final String link;

  const cdsfsdfs({Key? key, required this.link}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        bottom: false,
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(link)),
        ),
      ),
    );
  }
}
