import 'package:e_commerce_app/core/app_theme.dart';
import 'package:flutter/material.dart';

class Product{
  double price;
  int count;
  String color;
  String imageSrc;
  String title;

  Product({
    required this.price,
    required this.color,
    required this.imageSrc,
    required this.title,
    required this.count,
  });
}

class CartPage extends StatelessWidget{
  CartPage({super.key});

  List <Product> lst = [
    Product(
      price: 150,
      color: "Orange",
      imageSrc: 'https://images.pexels.com/photos/41162/moon-landing-apollo-11-nasa-buzz-aldrin-41162.jpeg?cs=srgb&dl=pexels-pixabay-41162.jpg&fm=jpg',
      title: "Shoes",
      count: 5
    ),
    Product(
      price: 5000,
      color: "Orange",
      imageSrc: 'https://images.pexels.com/photos/41162/moon-landing-apollo-11-nasa-buzz-aldrin-41162.jpeg?cs=srgb&dl=pexels-pixabay-41162.jpg&fm=jpg',
      title: "Watch",
      count: 7
    ),Product(
      price: 150,
      color: "Orange",
      imageSrc: 'https://images.pexels.com/photos/41162/moon-landing-apollo-11-nasa-buzz-aldrin-41162.jpeg?cs=srgb&dl=pexels-pixabay-41162.jpg&fm=jpg',
      title: "Hat",
      count: 1
    ),Product(
      price: 150,
      color: "Orange",
      imageSrc: 'https://images.pexels.com/photos/41162/moon-landing-apollo-11-nasa-buzz-aldrin-41162.jpeg?cs=srgb&dl=pexels-pixabay-41162.jpg&fm=jpg',
      title: "T-Shirt",
      count: 2
    ),
  ];

  Widget makeProductCard(index) =>
    Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
          ),
          width: 70,
          height: 70,
          child: Image(
            image: NetworkImage(lst[index].imageSrc),
            fit: BoxFit.cover
            
          ),
        ),
        SizedBox(width: 7,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(lst[index].title),
            Text("EGP ${lst[index].price}"),
          ],
        ),
        Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(onPressed: (){}, icon: Icon(Icons.delete)),
            Text(lst[index].count.toString()),
          ],
        )
      ],
    );

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart",style: appTheme.textTheme.displayLarge,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 90),
              child: ListView.separated(
                itemBuilder: (context,index) => makeProductCard(index),
                separatorBuilder: (context,index) => const SizedBox(height: 20,),
                itemCount: lst.length,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Price",
                        style: appTheme.textTheme.bodyMedium,
                      ),
                      Text(
                        "EGP 1200",
                        style: appTheme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  // const Spacer(),
                  Container(
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [primaryColor, secondaryColor],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: MaterialButton(
                      onPressed: (){},
                      child: const Text("Purchase"),
                    ),
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