import 'package:flutter/material.dart';
import 'constant.dart';


class plannerPage extends StatefulWidget {
  const plannerPage({Key? key}) : super(key: key);

  @override
  _plannerPage createState() => _plannerPage();
}

class _plannerPage extends State<plannerPage> {
  //add search history here
  final controller = TextEditingController();

  List<String> _datas = [
    "Marina May sands",
    "Singapore Zoo park",
    "Sentosa",
    "Jurong Bird park",
    "Changi Airport",
  ];
  _onSelected(dynamic val) {
    setState(() => _datas.removeWhere((data) => data == val));
  }



  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kAppBarColor,
          title: Text('Itinerary planner'),
          actions: [
            /*
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: MySearchResults(),
                );
              },
            ),*/ //search filter taken out and eed to remove other parts of code assciated to it.
          ],
        ),
        // add floating search bar
        body: ListView(
        children: _datas
            .map((data) => ListTile(
          title: Text(data),
          trailing: PopupMenuButton(
            onSelected: _onSelected,
            icon: Icon(Icons.more_vert),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: data,
                child: Text("Delete"),
              ),
            ],
          ),
        ))
            .toList(),
      ),
      );
  
}

class MySearchResults extends SearchDelegate {
  final textFieldValueHolder = TextEditingController();
  List<String> searchResults = [
    'Sentosa',
    'Changi Airport',
    'Airport',
    'Busstop',
  ];
  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => close(context, null), //this closes the search bar
      );

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
              close(context, null); //closes search bar
            } else {
              query = '';
            }
          },
        ),
      ];

  @override
  Widget buildResults(BuildContext context) => Center(
        child: Text(
          query,
          style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
        ),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestions = searchResults.where((searchResult) {
      final result = searchResult.toLowerCase();
      final input = query.toLowerCase();

      return result.contains(input);
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];

        return ListTile(
          title: Text(suggestion),
          onTap: () {
            
            Navigator.push(
                  context, MaterialPageRoute(builder: (context) => plannerPage()));
          },
        );
      },
    );
  }
}


  


