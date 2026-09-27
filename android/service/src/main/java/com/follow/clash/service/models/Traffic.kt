package com.follow.clash.service.models

import com.follow.clash.common.GlobalState
import com.follow.clash.core.Core
import com.google.gson.Gson

private val gson = Gson()

data class Traffic(
    val up: Long,
    val down: Long,
)

val Long.formatBytes: String
    get() {
        val units = arrayOf("B", "KB", "MB", "GB", "TB")
        var value = toDouble()
        var unit = 0
        while (value >= 1024 && unit < units.lastIndex) {
            value /= 1024
            unit++
        }
        return if (unit == 0) {
            "${value.toLong()}${units[unit]}"
        } else {
            "%.1f${units[unit]}".format(value)
        }
    }

val Long.formatCompact: String
    get() {
        val units = arrayOf("B", "K", "M", "G", "T")
        var value = toDouble()
        var unit = 0
        while (value >= 1024 && unit < units.lastIndex) {
            value /= 1024
            unit++
        }
        return if (unit == 0) {
            "${value.toLong()}${units[unit]}"
        } else if (value >= 10) {
            "${value.toInt()}${units[unit]}"
        } else {
            "%.1f${units[unit]}".format(value)
        }
    }

val Traffic.compactSpeedText: String
    get() {
        val upText = up.formatBytes
        val downText = down.formatBytes
        return when {
            up > 0 && down > 0 -> "↑$upText/s  ↓$downText/s"
            down > 0 -> "↓$downText/s"
            up > 0 -> "↑$upText/s"
            else -> "0 B/s"
        }
    }

val Traffic.shortChipSpeedText: String
    get() {
        val upShort = up.formatCompact
        val downShort = down.formatCompact
        return when {
            up > 0 && down > 0 -> "$upShort↑$downShort↓"
            down > 0 -> "$downShort↓"
            up > 0 -> "$upShort↑"
            else -> "0B"
        }
    }

val Traffic.singleDirectionChipSpeedText: String
    get() = when {
        down > 0 -> "↓${down.formatCompact}"
        up > 0 -> "↑${up.formatCompact}"
        else -> "↓0B"
    }

val Traffic.compactBothSpeedText: String
    get() = "↓${down.formatCompact} ↑${up.formatCompact}"

val Traffic.downloadChipSpeedText: String
    get() = "↓${down.formatCompact}"

val Traffic.uploadChipSpeedText: String
    get() = "↑${up.formatCompact}"

val Traffic.fullSpeedText: String
    get() = "↓ ${down.formatBytes}/s  ↑ ${up.formatBytes}/s"

val Traffic.speedText: String
    get() = "${up.formatBytes}/s↑  ${down.formatBytes}/s↓"

fun Core.getSpeedTrafficText(onlyStatisticsProxy: Boolean): String {
    return runCatching {
        gson.fromJson(getTraffic(onlyStatisticsProxy), Traffic::class.java).speedText
    }.onFailure { error ->
        GlobalState.log("Unable to read traffic: $error")
    }.getOrDefault("")
}

fun Core.getTrafficData(onlyStatisticsProxy: Boolean): Traffic? {
    return runCatching {
        gson.fromJson(getTraffic(onlyStatisticsProxy), Traffic::class.java)
    }.getOrNull()
}
