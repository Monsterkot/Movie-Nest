import 'package:equatable/equatable.dart';

class AccountInfo extends Equatable {
  final int id;
  final String name;
  final String username;
  final String avatarPath;

  const AccountInfo({
    required this.id,
    required this.name,
    required this.username,
    required this.avatarPath,
  });

  @override
  List<Object?> get props => [id, name, username, avatarPath];
}
