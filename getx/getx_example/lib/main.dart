import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

/// MyApp initializes GetMaterialApp which provides navigation and state management via GetX.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'E-commerce App',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => ProductsPage()),
        GetPage(
          name: '/product_details',
          page: () => ProductDetailsPage(),
          binding: ProductDetailsBinding(), // Bindings for lazy loading
          middlewares: [MyMiddleware()], // Apply middleware to this route
        ),
      ],
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}

/// Controller class to manage product-related state and business logic.
class ProductController extends GetxController {
  var productList = <Product>[
    Product(id: 1, name: 'Product 1', price: 100),
    Product(id: 2, name: 'Product 2', price: 150),
    Product(id: 3, name: 'Product 3', price: 200),
  ].obs;

  /// Get a product by its ID.
  Product getProductById(int id) {
    return productList.firstWhere((product) => product.id == id);
  }
}

/// Product model class to represent a product.
class Product {
  final int id;
  final String name;
  final double price;

  Product({required this.id, required this.name, required this.price});
}

/// ProductsPage displays a list of products and navigates to ProductDetailsPage on tap.
class ProductsPage extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: ListView.builder(
        itemCount: productController.productList.length,
        itemBuilder: (context, index) {
          Product product = productController.productList[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('Price: \$${product.price}'),
            onTap: () {
              Get.toNamed('/product_details', arguments: product.id);
            },
          );
        },
      ),
    );
  }
}

/// ProductDetailsPage displays details of a selected product.
class ProductDetailsPage extends StatelessWidget {
  final ProductController productController = Get.find<ProductController>();

  ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productId = Get.arguments as int;
    Product product = productController.getProductById(productId);

    return Scaffold(
      appBar: AppBar(title: const Text('Product Details')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Product Name: ${product.name}'),
            Text('Price: \$${product.price}'),
          ],
        ),
      ),
    );
  }
}

/// Binding class to lazily load ProductController for ProductDetailsPage.
class ProductDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductController());
  }
}

/// Example of a middleware class to intercept route transitions.
class MyMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    print('Middleware: Before handling route: $route');
    // Example: Redirect logic based on authentication status
    if (!isLoggedIn) {
      return const RouteSettings(name: '/login'); // Redirect to login if not logged in
    }
    return null; // Proceed with the original route
  }

  bool get isLoggedIn => true; // Example authentication check
}
