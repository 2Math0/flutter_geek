import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:getx_example/main.dart';
import 'package:mocktail/mocktail.dart';

// Mock classes
class MockNavigatorObserver extends Mock implements NavigatorObserver {}
class MockProductController extends Mock implements ProductController {}

void main() {
  late MockNavigatorObserver mockObserver;
  late MockProductController mockProductController;

  setUp(() {
    mockObserver = MockNavigatorObserver();
    mockProductController = MockProductController();

    // Mock getProductById method of ProductController
    when(() => mockProductController.getProductById(any()))
        .thenReturn(Product(id: 1, name: 'Test Product', price: 100));

    // Register mockProductController with GetX
    Get.put<ProductController>(mockProductController);
  });

  testWidgets('ProductsPage displays a list of products', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ProductsPage(),
      navigatorObservers: [mockObserver],
    ));

    // Verify initial UI state
    expect(find.text('Products'), findsOneWidget);
    expect(find.byType(ListTile), findsNWidgets(3)); // Assuming 3 mock products

    // Tap on a product and navigate to ProductDetailsPage
    await tester.tap(find.byType(ListTile).first);
    await tester.pumpAndSettle();

    // Verify navigation
    verify(() => mockObserver.didPush(any(), any())).called(1);
    expect(find.text('Product Details'), findsOneWidget);
  });

  testWidgets('ProductDetailsPage displays correct product details', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ProductDetailsPage(),
      navigatorObservers: [mockObserver],
    ));

    // Verify initial UI state
    expect(find.text('Product Details'), findsOneWidget);
    expect(find.text('Product Name: Test Product'), findsOneWidget);
    expect(find.text('Price: \$100'), findsOneWidget);
  });

  tearDown(() {
    Get.reset(); // Reset GetX bindings after each test
  });
}
