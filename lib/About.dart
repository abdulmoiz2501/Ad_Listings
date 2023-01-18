import 'package:about/about.dart';
import 'package:flutter/material.dart';
import 'package:listings/constants.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Container(
        child: AboutPage(
          values: {
            'version': '1.0.0',
            'buildNumber':' 0.0.1',
            'year': DateTime.now().year.toString(),
            'author': 'Maryam Tanvir',
          },
          title: const Text('About'),
          applicationVersion: 'Version {{ version }}, build #{{ buildNumber }}',
          applicationDescription: const Text(
            'Shopify!'
          ),
          applicationIcon: const FlutterLogo(size: 100),
          applicationLegalese: 'Copyright © {{ author }}, {{ year }}',
          children: const <Widget>[
            MarkdownPageListTile(
              filename: 'README.md',
              title: Text('View Readme'),
              icon: Icon(Icons.all_inclusive),
            ),
            MarkdownPageListTile(
              filename: 'CHANGELOG.md',
              title: Text('View Changelog'),
              icon: Icon(Icons.view_list),
            ),
            MarkdownPageListTile(
              filename: 'CONTRIBUTING.md',
              title: Text('Contributing'),
              icon: Icon(Icons.share),
            ),
            MarkdownPageListTile(
              filename: 'CODE_OF_CONDUCT.md',
              title: Text('Code of conduct'),
              icon: Icon(Icons.sentiment_satisfied),
            ),
            LicensesPageListTile(
              title: Text('Open source Licenses'),
              icon: Icon(Icons.favorite),
            ),
          ],

        )

      ),
    );
  }
}
