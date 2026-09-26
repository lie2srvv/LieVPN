package com.follow.clash

import android.app.Application
import android.content.Context
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
        GlobalState.launch(Dispatchers.Main.immediate) {
            ServiceState.runState.collect { state ->
                LieVpnWidgetProvider.updateAllWidgets(this@FlClashApplication, state)
            }
        }
    }
}
