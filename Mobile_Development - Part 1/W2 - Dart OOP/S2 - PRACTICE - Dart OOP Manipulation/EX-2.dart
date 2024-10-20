class BankAccount {
  int accountId;
  String accountOwner;
  double _balance = 0.0;

  BankAccount(this.accountId, this.accountOwner);

  double balance() => _balance;


  // Method to withdraw money from the account
  // Throws an exception if withdrawal amount exceeds the balance
  void withdraw(double amount) {
    if (amount > _balance) {
      throw Exception("Insufficient balance for withdrawal!");
    }
    _balance -= amount; // _balance = _balance - amount
  }

  // Method to credit (add) money to the account
  void credit(double amount) {
    _balance += amount;
  }
}

class Bank {
  String name;
  List<BankAccount> accounts = [];

  Bank({required this.name});

  BankAccount createAccount(int accountId, String accountOwner) {
    // Check if account ID already exists
    for (var account in accounts) {
      if (account.accountId == accountId) {
        throw Exception("Account with ID $accountId already exists!");
      }
    }
    // Create a new account
    var newAccount = BankAccount(accountId, accountOwner);
    accounts.add(newAccount);
    return newAccount;
  }
}

void main() {
  Bank myBank = Bank(name: "CADT Bank");
  BankAccount ehakAccount = myBank.createAccount(100, 'Ehak');

  print(ehakAccount.balance()); // Balance: $0
  ehakAccount.credit(100);
  print(ehakAccount.balance()); // Balance: $100
  ehakAccount.withdraw(50);
  print(ehakAccount.balance()); // Balance: $50

  try {
    ehakAccount.withdraw(75); // This will throw an exception
  } catch (e) {
    print(e); // Output: Insufficient balance for withdrawal!
  }

  try {
    myBank.createAccount(100, 'Vikol'); // This will throw an exception
  } catch (e) {
    print(e); // Output: Account with ID 100 already exists!
  }
}
