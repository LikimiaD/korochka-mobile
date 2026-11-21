import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:korochka/data/seed_accounts.dart';
import 'package:korochka/data/seed_products.dart';
import 'package:korochka/data/validation.dart';
import 'package:korochka/models/account.dart';
import 'package:korochka/models/cart_item.dart';
import 'package:korochka/models/product.dart';

const int maxQuantityPerItem = 20;

class BakeryStore extends ChangeNotifier {
  final List<Account> _accounts = seedAccounts();
  final List<Product> _products = seedProducts();
  final List<CartItem> _cart = [];
  Account? _currentAccount;

  Account? get currentAccount => _currentAccount;

  bool registerAccount({
    required String name,
    required String phone,
    required String password,
  }) {
    final normalizedPhone = normalizePhone(phone);
    if (normalizedPhone == null) {
      return false;
    }
    if (!isValidName(name) || !isValidPassword(password)) {
      return false;
    }
    if (_findAccount(normalizedPhone) != null) {
      return false;
    }
    final account = Account(
      name: name.trim(),
      phone: normalizedPhone,
      password: password,
    );
    _accounts.add(account);
    _currentAccount = account;
    notifyListeners();
    return true;
  }

  bool loginAccount({required String phone, required String password}) {
    final normalizedPhone = normalizePhone(phone);
    if (normalizedPhone == null) {
      return false;
    }
    final account = _findAccount(normalizedPhone);
    if (account == null || account.password != password) {
      return false;
    }
    _currentAccount = account;
    notifyListeners();
    return true;
  }

  void logoutAccount() {
    _currentAccount = null;
    _cart.clear();
    notifyListeners();
  }

  Product? findProduct(int id) {
    return _products.where((product) => product.id == id).firstOrNull;
  }

  List<Product> listProducts(ProductCategory? category) {
    if (category == null) {
      return _products.toList();
    }
    return _products.where((product) => product.category == category).toList();
  }

  void setProductAvailability(int productId, bool isAvailable) {
    findProduct(productId)?.isAvailable = isAvailable;
    notifyListeners();
  }

  List<CartItem> get cart => _cart.toList();

  int get cartCount {
    var count = 0;
    for (final item in _cart) {
      count += item.quantity;
    }
    return count;
  }

  int get cartTotal {
    var total = 0;
    for (final item in _cart) {
      total += item.total;
    }
    return total;
  }

  bool get cartHasUnavailable {
    return _cart.any((item) => !item.product.isAvailable);
  }

  int getCartQuantity(int productId) {
    return _findCartItem(productId)?.quantity ?? 0;
  }

  bool addCartItem(Product product, {int quantity = 1}) {
    if (!product.isAvailable) {
      return false;
    }
    final item = _findCartItem(product.id);
    if (item == null) {
      _cart.add(
        CartItem(product: product, quantity: min(quantity, maxQuantityPerItem)),
      );
    } else {
      item.quantity = min(item.quantity + quantity, maxQuantityPerItem);
    }
    notifyListeners();
    return true;
  }

  void changeCartQuantity(int productId, int delta) {
    final item = _findCartItem(productId);
    if (item == null) {
      return;
    }
    item.quantity = min(item.quantity + delta, maxQuantityPerItem);
    if (item.quantity < 1) {
      _cart.remove(item);
    }
    notifyListeners();
  }

  void removeCartItem(int productId) {
    _cart.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  Account? _findAccount(String phone) {
    return _accounts.where((account) => account.phone == phone).firstOrNull;
  }

  CartItem? _findCartItem(int productId) {
    return _cart.where((item) => item.product.id == productId).firstOrNull;
  }
}
