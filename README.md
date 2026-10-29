<div align="center">

<img src="https://raw.githubusercontent.com/lie2srvv/assets/main/lie.png" alt="LieVPN" width="104" style="border-radius: 50%;">

# LieVPN

**Быстрый, стильный и лёгкий VPN/прокси-клиент нового поколения для Android, Windows и Linux.**

[![Latest Release](https://img.shields.io/github/v/release/lie2srvv/LieVPN?style=for-the-badge&logo=github&color=10B981&labelColor=18181b)](https://github.com/lie2srvv/LieVPN/releases/latest)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20Windows%20%7C%20Linux-blue?style=for-the-badge&logo=linux&color=0ea5e9&labelColor=18181b)](https://github.com/lie2srvv/LieVPN/releases/latest)
[![License](https://img.shields.io/badge/License-GPL--3.0-green?style=for-the-badge&color=22c55e&labelColor=18181b)](LICENSE)
[![Telegram](https://img.shields.io/badge/Telegram-Канал-229ED9?style=for-the-badge&logo=telegram&logoColor=white&labelColor=18181b)](https://t.me/LieVPN)

<br/>

[📥 **Скачать последнюю версию**](https://github.com/lie2srvv/LieVPN/releases/latest) • [💬 **Поддержка / Чат**](https://t.me/lie2srvv) • [🌐 **Официальный сайт**](https://vpn.lie2srvv.com)

<br/>

</div>

---

## ⚡ О проекте

**LieVPN** — это кроссплатформенный клиент на базе ядра **ClashMeta (Mihomo)** и фреймворка **Flutter**. Проект создан с фокусом на максимальную скорость работы, полную конфиденциальность, интуитивный интерфейс в стиле Material You и простоту использования для каждого пользователя.

### 🌟 Ключевые возможности

- 🚀 **Современные протоколы**: поддержка VLESS (Reality), Trojan, ShadowTLS, Shadowsocks, Hysteria 2, TUIC и других передовых протоколов обхода блокировок.
- 🎨 **Material You Design**: адаптивный и аккуратный интерфейс, плавная динамика, поддержка темных и светлых тем, компактный режим для ПК.
- 💳 **Встроенный LiePay**: бесшовное управление и моментальное продление подписки внутри приложения без сложных настроек.
- 🛡️ **TUN-режим и системный прокси**: перенаправление всего системного трафика или только выбранных приложений (раздельное туннелирование).
- 🔄 **Автоматическое обновление**: встроенный механизм фоновой проверки и безопасного обновления напрямую с GitHub Releases.
- ⚙️ **Гибкая маршрутизация**: правила обхода (GeoIP, routing rules), встроенный анти-DNS-leak и тест задержки узлов в реальном времени.

---

## 📲 Скачать и установить

Выберите установочный файл под вашу операционную систему:

| Платформа | Формат файла | Ссылка на скачивание |
| :--- | :--- | :--- |
| **Android** | `APK` (Универсальный) | [LieVPN.apk](https://github.com/lie2srvv/LieVPN/releases/latest/download/LieVPN.apk) |
| **Android** (ARM64) | `APK` (arm64-v8a) | [LieVPN-android-arm64-v8a.apk](https://github.com/lie2srvv/LieVPN/releases/latest/download/LieVPN-1.1.9-android-arm64-v8a.apk) |
| **Windows** | `EXE` (Установщик) | [LieVPN.exe](https://github.com/lie2srvv/LieVPN/releases/latest/download/LieVPN.exe) |
| **Windows** | `ZIP` (Портативная версия) | [LieVPN-windows.zip](https://github.com/lie2srvv/LieVPN/releases/latest/download/LieVPN-1.1.9-windows-amd64.zip) |
| **Linux** | `AppImage` (x86_64) | [LieVPN.AppImage](https://github.com/lie2srvv/LieVPN/releases/latest/download/LieVPN.AppImage) |

> [!TIP]
> **Для Linux:** Не забудьте выдать права на исполнение:  
> `chmod +x LieVPN.AppImage && ./LieVPN.AppImage`

---

## 🛠️ Сборка из исходников

### Требования
- **Flutter** `3.24.x` или новее
- **Go** `1.22+` (для сборки ядра mihomo / ClashMeta)
- **Dart SDK** (поставляется вместе с Flutter)

### Инструкция по сборке

1. **Клонируйте репозиторий:**
   ```bash
   git clone --recursive https://github.com/lie2srvv/LieVPN.git
   cd LieVPN
   ```

2. **Установите зависимости:**
   ```bash
   flutter pub get
   ```

3. **Сборка под нужную платформу:**
   - **Android:**
     ```bash
     flutter build apk --split-per-abi --release
     ```
   - **Linux:**
     ```bash
     dart setup.dart linux --targets=appimage
     ```
   - **Windows:**
     ```powershell
     dart setup.dart windows
     ```

---

## 📜 Лицензия и благодарности

- Проект распространяется под свободной лицензией **[GPL-3.0 License](LICENSE)**.
- Разработано на основе наработок **FlClash** и мощного ядра **[Mihomo (Clash.Meta)](https://github.com/MetaCubeX/mihomo)**.

<br/>

<div align="center">
  <b>LieVPN</b> • Свободный и безопасный интернет в один клик.
</div>
