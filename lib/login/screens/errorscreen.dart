import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// import 'FavoritesPage.dart';
// import 'ShoppingCart.dart';
class Product {
  final String title;
  final int? price;
  final String description;
  final List<dynamic> image;

  Product({
    required this.title,
    required this.price,
    required this.description,
    required this.image,
  });
}

class Favorites {
  List<Product> favoritesList = [];

  void addFavorite(Product product) {
    favoritesList.add(product);
  }

  void removeFavorite(Product product) {
    favoritesList.remove(product);
  }
}

class Shopping {
  List<Product> cartList = [];

  void addCart(Product product) {
    cartList.add(product);
  }

  void removeCart(Product product) {
    cartList.remove(product);
  }
}

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> products = [];
  Favorites favorites = Favorites();
  Shopping cart = Shopping();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final apiUrl = Uri.parse('https://dummyjson.com/products');
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic>? productList = data['products'];

        if (productList != null) {
          setState(() {
            products = productList
                .map((item) => Product(
                      title: item['title'] != null
                          ? item['title'].toString()
                          : 'Unknown Title',
                      price: item['price'] != null
                          ? int.parse(item['price'].toString())
                          : null,
                      description: item['description'] != null
                          ? item['description'].toString()
                          : '',
                      image: item['images'],
                    ))
                .toList();
          });
        } else {
          print('Product list is null in the response');
        }
      } else {
        print('Failed to fetch data. Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping'),
        backgroundColor: Colors.green,
        actions: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.favorite_border),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => FavoritesPage(favorites: favorites),
                  //   ),
                  // );
                },
              ),
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         ShoppingCart(cart: cart), // Fix here
                  //   ),
                  // );
                },
              ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return _buildProductRow(context, products[index]);
        },
      ),
    );
  }

  Widget _buildProductRow(BuildContext context, Product product) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              // Image.network(product.image.isNotEmpty ? product.image[0] : '',
              //     width: 100, height: 100),
              Container(
                child: product.image.isNotEmpty
                    ? Image.network(
                  product.image[0],
                  width: 100,
                  height: 100,
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey, // Placeholder for missing image
                    );
                  },
                )
                    : Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey, // Placeholder for missing image
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.add_shopping_cart),
                    onPressed: () {
                      setState(() {
                        if (cart.cartList.contains(product)) {
                          cart.removeCart(product);
                        } else {
                          cart.addCart(product);
                        }
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.favorite_border),
                    onPressed: () {
                      setState(() {
                        if (favorites.favoritesList.contains(product)) {
                          favorites.removeFavorite(product);
                        } else {
                          favorites.addFavorite(product);
                        }
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              Text(
                product.title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Price: \$${product.price ?? 0.00}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
// Handle the onPressed action for the product details button
                },
                child: Text('Product Details'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
