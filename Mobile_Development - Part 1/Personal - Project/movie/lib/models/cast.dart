import 'package:movie/api/api_constants.dart';

class Cast {
  final String name;
  final String? profilePath;
  final String character;

  Cast({
    required this.name,
    required this.profilePath,
    required this.character,

  });
  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
      name: json['name'],
      profilePath: '${ApiConstants.baseStillUrl}${json['profile_path']}',
      character: json['character'],
    );
  }
}

