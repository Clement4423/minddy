import 'dart:math';

import 'package:minddy/system/model/number_value.dart';

double average(List<num> numbers) {
  return sum(numbers) / numbers.length;
}

double sum(List<num> numbers) {
  double sum = 0;
  for (num number in numbers) {
    sum += number;
  }
  return sum;
}

num maximum(List<num> numbers) {
  if (numbers.isEmpty) {
    return 0;
  }
  return numbers.reduce((current, next) => current > next ? current : next);
}

num minimum(List<num> numbers) {
  if (numbers.isEmpty) {
    return 0;
  }
  return numbers.reduce((current, next) => current < next ? current : next);
}

num interval(List<num> numbers) {
  return maximum(numbers) - minimum(numbers);
}

num median(List<num> numbers) {
  if (numbers.isEmpty) {
    return 0;
  }
  numbers.sort();
  int n = numbers.length;
  if (n % 2 == 1) {
    return numbers[n ~/ 2];
  } else {
    return (numbers[(n ~/ 2) - 1] + numbers[n ~/ 2]) / 2;
  }
}

double variance(List<num> numbers) {
  if (numbers.isEmpty) {
    return 0;
  }

  double avg = average(numbers);
  double sumOfSquares = numbers
      .map((number) => (number - avg) * (number - avg))
      .reduce((a, b) => a + b);
  return sumOfSquares / numbers.length;
}

double standardDeviation(List<num> numbers) {
  return sqrt(variance(numbers));
}

List<num> quartiles(List<num> numbers) {
  numbers.sort();
  int n = numbers.length;
  num q1 = (n % 4 == 0)
      ? (numbers[n ~/ 4 - 1] + numbers[n ~/ 4]) / 2
      : numbers[(n / 4).floor()];
  num q2 = median(numbers);
  num q3 = (n % 4 == 0)
      ? (numbers[3 * n ~/ 4 - 1] + numbers[3 * n ~/ 4]) / 2
      : numbers[(3 * n / 4).floor()];
  return [q1, q2, q3];
}

num interquartileRange(List<num> numbers) {
  List<num> qs = quartiles(numbers);
  return qs[2] - qs[0];
}

num mode(List<num> numbers) {
  if (numbers.isEmpty) {
    return 0;
  }

  Map<num, int> frequency = {};
  for (num number in numbers) {
    frequency[number] = (frequency[number] ?? 0) + 1;
  }
  int maxFrequency = frequency.values
      .reduce((current, next) => current > next ? current : next);
  return frequency.entries
      .firstWhere((element) => element.value == maxFrequency)
      .key;
}

num flipSign(num number) {
  return number * -1;
}

String formatCalculation(String input) {
  if (input.startsWith('=')) {
    return input;
  }

  bool isNegative = input.startsWith('-');

  input = input.replaceAll('-', '');

  input = input.replaceAll(' ', '');

  RegExp currencyRegex = RegExp(r'^(\$|£|€|¥)|(\$|£|€|¥)$');

  String? currency;
  bool isPercentage = false;

  if (input.contains(currencyRegex)) {
    Match? currencyMatch = currencyRegex.firstMatch(input);
    currency = currencyMatch?.group(1) ?? currencyMatch?.group(2);
    input = input.replaceAllMapped(currencyRegex, (match) => '');
  } else if (input.endsWith('%')) {
    isPercentage = true;
    input = input.replaceAll('%', '');
  }

  List<String> parts = input.split(',');
  String integerPart = parts[0];
  String fractionalPart = parts.length > 1 ? parts[1] : '';

  String formattedIntegerPart = _addSpacesToIntegerPart(integerPart);
  return fractionalPart.isEmpty || fractionalPart.replaceAll('0', '').isEmpty
      ? '${isNegative ? '-' : ''}${currency != null && currency == "\$" ? '\$' : ''}$formattedIntegerPart${currency != null && currency != "\$" ? currency : ''}${isPercentage ? '%' : ''}'
      : '${isNegative ? '-' : ''}${currency != null && currency == "\$" ? '\$' : ''}$formattedIntegerPart,$fractionalPart${currency != null && currency != "\$" ? currency : ''}${isPercentage ? '%' : ''}';
}

// This will add space so a number like 1000,52 will look like 1 000,52
String _addSpacesToIntegerPart(String input) {
  StringBuffer buffer = StringBuffer();
  int length = input.length;
  int count = 0;

  for (int i = length - 1; i >= 0; i--) {
    buffer.write(input[i]);
    count++;
    if (count % 3 == 0 && i != 0) {
      buffer.write(' ');
    }
  }

  return buffer.toString().split('').reversed.join('');
}

NumberValue? revertFormattedCalculation(String input) {
  if (input.startsWith('=')) {
    return null;
  }

  bool isNegative = input.startsWith('-');
  if (isNegative) {
    input = input.substring(1);
  }

  RegExp currencyRegex = RegExp(r'^(\$|£|€|¥)|(\$|£|€|¥)$');
  String? currency;
  bool isPercentage = false;

  if (input.contains(currencyRegex)) {
    Match? currencyMatch = currencyRegex.firstMatch(input);
    currency = currencyMatch?.group(1) ?? currencyMatch?.group(2);
    input = input.replaceAll(currencyRegex, '');
  } else if (input.endsWith('%')) {
    isPercentage = true;
    input = input.substring(0, input.length - 1);
  }

  input = input.replaceAll(' ', '');
  
  num value = num.tryParse(input.replaceAll(',', '.')) ?? 0;

  if (isNegative) {
    value = -value;
  }

  if (isPercentage) {
    value = value / 100;
  }

  return NumberValue(value, currency: currency, isPercentage: isPercentage);
}
