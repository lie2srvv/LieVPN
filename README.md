<div align="center">

<img src="assets/images/icon.png" alt="LieNetwork" width="100">

# LieNetwork

**Скоростная сетевая инфраструктура и защищённые сетевые туннели для шифрования персонального трафика.**

[![Latest Release](https://img.shields.io/github/v/release/lie2srvv/LieNetwork?style=for-the-badge&logo=github&color=10B981&labelColor=18181b)](https://github.com/lie2srvv/LieNetwork/releases/latest)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20Windows%20%7C%20Linux-blue?style=for-the-badge&logo=linux&color=0ea5e9&labelColor=18181b)](https://github.com/lie2srvv/LieNetwork/releases/latest)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-orange?style=for-the-badge&labelColor=18181b)](LICENSE)
[![Telegram](https://img.shields.io/badge/Telegram-Канал-229ED9?style=for-the-badge&logo=telegram&logoColor=white&labelColor=18181b)](https://t.me/LieNetwork)

<br/>

[📥 **Скачать последнюю версию**](https://github.com/lie2srvv/LieNetwork/releases/latest) • [💬 **Поддержка**](mailto:work@lie2srvv.com) • [🌐 **Официальный сайт**](https://pay.lie2srvv.com)

---

</div>

## 📖 О проекте

**LieNetwork** — это современный кроссплатформенный клиент на базе ядра **ClashMeta (Mihomo)** и фреймворка **Flutter**. Проект создан для обеспечения конфиденциальности и сквозного шифрования интернет-соединений по современному стандарту **TLS 1.3**. 

Интуитивный адаптивный интерфейс в стиле **Material You**, нулевая задержка переключения сетей и оптимизированные маршруты обеспечивают максимальную стабильность передачи данных.

---

## ✨ Ключевые возможности

- 🛡 **Шифрование по стандарту TLS 1.3:** Защита данных в публичных сетях и Wi-Fi точках доступа.
- ⚡ **Высокоскоростные сетевые туннели:** Поддержка передовых протоколов маршрутизации VLESS и Hysteria2.
- 🎨 **Динамический дизайн Material You:** Автоматическая адаптация акцентных цветов под оформление системы (Android 12+, Linux, Windows).
- 🧩 **Управление маршрутизацией приложений:** Выборочное направление трафика программ через защищённый туннель или напрямую.
- 💳 **Интеграция с подпиской LieSub:** Автоматическая синхронизация профилей и прямое продление доступа через сервис LiePay.
- 📊 **Мониторинг соединения:** Индикаторы состояния сети, сетевой задержки и активных узлов.

---

## 📥 Загрузка и установка

Готовые сборки доступны на странице [Releases](https://github.com/lie2srvv/LieNetwork/releases/latest):

| Платформа | Формат | Ссылка на загрузку |
|---|---|---|
| **Android** | `APK` (Универсальный) | [LieNetwork.apk](https://github.com/lie2srvv/LieNetwork/releases/latest/download/LieNetwork.apk) |
| **Android** (ARM64) | `APK` (arm64-v8a) | [LieNetwork-android-arm64-v8a.apk](https://github.com/lie2srvv/LieNetwork/releases/latest/download/LieNetwork-android-arm64-v8a.apk) |
| **Windows** | `EXE` (Установщик) | [LieNetwork.exe](https://github.com/lie2srvv/LieNetwork/releases/latest/download/LieNetwork.exe) |
| **Windows** | `ZIP` (Портативная версия) | [LieNetwork-windows.zip](https://github.com/lie2srvv/LieNetwork/releases/latest/download/LieNetwork-windows-amd64.zip) |
| **Linux** | `AppImage` (x86_64) | [LieNetwork.AppImage](https://github.com/lie2srvv/LieNetwork/releases/latest/download/LieNetwork.AppImage) |

### Запуск на Linux (AppImage):
```bash
chmod +x LieNetwork.AppImage && ./LieNetwork.AppImage
```

---

## 🛠 Сборка из исходников

### Требования
- Flutter SDK `>=3.10.0 <4.0.0`
- Dart SDK
- Для Android: Android SDK & NDK
- Для Linux: `libgtk-3-dev`, `libayatana-appindicator3-dev`
- Для Windows: Visual Studio 2022 (C++ desktop development)

### Клонирование и подготовка
```bash
git clone --recursive https://github.com/lie2srvv/LieNetwork.git
cd LieNetwork
dart run setup.dart
flutter pub get
```

### Сборка приложения
```bash
# Android APK
flutter build apk --release

# Linux AppImage / Binary
flutter build linux --release

# Windows Executable
flutter build windows --release
```

---

## 📄 Лицензия

Проект распространяется под свободной лицензией **GNU General Public License v3.0**. Подробнее см. в файле [LICENSE](LICENSE).

---

<div align="center">
  <b>LieNetwork</b> • Защищённая и быстрая сеть для каждого устройства.
</div>
