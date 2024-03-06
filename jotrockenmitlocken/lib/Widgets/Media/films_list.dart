import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jotrockenmitlockenrepo/Media/data_list.dart';
import 'package:jotrockenmitlocken/Widgets/Media/film.dart';
import 'package:jotrockenmitlockenrepo/constants.dart';

class FilmsList extends StatefulWidget {
  const FilmsList({super.key});

  @override
  State<FilmsList> createState() => _FilmsListState();
}

class _FilmsListState extends State<FilmsList> with DataListState<Film> {
  @override
  ColorSeed getColorSeed() {
    // TODO: implement getColorSeed
    throw UnimplementedError();
  }

  @override
  String getTitle() {
    return "Films/Series worth watching";
  }

  @override
  String getDescription() {
    return "TODO: Implement";
  }

  @override
  List<double> getSpacing() {
    return [0.33, 0.33, 0.33];
  }

  @override
  void onSortData(int columnIndex, bool ascending) {
    setState(() {
      Sort(columnIndex, ascending);
    });
  }

  Future<List<List<dynamic>>> _loadFilmsFromCSV() async {
    final rawData = await rootBundle.loadString("assets/data/Filmliste.csv");
    List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);

    dataCategories = List<String>.from(listData.first);
    Data = listData
        .getRange(1, listData.length)
        .toList()
        .map((List e) => Film(
              title: e.elementAt(0),
              ISAN: e.elementAt(1),
            ))
        .toList();
    return listData;
  }

  @override
  initState() {
    super.initState();
    dataFuture = _loadFilmsFromCSV();
  }
}