#!/usr/bin/env bash
# Instalar Flutter
git clone https://github.com/flutter/flutter.git
export PATH="$PATH:`pwd`/flutter/bin"
flutter doctor
# Construir la aplicación Flutter web
flutter build web
