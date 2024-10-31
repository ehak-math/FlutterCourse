import 'dart:io';

class MenuItem {
  String name;
  double price;
  String category;

  MenuItem({required this.name, required this.price, required this.category});

  @override
  String toString() {
    return "$name (\$${price.toStringAsFixed(2)}) - $category";
  }
}

class Menu {
  List<MenuItem> items = [];

  void addItem(MenuItem item) {
    items.add(item);
    print("Added item: ${item.name}");
  }

  void displayMenu() {
    print("\n--- Menu ---");
    for (var i = 0; i < items.length; i++) {
      print("${i + 1}. ${items[i]}");
    }
  }
}

class Order {
  int orderID;
  String customerName;
  List<MenuItem> items = [];
  double totalPrice = 0.0;
  String orderStatus = 'Pending';
  String paymentStatus = 'Unpaid';

  Order({required this.orderID, required this.customerName});

  void addItem(MenuItem item) {
    items.add(item);
    calculateTotalPrice();
  }

  void calculateTotalPrice() {
    totalPrice = items.fold(0.0, (sum, item) => sum + item.price);
  }

  @override
  String toString() {
    return "Customer Name: $customerName\nItems: ${items.map((item) => item.toString()).join(', ')}\nTotal Price: \$${totalPrice.toStringAsFixed(2)}\nStatus: $orderStatus\nPayment Status: $paymentStatus\n";
  }
}

class Table {
  int number;
  int seats;
  bool isReserved = false;
  String? reservedBy;

  Table(this.number, this.seats);

  void reserve(String customerName) {
    isReserved = true;
    reservedBy = customerName;
  }

  void cancelReservation() {
    isReserved = false;
    reservedBy = null;
  }

  @override
  String toString() {
    String status = isReserved ? "(unavailable, reserved by $reservedBy)" : "(available)";
    return "Table $number with $seats seats $status";
  }
}

class Reservation {
  String customerName;
  Table table;
  DateTime reservationTime;

  Reservation({required this.customerName, required this.table, required this.reservationTime});

  @override
  String toString() {
    return "Customer Name: $customerName\nTable: ${table.number} with ${table.seats} seats\nReserved At: $reservationTime";
  }
}

class Customer {
  String name;
  String contactNumber;

  Customer({required this.name, required this.contactNumber});

  @override
  String toString() {
    return "Customer: $name, Contact: $contactNumber";
  }
}

void main() {
  // Create menu and add items
  Menu menu = Menu();
  menu.addItem(MenuItem(name: "Burger", price: 8.99, category: "food"));
  menu.addItem(MenuItem(name: "Pasta", price: 12.50, category: "food"));
  menu.addItem(MenuItem(name: "Coffee", price: 3.00, category: "drink"));
  menu.addItem(MenuItem(name: "Lemonade", price: 2.50, category: "drink"));

  // Initialize tables
  List<Table> tables = [
    Table(1, 2),
    Table(2, 4),
    Table(3, 2),
    Table(4, 2),
    Table(5, 4),
    Table(6, 6),
    Table(7, 4),
  ];

  List<Order> orders = [];
  List<Reservation> reservations = [];
  int orderIDCounter = 1;

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

    stdout.write("Please choose an option (1-7): ");
    String? input = stdin.readLineSync();

    switch (input) {
      case '1':
        menu.displayMenu();
        break;

      case '2':
        stdout.write("Enter customer name: ");
        String customerName = stdin.readLineSync()!;
        stdout.write("Enter contact number: ");
        String contactNumber = stdin.readLineSync()!;
        Customer customer = Customer(name: customerName, contactNumber: contactNumber);
        
        menu.displayMenu();
        List<MenuItem> selectedItems = [];
        double currentTotalPrice = 0.0;

        while (true) {
          stdout.write("Enter the number of the item to order (0 to finish): ");
          int? itemNumber = int.tryParse(stdin.readLineSync()!);
          if (itemNumber == 0) break;
          if (itemNumber != null && itemNumber > 0 && itemNumber <= menu.items.length) {
            MenuItem chosenItem = menu.items[itemNumber - 1];
            selectedItems.add(chosenItem);
            currentTotalPrice += chosenItem.price;
            print("You chose: ${chosenItem}");
            print("Total Price: \$${currentTotalPrice.toStringAsFixed(2)}");
          } else {
            print("Invalid item number. Please try again.");
          }
        }
        
        Order order = Order(orderID: orderIDCounter++, customerName: customer.name);
        for (var item in selectedItems) {
          order.addItem(item);
        }
        order.orderStatus = 'Completed';
        order.paymentStatus = 'Paid';
        orders.add(order);
        print("\nOrder Summary:\n$order");
        break;

      case '3':
        print("\n--- Order Summary ---");
        if (orders.isEmpty) {
          print("No orders placed yet.");
        } else {
          for (var i = 0; i < orders.length; i++) {
            print("${i + 1}. ${orders[i]}");
          }
        }
        break;

      case '4':
        print("\nAvailable Tables:");
        for (var table in tables) {
          print(table);
        }
        stdout.write("Enter customer name for reservation: ");
        String customerName = stdin.readLineSync()!;
        stdout.write("Enter contact number: ");
        String contactNumber = stdin.readLineSync()!;
        Customer customer = Customer(name: customerName, contactNumber: contactNumber);
        stdout.write("Enter the table number to reserve: ");
        int tableNumber = int.parse(stdin.readLineSync()!);
        stdout.write("Enter reservation date and time (YYYY-MM-DD HH:MM): ");
        String dateTimeStr = stdin.readLineSync()!;
        DateTime reservationTime = DateTime.parse(dateTimeStr);

        Table? selectedTable;
        try {
          selectedTable = tables.firstWhere((table) => table.number == tableNumber && !table.isReserved);
        } catch (e) {
          selectedTable = null;
        }

        if (selectedTable != null) {
          selectedTable.reserve(customer.name);
          Reservation reservation = Reservation(
              customerName: customer.name, table: selectedTable, reservationTime: reservationTime);
          reservations.add(reservation);
          print("\nReservation confirmed:\n$reservation");
        } else {
          print("Table is either unavailable or does not exist.");
        }

        break;

      case '5':
        print("\n--- Reservations ---");
        if (reservations.isEmpty) {
          print("No reservations made yet.");
        } else {
          for (var i = 0; i < reservations.length; i++) {
            print("${i + 1}. ${reservations[i]}");
          }
        }
        break;

      case '6':
        // Cancel Reservation
        print("\n--- Cancel Reservation ---");
        if (reservations.isEmpty) {
          print("No reservations made yet.");
        } else {
          print("Select the reservation to cancel (enter number):");
          for (var i = 0; i < reservations.length; i++) {
            print("${i + 1}. ${reservations[i]}");
          }
          int? cancelIndex = int.tryParse(stdin.readLineSync()!);
          if (cancelIndex != null && cancelIndex > 0 && cancelIndex <= reservations.length) {
            Reservation reservationToCancel = reservations[cancelIndex - 1];
            reservationToCancel.table.cancelReservation(); // Cancel the table reservation
            reservations.removeAt(cancelIndex - 1); // Remove from list
            print("Reservation for ${reservationToCancel.customerName} at table ${reservationToCancel.table.number} has been canceled.");
          } else {
            print("Invalid selection. Please try again.");
          }
        }
        break;

      case '7':
        running = false;
        print("Thank you for visiting! Goodbye.");
        break;

      default:
        print("Invalid option. Please try again.");
    }
  }
}
