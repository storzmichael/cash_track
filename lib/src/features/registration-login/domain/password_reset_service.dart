import 'package:cash_track/src/core/presentation/dialog_helper.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/features/settings/application/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class PasswordResetService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sendPasswordResetEmail(String email, BuildContext context) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Passwort-Reset-E-Mail wurde gesendet.')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Fehler beim Senden der E-Mail: $e')),
        );
      }
    }
  }
}

void showPasswordResetDialog(BuildContext context) {
  final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
  final emailController = TextEditingController();

  DialogHelper.showTextInputDialog(
    context: context,
    title: textFiles[languageProvider.language]![86], // Titel für Passwort zurücksetzen
    placeholder: textFiles[languageProvider.language]![22], // Platzhaltertext für E-Mail
    cancelButtonText: textFiles[languageProvider.language]![14], // Abbrechen-Button-Text
    confirmButtonText: textFiles[languageProvider.language]![87], // Bestätigen-Button-Text
    onConfirm: (inputValue) {
      final email = inputValue.trim();
      if (email.isNotEmpty) {
        PasswordResetService().sendPasswordResetEmail(email, context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(textFiles[languageProvider.language]![73])), // Fehlermeldung
        );
      }
    },
    controller: emailController, // TextController für das Textfeld
  );
}
