package com.follow.clash.service.modules

import android.app.Notification.FOREGROUND_SERVICE_IMMEDIATE
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.Service
import android.app.Service.STOP_FOREGROUND_REMOVE
import android.content.Intent
import android.content.pm.ServiceInfo.FOREGROUND_SERVICE_TYPE_SPECIAL_USE
import android.os.Build
import android.os.PowerManager
import androidx.core.app.NotificationCompat
import androidx.core.content.getSystemService
import com.follow.clash.common.Components
import com.follow.clash.common.GlobalState
import com.follow.clash.common.QuickAction
import com.follow.clash.common.quickIntent
import com.follow.clash.common.receiveBroadcastFlow
import com.follow.clash.common.startForeground
import com.follow.clash.common.toPendingIntent
import com.follow.clash.core.Core
import com.follow.clash.service.R
import com.follow.clash.service.ServiceConfig
import com.follow.clash.service.models.*
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.combine
import kotlinx.coroutines.flow.distinctUntilChanged
import kotlinx.coroutines.flow.filterNotNull
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.map
import kotlinx.coroutines.flow.onStart
import kotlinx.coroutines.launch

private data class NotificationDisplayData(
    val title: String,
    val contentText: String,
    val bigText: String?,
    val stopText: String,
    val showStopAction: Boolean,
    val isLive: Boolean,
    val shortCriticalText: String,
)

fun getMarqueeTitle(title: String, tick: Int, maxLength: Int = 16): String {
    val clean = title.trim()
    if (clean.length <= maxLength) return clean
    val spacer = "    "
    val loopText = clean + spacer
    val offset = (tick % loopText.length)
    val repeated = loopText + loopText
    return repeated.substring(offset, offset + maxLength)
}

internal class NotificationModule(
    private val service: Service,
    private val scope: CoroutineScope,
) : ServiceModule {
    private var tick = 0
    private var sessionTotalBytes = 0L

    override fun start() {
        val initialParams = ServiceConfig.notificationParams.value
        val initialTraffic = Core.getTrafficData(initialParams.onlyStatisticsProxy)
        val initialSpeed = initialTraffic?.fullSpeedText ?: "↓ 0 B/s  ↑ 0 B/s"
        val serverDisplay = CountryHelper.getDisplayServerText(initialParams.currentServerName)
        val userTitle = initialParams.title.ifEmpty { "LieVPN" }
        val content = "$initialSpeed · $serverDisplay"
        val big = """
            |👤 $userTitle
            |⚡ $initialSpeed
            |$serverDisplay
        """.trimMargin()

        update(
            NotificationDisplayData(
                title = userTitle,
                contentText = content,
                bigText = big,
                stopText = initialParams.stopText,
                showStopAction = initialParams.showStopAction,
                isLive = initialParams.liveNotification,
                shortCriticalText = userTitle.take(8),
            )
        )

        scope.launch {
            val screenFlow = service.receiveBroadcastFlow {
                addAction(Intent.ACTION_SCREEN_ON)
                addAction(Intent.ACTION_SCREEN_OFF)
            }.map { intent ->
                intent.action == Intent.ACTION_SCREEN_ON
            }.onStart {
                emit(isScreenOn())
            }

            combine(
                flow {
                    while (true) {
                        delay(1_000)
                        tick++
                        emit(tick)
                    }
                },
                ServiceConfig.notificationParams,
                screenFlow,
            ) { currentTick, params, screenOn ->
                if (!screenOn) return@combine null
                val traffic = Core.getTrafficData(params.onlyStatisticsProxy)
                if (traffic != null) {
                    sessionTotalBytes += traffic.up + traffic.down
                }
                val speedDisplay = traffic?.fullSpeedText ?: "↓ 0 B/s  ↑ 0 B/s"
                val usedTrafficText = sessionTotalBytes.formatBytes
                val userTitle = params.title.ifEmpty { "LieVPN" }
                val serverDisplay = CountryHelper.getDisplayServerText(params.currentServerName)

                // liveNotificationType:
                // 0: Username
                // 1: Data used
                // 2: Network speed (both)
                // 3: Download speed
                // 4: Upload speed
                // 5: Current server (country)
                // 6: Server ping
                // 7: Custom text
                val shortText = when (params.liveNotificationType) {
                    1 -> usedTrafficText.take(8)
                    2 -> traffic?.compactBothSpeedText ?: "↓0B ↑0B"
                    3 -> traffic?.downloadChipSpeedText ?: "↓0B"
                    4 -> traffic?.uploadChipSpeedText ?: "↑0B"
                    5 -> CountryHelper.getChipServerText(params.currentServerName)
                    6 -> CountryHelper.getChipPingText(params.currentServerName, params.currentServerPing)
                    7 -> params.liveNotificationCustomText.ifEmpty { "LieVPN" }.take(8)
                    else -> userTitle.take(8)
                }

                // In the notification shade: show all (user, speed, server)
                val content = "$speedDisplay · $serverDisplay"
                val big = """
                    |👤 $userTitle
                    |⚡ $speedDisplay
                    |$serverDisplay
                """.trimMargin()

                NotificationDisplayData(
                    title = userTitle,
                    contentText = content,
                    bigText = big,
                    stopText = params.stopText,
                    showStopAction = params.showStopAction,
                    isLive = params.liveNotification,
                    shortCriticalText = shortText,
                )
            }.filterNotNull()
                .distinctUntilChanged()
                .collect(::update)
        }
    }

    private fun isScreenOn() =
        service.getSystemService<PowerManager>()?.isInteractive ?: true

    private fun update(displayData: NotificationDisplayData) {
        val channelId = if (displayData.isLive) "lievpn_live_channel" else GlobalState.NOTIFICATION_CHANNEL
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val manager = service.getSystemService(NotificationManager::class.java)
            val channelName = if (displayData.isLive) "LieVPN Live" else "LieVPN Service"
            val importance = if (displayData.isLive) NotificationManager.IMPORTANCE_DEFAULT else NotificationManager.IMPORTANCE_LOW
            var channel = manager?.getNotificationChannel(channelId)
            if (channel == null) {
                channel = NotificationChannel(channelId, channelName, importance).apply {
                    description = if (displayData.isLive) "Live updates and traffic status" else "VPN service status"
                }
                manager?.createNotificationChannel(channel)
            }
        }

        val intent = Intent().setComponent(Components.mainActivity)
        val builder = NotificationCompat.Builder(service, channelId).apply {
            setSmallIcon(R.drawable.ic_service)
            setContentTitle(displayData.title)
            setContentText(displayData.contentText)
            if (displayData.bigText != null) {
                setStyle(NotificationCompat.BigTextStyle().bigText(displayData.bigText))
            }
            setContentIntent(intent.toPendingIntent)
            setOngoing(true)
            setOnlyAlertOnce(true)
            setShowWhen(true)
            setPriority(if (displayData.isLive) NotificationCompat.PRIORITY_DEFAULT else NotificationCompat.PRIORITY_LOW)
            setCategory(if (displayData.isLive) NotificationCompat.CATEGORY_STATUS else NotificationCompat.CATEGORY_SERVICE)
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
                foregroundServiceBehavior = FOREGROUND_SERVICE_IMMEDIATE
            }
            if (displayData.isLive) {
                extras.putBoolean("android.requestPromotedOngoing", true)
                extras.putCharSequence("android.shortCriticalText", displayData.shortCriticalText)
                try {
                    val method = javaClass.getMethod("setShortCriticalText", CharSequence::class.java)
                    method.invoke(this, displayData.shortCriticalText)
                } catch (_: Throwable) {}
            }
            if (displayData.showStopAction) {
                addAction(
                    0,
                    displayData.stopText,
                    QuickAction.STOP.quickIntent.toPendingIntent,
                )
            }
        }

        val notification = builder.build()
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) {
            service.startForeground(
                GlobalState.NOTIFICATION_ID,
                notification,
                FOREGROUND_SERVICE_TYPE_SPECIAL_USE,
            )
        } else {
            service.startForeground(GlobalState.NOTIFICATION_ID, notification)
        }
    }

    @Suppress("DEPRECATION")
    override fun stop() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            service.stopForeground(STOP_FOREGROUND_REMOVE)
        } else {
            service.stopForeground(true)
        }
    }
}
