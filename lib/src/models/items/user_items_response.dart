import 'package:wiki_tricky/src/models/items/user_item.dart';

class UserItemsResponse {
  final int itemsReceived;
  final int curPage;
  final int nextPage;
  final int prevPage;
  final int offset;
  final int itemsTotal;
  final int pageTotal;
  final List<UserItem> items;

  UserItemsResponse({
    required this.itemsReceived,
    required this.curPage,
    required this.nextPage,
    required this.prevPage,
    required this.offset,
    required this.itemsTotal,
    required this.pageTotal,
    required this.items,
  });

  factory UserItemsResponse.fromJson(Map<String, dynamic> json) {
    return UserItemsResponse(
      itemsReceived: json['itemsReceived'],
      curPage: json['curPage'],
      nextPage: json['nextPage'],
      prevPage: json['prevPage'],
      offset: json['offset'],
      itemsTotal: json['itemsTotal'],
      pageTotal: json['pageTotal'],
      items: List<UserItem>.from(json['items'].map((x) => UserItem.fromJson(x))),
    );
  }
}
