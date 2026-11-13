const menu = {'Adobo rice': 85.0, 'Iced tea': 35.0, 'Turon': 25.0};

class OrderItem {
  final String name;
  final double price;
  final int qty;

  OrderItem({required this.name, required this.price, required this.qty});

  double get subtotal => price * qty;
}

OrderItem orderOf(String name, int qty) {
  final price = menu[name];
  if (price == null) {
    throw ArgumentError('Unknown menu item: $name');
  }
  return OrderItem(name: name, price: price, qty: qty);
}

double total(List<OrderItem> items) =>
    items.fold(0.0, (sum, item) => sum + item.subtotal);

String _receiptLine(String label, double amount) =>
    '${label.padRight(16)}${amount.toStringAsFixed(2).padLeft(8)}';

void printReceipt(List<OrderItem> items, {String? customer}) {
  print('Order for ${customer ?? 'Guest'}');

  for (final item in items) {
    print(_receiptLine('${item.qty} x ${item.name}', item.subtotal));
  }

  final subtotal = total(items);
  print(_receiptLine('Subtotal', subtotal));

  final discount = subtotal >= 300 ? subtotal * 0.10 : 0.0;
  if (discount > 0) {
    print(_receiptLine('Discount 10%', -discount));
  }

  print(_receiptLine('Total', subtotal - discount));
}

void main() {
  final firstOrder = [
    orderOf('Adobo rice', 3),
    orderOf('Iced tea', 1),
    orderOf('Turon', 3),
  ];
  printReceipt(firstOrder);

  print('');

  final secondOrder = [
    orderOf('Adobo rice', 1),
    orderOf('Iced tea', 1),
    orderOf('Turon', 1),
  ];
  printReceipt(secondOrder, customer: 'Maria');
}
