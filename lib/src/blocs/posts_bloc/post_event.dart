part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class GetItems extends PostEvent {}

class GetNextItems extends PostEvent {
  final int page;

  GetNextItems(this.page);
}
