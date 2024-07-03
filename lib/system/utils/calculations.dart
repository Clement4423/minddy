import 'dart:math';

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
  double sumOfSquares = numbers.map((number) => (number - avg) * (number - avg)).reduce((a, b) => a + b);
  return sumOfSquares / numbers.length;
}

double standardDeviation(List<num> numbers) {
  return sqrt(variance(numbers));
}

List<num> quartiles(List<num> numbers) {
  numbers.sort();
  int n = numbers.length;
  num q1 = (n % 4 == 0) ? (numbers[n ~/ 4 - 1] + numbers[n ~/ 4]) / 2 : numbers[(n / 4).floor()];
  num q2 = median(numbers);
  num q3 = (n % 4 == 0) ? (numbers[3 * n ~/ 4 - 1] + numbers[3 * n ~/ 4]) / 2 : numbers[(3 * n / 4).floor()];
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
  int maxFrequency = frequency.values.reduce((current, next) => current > next ? current : next);
  return frequency.entries.firstWhere((element) => element.value == maxFrequency).key;
}