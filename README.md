
# CashTrack

**CashTrack** ist eine benutzerfreundliche Kassensystem-App, speziell entwickelt für Vereinsveranstaltungen. Die App bietet eine einfache und effiziente Lösung zur Verwaltung von Bestellungen und Zahlungen und hilft dabei, das Kassenmanagement während Events übersichtlich und reibungslos zu gestalten.

## Features

- **Benutzerfreundliche Oberfläche**: Intuitiv und leicht zu bedienen, ideal für Vereinsmitglieder und Eventhelfer.
- **Firebase Authentication**: Sichere Authentifizierung und Verwaltung der Benutzerkonten, sodass nur berechtigte Personen Zugriff auf die App haben.
- **Eigene Events erstellen**: Benutzer können individuelle Events nach ihren Bedürfnissen anlegen.
- **Kategorien erstellen**: Es können verschiedene Kategorien für Produkte erstellt werden, um die Verwaltung zu erleichtern.
- **Eigene Produkte erstellen**: Benutzer haben die Möglichkeit, ihre eigenen Produkte hinzuzufügen.
- **Zugriff auf vergangene Events**: Es kann auf vergangene Events zugegriffen werden, um Verkaufsdaten einzusehen.
- **Gesamtübersicht**: Die App bietet eine Übersicht aller verkauften Produkte zu jedem Event.

## Genutzte Technologien

- **[firebase_auth](https://pub.dev/packages/firebase_auth)**: Ermöglicht die Authentifizierung der Benutzer über Firebase, mit Unterstützung für verschiedene Anmeldemethoden.
- **[provider](https://pub.dev/packages/provider)**: Ein effizientes State-Management-Tool, das die App reaktiv und konsistent hält.
- **[shimmer](https://pub.dev/packages/shimmer)**: Hinzufügen von ansprechenden Ladeanimationen, um eine professionelle Benutzeroberfläche zu gewährleisten.

## Installation

1. **Flutter installieren**: Stellen Sie sicher, dass [Flutter](https://flutter.dev) installiert ist.
2. **Firebase einrichten**: Verbinden Sie die App mit Ihrem Firebase-Projekt, um die Authentifizierung und andere Firebase-Dienste nutzen zu können.
3. **App starten**:
   ```bash
   flutter pub get
   flutter run
   ```

## Verwendung

1. **Anmelden**: Der Benutzer meldet sich mit seinen Anmeldedaten über Firebase Auth an.
2. **Kassieren**: Benutzer können Bestellungen verwalten, Zahlungen entgegennehmen und Verkaufsdaten in Echtzeit einsehen.

## Weitere Informationen

CashTrack ist ideal für Vereinsveranstaltungen und kleine Events, bei denen ein einfaches und effektives Kassensystem benötigt wird. Die App wird laufend erweitert und verbessert. Beiträge und Vorschläge sind herzlich willkommen!
