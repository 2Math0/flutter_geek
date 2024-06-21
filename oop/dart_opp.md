# Index

1. [Object-Oriented Programming in Dart](#object-oriented-programming-in-dart)
   - [Classes and Objects](#classes-and-objects)
   - [Encapsulation](#encapsulation)
   - [Inheritance](#inheritance)
   - [Polymorphism](#polymorphism)
   - [Abstraction](#abstraction)
   - [Different Class Types in Dart](#different-class-types-in-dart)
     - [Abstract Classes](#abstract-classes)
     - [Interfaces](#interfaces)
     - [Mixins](#mixins)
     - [Sealed Classes](#sealed-classes)
   - [Implements vs. With Keywords](#implements-vs-with-keywords)
2. [Design Patterns in Flutter](#design-patterns-in-flutter)
   - [Singleton Pattern](#singleton-pattern)
   - [Factory Pattern](#factory-pattern)
   - [Provider Pattern](#provider-pattern)
   - [Observer Pattern](#observer-pattern)
3. [Use Cases for Each Pattern](#use-cases-for-each-pattern)
4. [Comprehensive Example](#comprehensive-example)

# Object-Oriented Programming in Dart

## Classes and Objects

**Concept**: Classes are blueprints for objects. Objects are instances of classes. This fundamental concept allows you to define the properties and behaviors (methods) that the objects created from the class will have.

**Dart Implementation**:

```dart
class Person {
  String name;
  int age;

  Person(this.name, this.age);

  void displayInfo() {
    print('Name: $name, Age: $age');
  }
}

void main() {
  Person person = Person('John', 25);
  person.displayInfo(); // Output: Name: John, Age: 25
}
```

## Encapsulation

**Concept**: Encapsulation involves bundling the data (variables) and methods that operate on the data into a single unit, typically a class. It also includes restricting direct access to some of the object's components, which can be achieved using private fields and public methods.

**Dart Implementation**:

```dart
class Counter {
  int _count = 0; // private variable

  int get count => _count; // public getter

  void increment() {
    _count++;
  }
}

void main() {
  Counter counter = Counter();
  counter.increment();
  print(counter.count); // Output: 1
}
```

## Inheritance

**Concept**: Inheritance allows one class (subclass/derived class) to inherit the properties and methods of another class (superclass/base class).

**Dart Implementation**:

```dart
class Animal {
  void speak() {
    print('Animal speaks');
  }
}

class Dog extends Animal {
  @override
  void speak() {
    print('Dog barks');
  }
}

void main() {
  Dog dog = Dog();
  dog.speak(); // Output: Dog barks
}
```

## Polymorphism

**Concept**: Polymorphism allows methods to do different things based on the object it is acting upon, even if they share the same name.

**Dart Implementation**:

```dart
class Animal {
  void speak() {
    print('Animal speaks');
  }
}

class Dog extends Animal {
  @override
  void speak() {
    print('Dog barks');
  }
}

class Cat extends Animal {
  @override
  void speak() {
    print('Cat meows');
  }
}

void main() {
  Animal myDog = Dog();
  Animal myCat = Cat();

  myDog.speak(); // Output: Dog barks
  myCat.speak(); // Output: Cat meows
}
```

## Abstraction

**Concept**: Abstraction allows you to hide the complex implementation details and show only the essential features of the object.

**Dart Implementation**:

```dart
abstract class Shape {
  void draw();
}

class Circle extends Shape {
  @override
  void draw() {
    print('Drawing a Circle');
  }
}

class Square extends Shape {
  @override
  void draw() {
    print('Drawing a Square');
  }
}

void main() {
  Shape shape1 = Circle();
  Shape shape2 = Square();

  shape1.draw(); // Output: Drawing a Circle
  shape2.draw(); // Output: Drawing a Square
}
```

## Different Class Types in Dart

### Abstract Classes

**Concept**: Abstract classes cannot be instantiated and are used to define common behavior that other classes can inherit and implement.

**Dart Implementation**:

```dart
abstract class Animal {
  void makeSound();
}

class Dog extends Animal {
  @override
  void makeSound() {
    print('Bark');
  }
}

class Cat extends Animal {
  @override
  void makeSound() {
    print('Meow');
  }
}

void main() {
  Dog dog = Dog();
  Cat cat = Cat();

  dog.makeSound(); // Output: Bark
  cat.makeSound(); // Output: Meow
}
```

### Interfaces

**Concept**: Dart does not have a special keyword for interfaces. Instead, it uses abstract classes or any class can be used as an interface. Any class can implement an interface (another class) by defining all its methods.

**Dart Implementation**:

```dart
class Printer {
  void printData(String data);
}

class ConsolePrinter implements Printer {
  @override
  void printData(String data) {
    print(data);
  }
}

void main() {
  ConsolePrinter printer = ConsolePrinter();
  printer.printData('Hello, Interface!'); // Output: Hello, Interface!
}
```

### Mixins

**Concept**: Mixins allow you to add functionality to a class from multiple classes without using inheritance.

**Dart Implementation**:

```dart
mixin Musical {
  void playMusic() {
    print('Playing music');
  }
}

class Performer with Musical {
  void perform() {
    print('Performing on stage');
  }
}

void main() {
  Performer performer = Performer();
  performer.perform();  // Output: Performing on stage
  performer.playMusic(); // Output: Playing music
}
```

### Sealed Classes

**Concept**: Sealed classes are used to restrict the subclasses that can extend or implement them. They provide a way to ensure that all possible subclasses are known and can be enumerated at compile time.

**Dart Implementation**:

```dart
sealed class Shape {}

class Circle extends Shape {}

class Square extends Shape {}

void describeShape(Shape shape) {
  if (shape is Circle) {
    print('This is a Circle');
  } else if (shape is Square) {
    print('This is a Square');
  }
}

void main() {
  Shape circle = Circle();
  Shape square = Square();

  describeShape(circle); // Output: This is a Circle
  describeShape(square); // Output: This is a Square
}
```

## Implements vs. With Keywords

### Implements

**Concept**: The `implements` keyword is used to implement an interface (another class). The implementing class must provide concrete implementations for all the methods defined in the interface.

**Dart Implementation**:

```dart
class Printer {
  void printData(String data);
}

class ConsolePrinter implements Printer {
  @override
  void printData(String data) {
    print(data);
  }
}

void main() {
  ConsolePrinter printer = ConsolePrinter();
  printer.printData('Hello, Interface!'); // Output: Hello, Interface!
}
```

### With

**Concept**: The `with` keyword is used to apply mixins. A mixin class provides methods and properties that can be added to other classes.

**Dart Implementation**:

```dart
mixin Musical {
  void playMusic() {
    print('Playing music');
  }
}

class Performer with Musical {
  void perform() {
    print('Performing on stage');
  }
}

void main() {
  Performer performer = Performer();
  performer.perform();  // Output: Performing on stage
  performer.playMusic(); // Output: Playing music
}
```

# Design Patterns in Flutter

## Singleton Pattern

**Concept**: The Singleton pattern ensures a class has only one instance and provides a global point of access to it.

**Use Case**: Managing a shared resource like a database connection or a configuration manager.

**Dart Implementation**:

```dart
class Singleton {
  Singleton._privateConstructor();

  static final Singleton instance = Singleton._privateConstructor();

  void showMessage() {
    print('Singleton instance');
  }
}

void main() {
  Singleton singleton1 = Singleton.instance;
  Singleton singleton2 = Singleton.instance;

  singleton1.showMessage(); // Output: Singleton instance
  print(singleton1 == singleton2); // Output: true (both references point to the same instance)
}
```

## Factory Pattern

**Concept**: The Factory pattern provides a way to create objects without specifying the exact class of the object that will be created.

**Use Case**: Creating objects when the exact class of the object isn't known until runtime.

**Dart Implementation**:

```dart
abstract class Shape {
  void draw();
}

class Circle implements Shape {
  @override
  void draw() {
    print('Drawing a Circle');
  }
}

class Square implements Shape {
  @override
  void draw() {
    print('Drawing a Square');
  }
}

class ShapeFactory {
  static Shape createShape(String type) {
    if (type == 'circle') {
      return Circle();
    } else if (type == 'square') {
      return Square();
    } else {
      throw Exception('Unknown shape type');
    }
  }
}

void main() {
  Shape shape1 = ShapeFactory.createShape('circle');
  Shape shape2 = ShapeFactory.createShape('

square');

  shape1.draw(); // Output: Drawing a Circle
  shape2.draw(); // Output: Drawing a Square
}
```

## Provider Pattern

**Concept**: The Provider pattern is widely used in Flutter for state management. It provides a way to manage state in a scalable and efficient manner.

**Use Case**: Managing application state in Flutter applications.

**Flutter Implementation**:

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Counter with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Counter(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Provider Example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('You have pushed the button this many times:'),
              Consumer<Counter>(
                builder: (context, counter, child) {
                  return Text(
                    '${counter.count}',
                    style: Theme.of(context).textTheme.headline4,
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Provider.of<Counter>(context, listen: false).increment();
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
```

## Observer Pattern

**Concept**: The Observer pattern defines a one-to-many dependency between objects so that when one object changes state, all its dependents are notified and updated automatically.

**Use Case**: Implementing event handling systems, like updating the UI in response to state changes.

**Dart Implementation**:

```dart
class Observer {
  void update() {}
}

class Subject {
  List<Observer> _observers = [];

  void addObserver(Observer observer) {
    _observers.add(observer);
  }

  void removeObserver(Observer observer) {
    _observers.remove(observer);
  }

  void notifyObservers() {
    for (Observer observer in _observers) {
      observer.update();
    }
  }
}

class ConcreteObserver implements Observer {
  @override
  void update() {
    print('Observer has been notified');
  }
}

void main() {
  Subject subject = Subject();
  ConcreteObserver observer1 = ConcreteObserver();
  ConcreteObserver observer2 = ConcreteObserver();

  subject.addObserver(observer1);
  subject.addObserver(observer2);

  subject.notifyObservers(); // Output: Observer has been notified (twice)
}
```

# Use Cases for Each Pattern

- **Singleton Pattern**: Use for a centralized manager like a configuration manager, logging service, or database connection.
- **Factory Pattern**: Use when the class of the object to be created is determined at runtime, such as creating different UI components based on user input.
- **Provider Pattern**: Use for state management in Flutter applications, ensuring that state changes are efficiently propagated to the UI.
- **Observer Pattern**: Use for implementing event-driven systems where changes in one part of the application need to be observed and acted upon by other parts.

# Comprehensive Example

Combining OOP principles and design patterns in a Flutter application.

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ShoppingCart(),
      child: MyApp(),
    ),
  );
}

// Product class representing a product item
class Product {
  final String name;
  final double price;

  Product(this.name, this.price);
}

// ShoppingCart class to manage the list of products
class ShoppingCart with ChangeNotifier {
  final List<Product> _products = [];

  List<Product> get products => _products;

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners(); // Notify listeners when the state changes
  }

  double get totalPrice => _products.fold(0, (total, current) => total + current.price);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductListScreen(),
    );
  }
}

// Screen displaying the list of products
class ProductListScreen extends StatelessWidget {
  final List<Product> products = [
    Product('Apple', 1.0),
    Product('Banana', 0.5),
    Product('Orange', 1.2),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Products')),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index].name),
            subtitle: Text('\$${products[index].price}'),
            trailing: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                // Add product to cart using Provider
                Provider.of<ShoppingCart>(context, listen: false).addProduct(products[index]);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.shopping_cart),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CartScreen()),
          );
        },
      ),
    );
  }
}

// Screen displaying the shopping cart
class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shopping Cart')),
      body: Consumer<ShoppingCart>(
        builder: (context, cart, child) {
          return ListView.builder(
            itemCount: cart.products.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(cart.products[index].name),
                subtitle: Text('\$${cart.products[index].price}'),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Consumer<ShoppingCart>(
        builder: (context, cart, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total: \$${cart.totalPrice}',
              style: TextStyle(fontSize: 20),
            ),
          );
        },
      ),
    );
  }
}
```

In this comprehensive example:
- **OOP Concepts**: 
  - Classes (`Product`, `ShoppingCart`)
  - Encapsulation (private `_products` list with public getters)
  - Abstraction (`ShoppingCart` class hides the details of managing the product list)
- **Design Patterns**:
  - Provider Pattern for state management
  - Singleton Pattern could be applied if there was a need for a centralized manager (e.g., a service locator)
  - Observer Pattern is inherently used with `ChangeNotifier` and `Consumer` in the Provider pattern. 

This example showcases how to combine OOP principles with design patterns to build a scalable and maintainable Flutter application.