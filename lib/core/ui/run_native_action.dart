import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<T?> runNativeAction<T>(
  BuildContext context,
  Future<T> Function() action,
) async {
  try {
    return await action();
  } on PlatformException catch (error) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'A operação não foi concluída.'),
        ),
      );
    }
  } catch (_) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('A operação não foi concluída.')),
      );
    }
  }
  return null;
}
