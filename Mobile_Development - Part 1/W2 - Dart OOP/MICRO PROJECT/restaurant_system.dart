import 'dart:io';

class MenuItem {
  String name;
  double price;

  MenuItem(this.name, this.price);

  @override
  String toString() => '$name: \$${price.toStringAsFixed(2)}';
}

class Menu {
  List<MenuItem> items = [];

  void addMenuItem(MenuItem item) {
    items.add(item);
  }

    void viewMenu() {
    print("\n--- Menu ---");
    for (int i = 0; i < items.length; i++) {
      print("${i + 1}. ${items[i]}");
    }
  }
}

class Customer {
  String name;
  String contactNumber;

  Customer(this.name, this.contactNumber);
}

class Table {
  int number;
  int seats;
  bool isReserved = false;

  Table(this.number, this.seats);

  @override
  String toString() {
    return 'Table $number: $seats seats (${isReserved ? "Reserved" : "Available"})';
  }
}

class Reservation {
  String customerName;
  Table table;
  DateTime reservationTime;

  Reservation(this.customerName, this.table, this.reservationTime);

  @override
  String toString() =>
      'Reservation for $customerName at Table ${table.number} on ${reservationTime}';
}

class Order {
  int orderID;
  List<MenuItem> items = [];
  String orderStatus = 'Pending';
  String paymentStatus = 'Unpaid';
  Customer customer;
  double totalPrice = 0.0;

  Order(this.orderID, this.customer);

  void addItem(MenuItem item) {
    items.add(item);
    totalPrice += item.price;
  }

  @override
  String toString() {
    return 'Order #$orderID for ${customer.name} (Contact: ${customer.contactNumber}): ${items.map((item) => item.name).join(", ")} - Status: $orderStatus, Payment: $paymentStatus, Total: \$${totalPrice.toStringAsFixed(2)}';
  }

}

class Restaurant {
  List<Table> tables = [];
  Menu menu = Menu();
  List<Customer> customers = [];
  List<Reservation> reservations = [];
  List<Order> orders = [];
  int _nextOrderID = 1;

  void addTable(Table table) {
    tables.add(table);
  }

  void addCustomer(Customer customer) {
    customers.add(customer);
  }

  void addReservation(Reservation reservation) {
    reservations.add(reservation);
    reservation.table.isReserved = true; 
  }

  void cancelReservation(String customerName) {
    reservations.removeWhere((reservation) {
      if (reservation.customerName == customerName) {
        reservation.table.isReserved = false; 
        return true;
      }
      return false;
    });
  }

  Order createOrder(Customer customer) {
    var order = Order(_nextOrderID++, customer);
    orders.add(order);
    return order;
  }

  void viewOrders() {
    print("\n--- Orders ---");
    if (orders.isEmpty) {
      print("No orders available.");
    } else {
      for (var order in orders) {
        print(order);
      }
    }
  }

  void viewReservations() {
    print("\n--- Reservations ---");
    if (reservations.isEmpty) {
      print("No reservations available.");
    } else {
      for (var reservation in reservations) {
        print('Customer name: ${reservation.customerName}');
        print('Table number: ${reservation.table.number} (${reservation.table.seats} seats)');
        print('Reservation Time: ${reservation.reservationTime}');
        print('---');
      }
    }
  }


  void viewTables() {
    print("\n--- Tables ---");
    if (tables.isEmpty) {
      print("No tables available.");
    } else {
      for (var table in tables) {
        print(table);
      }
    }
  }
}

void main() {
  Restaurant restaurant = Restaurant();

  // Initialize sample data
  restaurant.menu.addMenuItem(MenuItem("Burger", 8.99));
  restaurant.menu.addMenuItem(MenuItem("Pizza", 12.99));
  restaurant.menu.addMenuItem(MenuItem("Salad", 5.99));
  restaurant.addTable(Table(1, 4));
  restaurant.addTable(Table(2, 2));

  bool running = true;

  while (running) {
    print("\n--- Restaurant Management System ---");
    print("1. View Menu");
    print("2. Place Order");
    print("3. View Orders");
    print("4. Table Reservation");
    print("5. View Reservations");
    print("6. Cancel Reservation");
    print("7. Quit");
    stdout.write("Enter your choice: ");
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        restaurant.menu.viewMenu();
        break;
      case '2':
        stdout.write("Enter customer name: ");
        String? customerName = stdin.readLineSync();
        stdout.write("Enter contact number: ");
        String? contactNumber = stdin.readLineSync();

        if (customerName != null && contactNumber != null) {
          // Check if the customer already exists, or add a new customer
          Customer customer = restaurant.customers.firstWhere(
            (c) => c.name == customerName && c.contactNumber == contactNumber,
            orElse: () {
              var newCustomer = Customer(customerName, contactNumber);
              restaurant.addCustomer(newCustomer);
              return newCustomer;
            },
          );

          // Create the order for the customer
          Order order = restaurant.createOrder(customer);
          print("Placing a new order for ${customer.name}. Available menu items:");
          restaurant.menu.viewMenu();

          bool ordering = true;
          while (ordering) {
            stdout.write("Enter the number of the item to add to the order (or type 'done' to finish): ");
            String? input = stdin.readLineSync();
            if (input != null && input.toLowerCase() == 'done') {
              ordering = false;
            } else if (input != null) {
              int? itemNumber = int.tryParse(input);
              if (itemNumber != null && itemNumber > 0 && itemNumber <= restaurant.menu.items.length) {
                MenuItem menuItem = restaurant.menu.items[itemNumber - 1]; // Convert to 0-indexed
                order.addItem(menuItem);
                print("${menuItem.name} added to the order.");
              } else {
                print("Invalid item number. Please choose a valid number from the menu.");
              }
            }
          }
          print("Order placed successfully for ${customer.name}!");
          print(order); // Display order with total price
        } else {
          print("Customer name and contact number are required to place an order.");
        }
        break;

      case '3':
        restaurant.viewOrders();
        break;
      case '4':
        stdout.write("Enter customer name: ");
        String? customerName = stdin.readLineSync();
        stdout.write("Enter contact number: ");
        String? contactNumber = stdin.readLineSync();
        Customer customer = Customer(customerName!, contactNumber!);
        restaurant.addCustomer(customer);

        print("Available tables:");
        for (var table in restaurant.tables) {
          print(table);
        }

        stdout.write("Enter table number to reserve: ");
        String? tableNumberInput = stdin.readLineSync();
        int? tableNumber = int.tryParse(tableNumberInput!);

        if (tableNumber != null) {
          try {
            var table = restaurant.tables.firstWhere((t) => t.number == tableNumber && !t.isReserved);

            stdout.write("Enter reservation date (YYYY-MM-DD): ");
            String? dateInput = stdin.readLineSync();
            stdout.write("Enter reservation time (HH:MM): ");
            String? timeInput = stdin.readLineSync();

            if (dateInput != null && timeInput != null) {
              try {
                DateTime reservationDate = DateTime.parse('$dateInput $timeInput');
                Reservation reservation = Reservation(customer.name, table, reservationDate);
                restaurant.addReservation(reservation);
                print("Reservation created successfully for ${customer.name} at Table ${table.number} on $reservationDate.");
              } catch (e) {
                print("Invalid date or time format. Please try again.");
              }
            }
          } catch (e) {
            print("Table not found or already reserved.");
          }
        }
        break;
      case '5':
        restaurant.viewReservations();
        break;
      case '6':
        stdout.write("Enter customer name to cancel reservation: ");
        String? customerName = stdin.readLineSync();
        restaurant.cancelReservation(customerName!);
        print("Reservation cancelled for $customerName.");
        break;
      case '7':
        running = false;
        print("Exiting Restaurant Management System.");
        break;
      default:
        print("Invalid choice. Please try again.");
    }
  }
}
