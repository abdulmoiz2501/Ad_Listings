import 'package:flutter/material.dart';

import 'constants.dart';


class FAQ extends StatefulWidget {
  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          backgroundColor: kMainMenuColor,
        ),
      ),

      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            EntryItem(data[index]),
        itemCount: data.length,  // For empty space after all lists, tells where the 'white' body starts
      ),

    );
  }
}


// One entry in the multilevel list displayed by this app.
class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
}

// The entire multilevel list displayed by this app.
final List<Entry> data = <Entry>[
  Entry(
    'What is Shopify?',
    <Entry>[
      Entry('Shopify is an end to end selling and buying place that covers all of your needs. '),
    ],
  ),
  Entry(
    'How can I sell?',
    <Entry>[
      Entry('After making a new account, you can to go Post an ad and list the item you want to sell.'),
    ],
  ),
  Entry(
    'Where to see the listings?',
    <Entry>[
      Entry('In the HomPage, click on View the ads page to see all of the ads.'),
    ],
  ),

];

//Displays extension tile if it exists (as children)
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}