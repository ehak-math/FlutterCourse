import 'package:flutter/material.dart';
import 'package:my_app/W6/S1 - PRACTICE- Lists - Pass Functions/EXERCISE-2/model/profile_tile_model.dart';
 
ProfileData ronanProfile = ProfileData(
    name: "Ronan",
    position: "Flutter Developer",
    avatarUrl: 'assets/w6-s1/p1.jpg',
    tiles: [
      TileData(icon: Icons.phone, title: "Phone Number", value: "+123 456 7890"),
      TileData(icon: Icons.location_on, title: "Address", value: "123 Cambodia"),
      TileData(icon: Icons.email, title: "Mail", value: "ronan.ogogr@cadt.edu"),
    ]);
ProfileData hongProfile = ProfileData(
    name: "Hong",
    position: "Flutter Developer",
    avatarUrl: 'assets/w6-s1/hong.jpg',
    tiles: [
      TileData(icon: Icons.phone, title: "Phone Number", value: "+855 967 8435"),
      TileData(icon: Icons.location_on, title: "Address", value: "1200 Cambodia"),
      TileData(icon: Icons.email, title: "Mail", value: "hong.lei@cadt.edu"),
    ]);
ProfileData fengProfile = ProfileData(
    name: "Lou Feng",
    position: "Flutter Developer",
    avatarUrl: 'assets/w6-s1/feng.jpg',
    tiles: [
      TileData(icon: Icons.phone, title: "Phone Number", value: "+855 974 4356"),
      TileData(icon: Icons.location_on, title: "Address", value: "1200 Cambodia"),
      TileData(icon: Icons.email, title: "Mail", value: "feng.lou@cadt.edu"),
    ]);