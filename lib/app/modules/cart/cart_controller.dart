import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organicbazzar/app/model/cart_response_model.dart';
import 'package:organicbazzar/app/modules/home/product_list.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CartController extends GetxController {
  final _cartItems = <CartItem>[].obs;
  List<CartItem> get cartItems => _cartItems.toList();

  final _storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _loadCartItems();
  }

  void addToCart(CartItem item) {
    final index = _cartItems.indexWhere((element) => element.name == item.name);
    if (index != -1) {
      Get.snackbar(
        'Success',
        'Item is already added',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 1),
      );
    } else {
      _cartItems.add(item);
      Get.snackbar(
        'Success',
        'Item is added in cart',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 1),
      );
    }
    _saveCartItems();
  }

  void removeFromCart(CartItem item) {
    _cartItems.removeWhere((element) => element.name == item.name);
    _saveCartItems();
  }

  void _saveCartItems() {
    _storage.write(
        'cartItems', _cartItems.map((item) => item.toJson()).toList());
  }

  void _loadCartItems() {
    final List<Map<String, dynamic>> storedItems =
        _storage.read('cartItems') ?? [];
    _cartItems.assignAll(storedItems.map((item) => CartItem.fromJson(item)));
  }

  // Method to calculate total price of items in the cart
  double calculateTotalPrice() {
    double totalPrice = 0.0;
    for (var item in _cartItems) {
      totalPrice += item.price * item.quantity;
    }
    return totalPrice;
  }
}

class CartItem {
  final String name;
  final double price;
  final int quantity;
  final String image;
  final double rate;

  CartItem(
      {required this.name,
      required this.price,
      this.quantity = 1,
      required this.image,
      required this.rate});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
      image: json['image'],
      rate: json['rate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'quantity': quantity,
      'image': image,
      'rate': rate,
    };
  }
}
