class Item {
  final String name;
  final String brand;
  final String type;
  final int    amount;
  final String description;

  Item(this.name, this.brand, this.type, this.amount, this.description);
}

// List item & dummy data
List <Item> items = [
  Item("Keyboard", "Nord", "Stage 4", 2, "In good conditions"),
  Item("Guitar", "Fender", "Telecaster", 1, "It has broken strings")
];