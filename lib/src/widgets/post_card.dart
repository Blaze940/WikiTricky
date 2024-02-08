import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/items/item.dart';

class PostCard extends StatelessWidget {
  final Item item;

  const PostCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
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
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.author.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        DateFormat('dd MMM yyyy, HH:mm').format(
                          DateTime.fromMillisecondsSinceEpoch(item.createdAt),
                        ),
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.content,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.comment, color: Theme.of(context).primaryColor, size: 20),
                          const SizedBox(width: 4),
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
                      ElevatedButton.icon(
                        icon: Icon(Icons.visibility, size: 16),
                        label: Text('Details', style: TextStyle(fontSize: 12)),
                        onPressed: () {
                          // Navigate to details page
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Color(0xFF8B0000), // Text Color (Foreground color)
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
