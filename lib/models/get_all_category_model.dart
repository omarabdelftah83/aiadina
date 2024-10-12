class Category {
  final String? id;
  final String? name;

  Category({
    required this.id,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      name: json['name'],
    );
  }
}

class GetAllCategoryResponse {
  final String? status;
  final int? results;
  final List<Category>? categories;

  GetAllCategoryResponse({
    required this.status,
    required this.results,
    required this.categories,
  });

  factory GetAllCategoryResponse.fromJson(Map<String, dynamic> json) {
    return GetAllCategoryResponse(
      status: json['status'],
      results: json['results'],
      categories: json['data'] != null && json['data']['categories'] != null
          ? List<Category>.from(
              json['data']['categories'].map((category) => Category.fromJson(category)),
            )
          : null,
    );
  }
}
