DateTime? parceMovieDataFromString(String? rawData) {
  if (rawData == null || rawData.isEmpty) return null;
  return DateTime.tryParse(rawData);
}
