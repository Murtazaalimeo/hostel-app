import 'dart:developer';
import 'package:f_container/onrent/onrent_screens/payment_method.dart';
import 'package:f_container/widget/cart_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:persistent_shopping_cart/model/cart_model.dart';
import 'package:persistent_shopping_cart/persistent_shopping_cart.dart';

import '../../widget/empty_cart_msg_widget.dart';
import 'payment/payment.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Cart')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Expanded(
                child: PersistentShoppingCart().showCartItems(
                  cartTileWidget: ({required data}) => CartTileWidget(data: data),
                  showEmptyCartMsgWidget: const EmptyCartMsgWidget(),
                ),
              ),
              SizedBox(height: 20),
              PersistentShoppingCart().showTotalAmountWidget(
                cartTotalAmountWidgetBuilder: (totalAmount) => Visibility(
                  visible: totalAmount != 0.0,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(color: Colors.black, fontSize: 22),
                          ),
                          Text(
                            '\$' + totalAmount.toString(),
                            style: const TextStyle(color: Colors.black, fontSize: 22),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          final shoppingCart = PersistentShoppingCart();
                          Map<String, dynamic> cartData = shoppingCart.getCartData();
                          List<PersistentShoppingCartItem> cartItems = cartData['cartItems'];
                          double totalPrice = cartData['totalPrice'];

                          // Add your checkout logic here
                          log('Total Price: $totalPrice');
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => Payment()),
                          );
                        },
                        child: const Text('Checkout'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
