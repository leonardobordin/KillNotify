const portugueseWeekdays = ['Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb', 'Dom'];

String formatMinute(int minute) {
  final normalized = minute % (24 * 60);
  final hour = (normalized ~/ 60).toString().padLeft(2, '0');
  final value = (normalized % 60).toString().padLeft(2, '0');
  return '$hour:$value';
}

String formatLocalDateTime(int epochMillis) {
  final value = DateTime.fromMillisecondsSinceEpoch(epochMillis).toLocal();
  final date =
      '${value.day.toString().padLeft(2, '0')}/'
      '${value.month.toString().padLeft(2, '0')}/${value.year}';
  final time =
      '${value.hour.toString().padLeft(2, '0')}:'
      '${value.minute.toString().padLeft(2, '0')}';
  return '$date às $time';
}

String formatDay(int dayIndex) =>
    dayIndex >= 0 && dayIndex < portugueseWeekdays.length
    ? portugueseWeekdays[dayIndex]
    : 'Dia';
