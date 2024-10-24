import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Aktuell eingeloggter Benutzer
  User? get currentUser => _firebaseAuth.currentUser;

  // Methode zur Anmeldung mit E-Mail und Passwort
  Future<void> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      // Fehler bei der Anmeldung
    }
  }

  // Methode zum Erstellen eines neuen Benutzers
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      // Fehler bei der Benutzererstellung
    }
  }

  // Methode zum Abmelden
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      // Fehler bei der Abmeldung
    }
  }

  // Methode zum Löschen des Accounts
  Future<void> deleteAccount() async {
    try {
      if (currentUser != null) {
        await currentUser!.delete();
      } else {}
    } catch (e) {
      // Fehler beim Löschen des Accounts
    }
  }

  // Methode zum Überprüfen, ob ein Benutzer eingeloggt ist
  bool isUserLoggedIn() {
    return currentUser != null;
  }
}
