extension CapitalizeExtension on String {
  /// Capitalizes the first letter of each word in a sentence.
  String capitalizeFirstText() {
    if (isEmpty) return this; // Return the original string if it's empty.

    // Split the string into words, capitalize each, and join them back.
    return split(' ')
        .map((word) => word.isNotEmpty
            ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
            : word)
        .join(' ');
  }
}
