class NumberValue {
  final num value;
  final String? currency;
  final bool isPercentage;

  NumberValue(this.value, {this.currency, this.isPercentage = false});

  @override
  String toString() {
    if (isPercentage) {
      return '${(value * 100).toStringAsFixed(2)}%';
    } else if (currency != null) {
      return '$currency${value.toStringAsFixed(2)}';
    }
    return value.toStringAsFixed(2);
  }

  NumberValue operator +(NumberValue other) {
    return NumberValue(value + other.value, currency: currency ?? other.currency);
  }

  NumberValue operator -(NumberValue other) {
    return NumberValue(value - other.value, currency: currency ?? other.currency);
  }

  NumberValue operator *(num factor) {
    return NumberValue(value * factor, currency: currency, isPercentage: isPercentage);
  }

  NumberValue operator /(num divisor) {
    return NumberValue(value / divisor, currency: currency, isPercentage: isPercentage);
  }
}