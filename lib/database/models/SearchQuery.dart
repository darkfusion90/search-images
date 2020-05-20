enum SortTechnique { asc, desc }

class SearchQuery {
  int id;
  final String query;
  final DateTime queryDateTime;

  SearchQuery(this.query, this.queryDateTime, {this.id});

  void setId(int id) {
    this.id = id;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'query': query,
      'queriedOn': queryDateTime.toIso8601String()
    };
  }

  static SearchQuery fromMap(Map<String, dynamic> map) {
    return SearchQuery(
      map['query'],
      DateTime.parse(map['queriedOn']),
      id: map['id'],
    );
  }

  static List<SearchQuery> fromMaps(List<Map<String, dynamic>> maps) {
    return List<SearchQuery>.generate(
      maps.length,
      (index) => fromMap(maps[index]),
    );
  }

  static int compareToUsingDateTime(
    SearchQuery a,
    SearchQuery b, {
    SortTechnique sortTechnique = SortTechnique.asc,
  }) {
    switch (sortTechnique) {
      case SortTechnique.asc:
        return _compareTo(a, b);
      case SortTechnique.desc:
        return _compareTo(b, a);
      default:
        throw Exception(
            'Unknown SortTechnique: $sortTechnique. Unable to proceed any further');
    }
  }

  static int _compareTo(SearchQuery a, SearchQuery b) {
    return a.queryDateTime.compareTo(b.queryDateTime);
  }

  @override
  String toString() {
    return "{'id': $id, 'query': $query}\n";
  }
}
