import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/items/item.dart';

class PostCard extends StatelessWidget {
  final Item item;

  const PostCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (item.image != null)
            Image.network(
              item.image!.url,
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.author.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  DateFormat('dd MMM yyyy, HH:mm').format(
                    DateTime.fromMillisecondsSinceEpoch(item.createdAt),
                  ),
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  item.content, // Contenu du post
                  style: const TextStyle(fontSize: 16),
                ),
                SizedBox(height: 8),
                Text(
                  '${item.commentsCount} Comments',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
