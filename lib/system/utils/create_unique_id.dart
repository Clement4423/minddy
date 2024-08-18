int _counter = 0;

int createUniqueId() {
  int timestamp = DateTime.now().microsecondsSinceEpoch;
  int uniqueId = int.parse('$timestamp$_counter'.substring(2));
  _counter = (_counter + 1) % 1000;
  return uniqueId;
}