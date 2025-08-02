class Pagination {
  final int totalCount;
  final int perPage;
  final int maxPage;
  final int currentPage;

  Pagination({
    required this.totalCount,
    required this.perPage,
    required this.maxPage,
    required this.currentPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      totalCount: json['totalCount'] ?? 0,
      perPage: json['perPage'] ?? 0,
      maxPage: json['maxPage'] ?? 0,
      currentPage: json['currentPage'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalCount': totalCount,
      'perPage': perPage,
      'maxPage': maxPage,
      'currentPage': currentPage,
    };
  }

  @override
  String toString() {
    return 'Pagination(totalCount: $totalCount, perPage: $perPage, maxPage: $maxPage, currentPage: $currentPage)';
  }
}
