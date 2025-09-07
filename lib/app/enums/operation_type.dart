enum OperationType {
  add('+'),
  subtract('-');

  final String symbol;
  const OperationType(this.symbol);
}
