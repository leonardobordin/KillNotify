import 'package:intl/intl.dart';

String formatMinute(int minute) {
  final normalized = minute % (24 * 60);
  final hour = (normalized ~/ 60).toString().padLeft(2, '0');
  final value = (normalized % 60).toString().padLeft(2, '0');
  return '$hour:$value';
}

String formatLocalDateTime(int epochMillis, {required String localeName}) {
  final value = DateTime.fromMillisecondsSinceEpoch(epochMillis).toLocal();
  return DateFormat.yMd(localeName).add_jm().format(value);
}

String formatDay(int dayIndex, {required String localeName}) {
  if (dayIndex < 0 || dayIndex > 6) return '—';
  // Schedule day indexes are Monday=0 through Sunday=6.
  return DateFormat.E(localeName).format(DateTime(2024, 1, dayIndex + 1));
}
