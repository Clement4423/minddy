class CustomTableCellPosition {
  final int row;
  final int column;

  CustomTableCellPosition({required this.row, required this.column});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomTableCellPosition &&
          runtimeType == other.runtimeType &&
          row == other.row &&
          column == other.column;

  @override
  int get hashCode => row.hashCode ^ column.hashCode;
}
