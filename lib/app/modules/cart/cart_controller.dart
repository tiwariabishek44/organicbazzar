import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organicbazzar/app/config/api_endpoint.dart';
import 'package:organicbazzar/app/model/cart_response_model.dart';
import 'package:organicbazzar/app/model/order_request_model.dart';
import 'package:organicbazzar/app/model/order_response_model.dart';
import 'package:organicbazzar/app/modules/cart/utils/order_succesfull.dart';
import 'package:organicbazzar/app/service/api_client.dart';
import 'package:organicbazzar/app/service/http_client.dart';

class CartController extends GetxController {
  // final MakeOrderRepository makeOrderRepository = MakeOrderRepository();
  final Rx<ApiResponse<OrderResponseModel>> orderApiResponse =
      ApiResponse<OrderResponseModel>.initial().obs;

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
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text('Item is already in cart'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
        ),
      );
    } else {
      _cartItems.add(item);

      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text('Item added to cart'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1),
        ),
      );

      _saveCartItems();
    }
  }

  void removeFromCart(String itemname) {
    _cartItems.removeWhere((element) => element.name == itemname);
    _saveCartItems();

    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text('Item removed from cart'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 1),
      ),
    );
  }

  void clearCart() {
    _cartItems.clear(); // Clear the cart list in memory
    _storage.remove('cartItems'); // Remove cart items from storage
  }

  void _saveCartItems() {
    _storage.write(
        'cartItems', _cartItems.map((item) => item.toJson()).toList());
  }

  int getProductQuantity(String productName) {
    final index =
        _cartItems.indexWhere((element) => element.name == productName);
    if (index != -1) {
      return _cartItems[index].quantity;
    } else {
      return 0; // Product not found in the cart
    }
  }

  void _loadCartItems() {
    final List<dynamic> storedItems = _storage.read('cartItems') ?? [];
    _cartItems
        .assignAll(storedItems.map((item) => CartItem.fromJson(item)).toList());
  }

  double calculateTotalPrice() {
    double totalPrice = 0.0;
    for (var item in _cartItems) {
      totalPrice += item.price * item.quantity;
    }
    return totalPrice;
  }

  void updateCartItemQuantity(String itemName, int quantity) {
    final index = _cartItems.indexWhere((element) => element.name == itemName);
    if (index != -1 && quantity > 0) {
      _cartItems[index] = _cartItems[index].copyWith(quantity: quantity);
      _saveCartItems();
    }
  }

  bool isInCart(String itemName) {
    return _cartItems.any((element) => element.name == itemName);
  }

  var orderLoading = false.obs;
  Future<void> createOrder() async {
    try {
      orderLoading.value = true;

      List<OrderProduct> products = _cartItems.map((item) {
        return OrderProduct(
          productId: item.productId,
          quantity: item.quantity,
        );
      }).toList();

      // Define your API endpoint
      var apiUrl = Uri.parse(ApiEndpoints.makeOrder);

      // // Prepare the payload
      // List<Map<String, dynamic>> jsonList =
      //     products.map((item) => item.toJson()).toList();

      String body = json.encode(products);

      // Send POST request
      var response = await httpClient
          .post(
            apiUrl,
            headers: {
              'Content-Type':
                  'application/json', // Adjust content type if necessary
            },
            body: body,
          )
          .timeout(Duration(minutes: 1));

      // Handle response
      if (response.statusCode == 200) {
        log('Order placed successfully');

        orderLoading.value = false;
        Get.off(() => SuccessPage());
        //timer of 1 second
        Future.delayed(Duration(seconds: 1), () {
          clearCart();
        });
      } else {
        orderLoading.value = false;
        // make a scaffold messanger to show the error
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text('Failed to place order'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 1),
          ),
        );
        log('Failed to place order: ${response.statusCode}');
      }
    } catch (e) {
      orderLoading.value = false;
      log('Error placing order: $e');
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text('Error placing order: $e'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
        ),
      );
    }
  }
}
