extension StringExtension on String {
  String capitalize() {
    return this.isEmpty ? this : (this[0].toUpperCase() + this.substring(1));
  }
}