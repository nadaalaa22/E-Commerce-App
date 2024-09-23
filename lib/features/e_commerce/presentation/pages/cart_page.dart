import 'package:e_commerce_app/core/app_theme.dart';
import 'package:e_commerce_app/core/widgets/loading_widget.dart';
import 'package:e_commerce_app/features/Api/response/ProductDM.dart';
import 'package:e_commerce_app/features/e_commerce/presentation/pages/product_Details.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int _counter = 1;
  num _totalPrice = 0.0;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _userId;
  List<QueryDocumentSnapshot> _cartItems = [];

  @override
  void initState() {
    super.initState();
    _getCurrentUserId();
  }

  void _getCurrentUserId() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _userId = user.uid;
      });
    }
  }

  void _calculateTotalPrice() {
    _totalPrice = 0.0;
    _cartItems.forEach((item) {
      _totalPrice += item['price'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: appTheme.textTheme.displayLarge,
        ),
        centerTitle: true,
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.arrow_back,
        //     color: primaryColor,
        //   ),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
        actions: [
          Icon(
            Icons.shopping_cart,
            color: primaryColor,
            size: 25,
          ),
          const SizedBox(
            width: 30,
          )
        ],
      ),
      body: _userId != null
          ? StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('users')
                  .doc(_userId)
                  .collection('cartItems')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const LoadingWidget();
                  default:
                    _cartItems = snapshot.data!.docs;
                    _calculateTotalPrice();
                    return Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: _cartItems.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ProductDetails(
                                        product: ProductDM(
                                          sold: _cartItems[index]['sold'],
                                          id: _cartItems[index]['productId'],
                                          title: _cartItems[index]['title'],
                                          description: _cartItems[index]['description'],
                                          price: _cartItems[index]['price'],
                                          ratingsAverage: _cartItems[index]['ratingsAverage'],
                                          images: [_cartItems[index]['image']],
                                        ),
                                        counter: _cartItems[index]['quantity'],
                                      ),
                                    ),
                                  );
                                },
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      children: [
                                        // Product image
                                        _cartItems[index]['image'] != null
                                            ? Image.network(
                                                _cartItems[index]['image'],
                                                width: 100,
                                                height: 100,
                                                errorBuilder:
                                                    (context, error, stackTrace) {
                                                  return const Icon(Icons.error);
                                                },
                                              )
                                            : const Icon(Icons.image),
                                        const SizedBox(width: 10),
                                        // Product details
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                _cartItems[index]['title'],
                                                style:
                                                    const TextStyle(fontSize: 18),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                'EGP ${_cartItems[index]['price'].toStringAsFixed(2)}',
                                                style:
                                                    const TextStyle(fontSize: 16),
                                              ),
                                              const SizedBox(height: 4),
                                            ],
                                          ),
                                        ),

                                        Column(
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.delete),
                                              onPressed: () {
                                                // Get the document ID of the product to be deleted
                                                String documentId =
                                                    _cartItems[index].id;

                                                // Delete the product from Firebase
                                                _firestore
                                                    .collection('users')
                                                    .doc(_userId)
                                                    .collection('cartItems')
                                                    .doc(documentId)
                                                    .delete()
                                                    .then((_) {
                                                  // Product deleted successfully
                                                  Fluttertoast.showToast(
                                                    msg:
                                                        "Product Deleted Successfuly",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        const Color(0xff035696),
                                                    textColor: Colors.white,
                                                    fontSize: 15.0,
                                                  );
                                                }).catchError((error) {});
                                              },
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Total: EGP ${_totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            height: screenHeight * 0.05,
                            decoration: BoxDecoration(
                              color: const Color(0xff035696),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Check Out ',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.035,
                                    color: Colors.white,
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_right_alt,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                }
              },
            )
          : const Center(
              child: Text('Please login to view your cart'),
            ),
    );
  }
}
