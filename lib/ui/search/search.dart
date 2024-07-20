import 'package:flutter/material.dart';
import 'package:air_fryer_calculator/ui/search/search_finder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';



class SearchWidget extends SearchDelegate {

  @override
  final String? searchFieldLabel = AppLocalizations.of(Get.context!)!.searchNotebook;

  //Create an icon to clear the search query
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  //Create a leading icon to navigate back from the search view
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchFinder(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SearchFinder(query: query);
  }



}