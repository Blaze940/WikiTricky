

import '../items/item.dart';

class Post {
  final int itemsReceived;
  final int curPage;
  final int? nextPage;
  final int? prevPage;
  final int offset;
  final int itemsTotal;
  final int pageTotal;
  final List<Item> items;

  Post({
    required this.itemsReceived,
    required this.curPage,
    required this.nextPage,
    required this.prevPage,
    required this.offset,
    required this.itemsTotal,
    required this.pageTotal,
    required this.items,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      itemsReceived: json['itemsReceived'],
      curPage: json['curPage'],
      nextPage: json['nextPage'],
      prevPage: json['prevPage'],
      offset: json['offset'],
      itemsTotal: json['itemsTotal'],
      pageTotal: json['pageTotal'],
      items: List<Item>.from(json['items'].map((x) => Item.fromJson(x))),
    );
  }
  
  copyWith(Post post, {
    int? itemsReceived,
    int? curPage,
    int? nextPage,
    int? prevPage,
    int? offset,
    int? itemsTotal,
    int? pageTotal,
    List<Item>? items,
  }) {
    return Post(
      itemsReceived: itemsReceived ?? this.itemsReceived,
      curPage: curPage ?? this.curPage,
      nextPage: nextPage ?? this.nextPage,
      prevPage: prevPage ?? this.prevPage,
      offset: offset ?? this.offset,
      itemsTotal: itemsTotal ?? this.itemsTotal,
      pageTotal: pageTotal ?? this.pageTotal,
      items: items ?? this.items,
    );
  }
}
