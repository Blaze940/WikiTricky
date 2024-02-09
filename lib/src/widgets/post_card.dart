import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../blocs/auth_bloc/auth_bloc.dart';
import '../models/items/item.dart';

class PostCard extends StatelessWidget {
  final Item item;

  const PostCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final isLoggedIn = authBloc.state.status == AuthStatus.success;
    final currentUser = authBloc.state.user;
    final canEdit = isLoggedIn && currentUser?.id == item.author.id;

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
            offset: Offset(0, 3),
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
                      Row(
                        children: [
                          Text(
                            DateFormat('dd MMM yyyy, HH:mm').format(
                              DateTime.fromMillisecondsSinceEpoch(item.createdAt),
                            ),
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                          if (canEdit)
                            IconButton(
                              icon: Icon(Icons.delete, color: Color(0xFF8B0000), size: 20), // Couleur rouge pour l'icône
                              onPressed: () {
                                // Logique pour supprimer le post
                              },
                            ),
                        ],
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
                      Row(
                        children: [
                          if (canEdit)
                            ElevatedButton.icon(
                              icon: Icon(Icons.edit, size: 16),
                              label: Text('Edit', style: TextStyle(fontSize: 12)),
                              onPressed: () {
                                // Logique pour modifier le post
                              }
                              ,style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white, backgroundColor: Theme.of(context).primaryColor,
                              )
                            ),

                          SizedBox(width: 8),
                          ElevatedButton.icon(
                            icon: Icon(Icons.visibility, size: 16),
                            label: Text('Details', style: TextStyle(fontSize: 12)),
                            onPressed: () {
                              // Logique pour naviguer vers la page de détails
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: Color(0xFF8B0000),
                            ),
                          ),
                        ],
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
