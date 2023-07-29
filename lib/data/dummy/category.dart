import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class Category {
  final String name;
  final IconData? icon;

  Category(this.name, {this.icon});
}

List<Category> listCategory = [
  Category("Housing", icon: Icons.home_filled),
  Category("Bill", icon: Icons.directions_car_filled_rounded),
  Category("Transport", icon: IonIcons.car_sharp),
  Category("Supplies", icon: Icons.trolley),
  Category("Entertainment", icon: Icons.movie_creation_rounded),
  Category("Health Care", icon: Icons.health_and_safety_rounded),
  Category("Personal Care", icon: Icons.person),
  Category("Gift", icon: Icons.card_giftcard_rounded),
  Category("Donation", icon: Icons.handshake_rounded),
  Category("Snacks", icon: Icons.food_bank_rounded),
  Category("Other", icon: Icons.dns_rounded),
];
