package com.follow.clash

import android.app.Application
import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.os.Build
import com.follow.clash.common.GlobalState
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class FlClashApplication : Application() {
    override fun attachBaseContext(base: Context?) {
        super.attachBaseContext(base)
        GlobalState.init(this)
    }

    override fun onCreate() {
        super.onCreate()
        initNotificationChannels()
        GlobalState.launch(Dispatchers.Main.immediate) {
            ServiceState.runState.collect { state ->
                LieVpnToggleWidgetProvider.updateAllWidgets(this@FlClashApplication, state)
            }
        }
    }

    private fun initNotificationChannels() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val manager = getSystemService(NotificationManager::class.java) ?: return
            val serviceChannel = NotificationChannel(
                GlobalState.NOTIFICATION_CHANNEL,
                getString(com.follow.clash.common.R.string.service_channel_name),
                NotificationManager.IMPORTANCE_LOW,
            ).apply {
                description = "VPN Service background status"
            }
            val liveChannel = NotificationChannel(
                "lievpn_live_channel",
                "LieVPN Live",
                NotificationManager.IMPORTANCE_DEFAULT,
            ).apply {
                description = "Live updates and traffic status"
            }
            manager.createNotificationChannel(serviceChannel)
            manager.createNotificationChannel(liveChannel)
        }
    }
}
