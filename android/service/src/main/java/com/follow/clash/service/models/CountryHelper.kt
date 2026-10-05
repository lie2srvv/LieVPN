package com.follow.clash.service.models

object CountryHelper {
    data class CountryInfo(
        val flag: String,
        val code: String,
        val nameRu: String,
    ) {
        val flagAndCode: String get() = "$flag $code"
    }

    private val countryMap = listOf(
        // Europe datacenters
        CountryInfo("🇵🇱", "PL", "Польша") to listOf("PL", "POL", "POLAND", "ПОЛЬША", "WARSAW", "WARSZAWA"),
        CountryInfo("🇩🇪", "DE", "Германия") to listOf("DE", "DEU", "GERMANY", "DEUTSCHLAND", "ГЕРМАНИЯ", "FRANKFURT", "BERLIN"),
        CountryInfo("🇳🇱", "NL", "Нидерланды") to listOf("NL", "NLD", "NETHERLANDS", "HOLLAND", "НИДЕРЛАНДЫ", "AMSTERDAM"),
        CountryInfo("🇪🇪", "EE", "Эстония") to listOf("EE", "EST", "ESTONIA", "EESTI", "ЭСТОНИЯ", "TALLINN"),
        CountryInfo("🇫🇮", "FI", "Финляндия") to listOf("FI", "FL", "FIN", "FINLAND", "SUOMI", "ФИНЛЯНДИЯ", "HELSINKI"),
        CountryInfo("🇸🇪", "SE", "Швеция") to listOf("SE", "SWE", "SWEDEN", "SVERIGE", "ШВЕЦИЯ", "STOCKHOLM"),
        CountryInfo("🇫🇷", "FR", "Франция") to listOf("FR", "FRA", "FRANCE", "ФРАНЦИЯ", "PARIS"),
        CountryInfo("🇬🇧", "GB", "Великобритания") to listOf("GB", "UK", "GBR", "UNITED KINGDOM", "ENGLAND", "ВЕЛИКОБРИТАНИЯ", "LONDON"),
        CountryInfo("🇨🇭", "CH", "Швейцария") to listOf("CH", "CHE", "SWITZERLAND", "ШВЕЙЦАРИЯ", "ZURICH", "GENEVA"),
        CountryInfo("🇦🇹", "AT", "Австрия") to listOf("AT", "AUT", "AUSTRIA", "АВСТРИЯ", "VIENNA", "WIEN"),
        CountryInfo("🇨🇿", "CZ", "Чехия") to listOf("CZ", "CZE", "CZECH", "ЧЕХИЯ", "PRAGUE", "PRAHA"),
        CountryInfo("🇳🇴", "NO", "Норвегия") to listOf("NO", "NOR", "NORWAY", "НОРВЕГИЯ", "OSLO"),
        CountryInfo("🇩🇰", "DK", "Дания") to listOf("DK", "DNK", "DENMARK", "ДАНИЯ", "COPENHAGEN"),
        CountryInfo("🇪🇸", "ES", "Испания") to listOf("ES", "ESP", "SPAIN", "ИСПАНИЯ", "MADRID", "BARCELONA"),
        CountryInfo("🇮🇹", "IT", "Италия") to listOf("IT", "ITA", "ITALY", "ИТАЛИЯ", "ROME", "MILAN"),
        CountryInfo("🇱🇻", "LV", "Латвия") to listOf("LV", "LVA", "LATVIA", "ЛАТВИЯ", "RIGA"),
        CountryInfo("🇱🇹", "LT", "Литва") to listOf("LT", "LTU", "LITHUANIA", "ЛИТВА", "VILNIUS"),
        CountryInfo("🇮🇪", "IE", "Ирландия") to listOf("IE", "IRL", "IRELAND", "ИРЛАНДИЯ", "DUBLIN"),
        CountryInfo("🇮🇸", "IS", "Исландия") to listOf("IS", "ISL", "ICELAND", "ИСЛАНДИЯ", "REYKJAVIK"),
        CountryInfo("🇧🇪", "BE", "Бельгия") to listOf("BE", "BEL", "BELGIUM", "БЕЛЬГИЯ", "BRUSSELS"),
        CountryInfo("🇵🇹", "PT", "Португалия") to listOf("PT", "PRT", "PORTUGAL", "ПОРТУГАЛИЯ", "LISBON"),
        CountryInfo("🇷🇴", "RO", "Румыния") to listOf("RO", "ROU", "ROMANIA", "РУМЫНИЯ", "BUCHAREST"),
        CountryInfo("🇧🇬", "BG", "Болгария") to listOf("BG", "BGR", "BULGARIA", "БОЛГАРИЯ", "SOFIA"),
        CountryInfo("🇭🇺", "HU", "Венгрия") to listOf("HU", "HUN", "HUNGARY", "ВЕНГРИЯ", "BUDAPEST"),
        CountryInfo("🇸🇰", "SK", "Словакия") to listOf("SK", "SVK", "SLOVAKIA", "СЛОВАКИЯ", "BRATISLAVA"),
        CountryInfo("🇸🇮", "SI", "Словения") to listOf("SI", "SVN", "SLOVENIA", "СЛОВЕНИЯ", "LJUBLJANA"),
        CountryInfo("🇭🇷", "HR", "Хорватия") to listOf("HR", "HRV", "CROATIA", "ХОРВАТИЯ", "ZAGREB"),
        CountryInfo("🇬🇷", "GR", "Греция") to listOf("GR", "GRC", "GREECE", "ГРЕЦИЯ", "ATHENS"),
        CountryInfo("🇨🇾", "CY", "Кипр") to listOf("CY", "CYP", "CYPRUS", "КИПР"),
        CountryInfo("🇲🇩", "MD", "Молдова") to listOf("MD", "MDA", "MOLDOVA", "МОЛДОВА", "CHISINAU"),
        CountryInfo("🇺🇦", "UA", "Украина") to listOf("UA", "UKR", "UKRAINE", "УКРАИНА", "KYIV", "KIEV"),
        CountryInfo("🇹🇷", "TR", "Турция") to listOf("TR", "TUR", "TURKEY", "ТУРЦИЯ", "ISTANBUL"),
        CountryInfo("🇰🇿", "KZ", "Казахстан") to listOf("KZ", "KAZ", "KAZAKHSTAN", "КАЗАХСТАН", "ALMATY", "ASTANA"),
        CountryInfo("🇷🇺", "RU", "Россия") to listOf("RU", "RUS", "RUSSIA", "РОССИЯ", "MOSCOW"),
        CountryInfo("🇺🇸", "US", "США") to listOf("US", "USA", "UNITED STATES", "США", "AMERICA"),
        CountryInfo("🇨🇦", "CA", "Канада") to listOf("CA", "CAN", "CANADA", "КАНАДА"),
        CountryInfo("🇯🇵", "JP", "Япония") to listOf("JP", "JPN", "JAPAN", "ЯПОНИЯ", "TOKYO"),
        CountryInfo("🇰🇷", "KR", "Корея") to listOf("KR", "KOR", "KOREA", "КОРЕЯ", "SEOUL"),
        CountryInfo("🇸🇬", "SG", "Сингапур") to listOf("SG", "SGP", "SINGAPORE", "СИНГАПУР"),
        CountryInfo("🇭🇰", "HK", "Гонконг") to listOf("HK", "HKG", "HONG KONG", "ГОНКОНГ"),
        CountryInfo("🇦🇪", "AE", "ОАЭ") to listOf("AE", "ARE", "UAE", "ОАЭ", "DUBAI"),
        CountryInfo("🇮🇱", "IL", "Израиль") to listOf("IL", "ISR", "ISRAEL", "ИЗРАИЛЬ", "TEL AVIV"),
        CountryInfo("🇦🇺", "AU", "Австралия") to listOf("AU", "AUS", "AUSTRALIA", "АВСТРАЛИЯ", "SYDNEY"),
        CountryInfo("🇧🇷", "BR", "Бразилия") to listOf("BR", "BRA", "BRAZIL", "БРАЗИЛИЯ"),
        CountryInfo("🇮🇳", "IN", "Индия") to listOf("IN", "IND", "INDIA", "ИНДИЯ"),
    )

    fun resolveCountry(serverName: String): CountryInfo? {
        val trimmed = serverName.trim()
        if (trimmed.isEmpty()) return null

        var i = 0
        while (i < trimmed.length - 1) {
            val cp1 = trimmed.codePointAt(i)
            if (cp1 in 0x1F1E6..0x1F1FF) {
                val nextIdx = i + Character.charCount(cp1)
                if (nextIdx < trimmed.length) {
                    val cp2 = trimmed.codePointAt(nextIdx)
                    if (cp2 in 0x1F1E6..0x1F1FF) {
                        val flag = String(Character.toChars(cp1)) + String(Character.toChars(cp2))
                        val code = "${(cp1 - 0x1F1E6 + 'A'.code).toChar()}${(cp2 - 0x1F1E6 + 'A'.code).toChar()}"
                        val matched = countryMap.find { it.first.code.equals(code, ignoreCase = true) }?.first
                        return CountryInfo(flag, code, matched?.nameRu ?: code)
                    }
                }
            }
            i += Character.charCount(cp1)
        }

        val upper = trimmed.uppercase()
        for ((info, patterns) in countryMap) {
            for (p in patterns) {
                val regex = Regex("(^|[^A-ZА-ЯЁ0-9])$p([^A-ZА-ЯЁ0-9]|$)", RegexOption.IGNORE_CASE)
                if (regex.containsMatchIn(upper)) {
                    return info
                }
            }
        }

        return null
    }

    private fun isInvalidServer(serverName: String): Boolean {
        val trimmed = serverName.trim()
        return trimmed.isEmpty() ||
            trimmed.equals("DIRECT", ignoreCase = true) ||
            trimmed.equals("REJECT", ignoreCase = true) ||
            trimmed.equals("GLOBAL", ignoreCase = true) ||
            trimmed.equals("COMPATIBLE", ignoreCase = true) ||
            trimmed.equals("PASS", ignoreCase = true)
    }

    fun getChipServerText(serverName: String): String {
        val trimmed = serverName.trim()
        if (isInvalidServer(trimmed)) return "🏴‍☠️"
        val info = resolveCountry(trimmed)
        if (info != null) {
            return "${info.flag} ${info.code}"
        }
        return trimmed.take(8)
    }

    fun getChipPingText(serverName: String, ping: Int): String {
        val trimmed = serverName.trim()
        if (isInvalidServer(trimmed)) return "🏴‍☠️"
        val info = resolveCountry(trimmed)
        val prefix = info?.flag ?: "⚡"
        return if (ping > 0) "$prefix ${ping}ms" else "$prefix --"
    }

    fun getDisplayServerText(serverName: String): String {
        val trimmed = serverName.trim()
        if (isInvalidServer(trimmed)) return "🏴‍☠️"
        val info = resolveCountry(trimmed)
        if (info != null) {
            val extra = trimmed.replace(info.flag, "").trim()
            return if (extra.isNotEmpty() && !extra.equals(info.nameRu, ignoreCase = true) && !extra.equals(info.code, ignoreCase = true)) {
                "${info.flag} $extra"
            } else {
                "${info.flag} ${info.nameRu}"
            }
        }
        return trimmed
    }
}
