package com.follow.clash

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.os.Handler
import android.os.Looper
import android.view.View
import android.widget.RemoteViews
import kotlin.random.Random

class DinoGameWidgetProvider : AppWidgetProvider() {

    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray) {
        for (widgetId in appWidgetIds) {
            renderGameState(context, appWidgetManager, widgetId)
        }
    }

    override fun onReceive(context: Context, intent: Intent) {
        super.onReceive(context, intent)
        if (intent.action == ACTION_JUMP) {
            handleJump(context)
        }
    }

    companion object {
        const val ACTION_JUMP = "com.lie2srvv.vpn.DINO_JUMP"

        // In-memory game state
        private var score = 0
        private var isJumping = false
        private var runFrame = 0 // 0 or 1
        private var obstaclePos = 0 // 0: Far, 1: Mid, 2: Near (Danger)
        private var currentObstacleType = 0 // 0: RKN, 1: Yandex, 2: VK
        private val handler = Handler(Looper.getMainLooper())

        private fun handleJump(context: Context) {
            val appWidgetManager = AppWidgetManager.getInstance(context)
            val ids = appWidgetManager.getAppWidgetIds(ComponentName(context, DinoGameWidgetProvider::class.java))
            if (ids.isEmpty()) return

            if (!isJumping) {
                isJumping = true

                // Check collision if obstacle was in danger zone
                if (obstaclePos == 2) {
                    // Successfully cleared obstacle!
                    score += 10
                    // Advance obstacle to far again
                    obstaclePos = 0
                    currentObstacleType = Random.nextInt(3)
                } else {
                    // Just jumping / advancing
                    score += 1
                    obstaclePos = (obstaclePos + 1) % 3
                    if (obstaclePos == 0) {
                        currentObstacleType = Random.nextInt(3)
                    }
                }

                runFrame = 1 - runFrame
                for (id in ids) {
                    renderGameState(context, appWidgetManager, id)
                }

                // Fall down after 500ms
                handler.postDelayed({
                    isJumping = false
                    runFrame = 1 - runFrame
                    for (id in ids) {
                        renderGameState(context, appWidgetManager, id)
                    }
                }, 500)
            } else {
                // Already jumping, advance run frame & obstacle
                score += 1
                obstaclePos = (obstaclePos + 1) % 3
                if (obstaclePos == 0) {
                    currentObstacleType = Random.nextInt(3)
                }
                for (id in ids) {
                    renderGameState(context, appWidgetManager, id)
                }
            }
        }

        fun renderGameState(context: Context, appWidgetManager: AppWidgetManager, widgetId: Int) {
            val views = RemoteViews(context.packageName, R.layout.widget_dino_game)

            // Update score
            views.setTextViewText(R.id.dino_score_text, "СЧЁТ: $score")

            // Update character frame
            if (isJumping) {
                views.setImageViewResource(R.id.dino_character_img, R.drawable.lie_runner_jump)
                views.setViewVisibility(R.id.dino_jump_spacer, View.VISIBLE)
            } else {
                val runnerDrawable = if (runFrame == 0) R.drawable.lie_runner_1 else R.drawable.lie_runner_2
                views.setImageViewResource(R.id.dino_character_img, runnerDrawable)
                views.setViewVisibility(R.id.dino_jump_spacer, View.GONE)
            }

            // Obstacle drawable
            val obsDrawable = when (currentObstacleType) {
                0 -> R.drawable.obs_rkn
                1 -> R.drawable.obs_yandex
                else -> R.drawable.obs_vk
            }

            // Slot positions: 0 -> Far, 1 -> Mid, 2 -> Near
            views.setViewVisibility(R.id.dino_obstacle_slot_far, if (obstaclePos == 0) View.VISIBLE else View.GONE)
            views.setViewVisibility(R.id.dino_obstacle_slot_mid, if (obstaclePos == 1) View.VISIBLE else View.GONE)
            views.setViewVisibility(R.id.dino_obstacle_slot_near, if (obstaclePos == 2) View.VISIBLE else View.GONE)

            when (obstaclePos) {
                0 -> views.setImageViewResource(R.id.dino_obstacle_img_far, obsDrawable)
                1 -> views.setImageViewResource(R.id.dino_obstacle_img_mid, obsDrawable)
                2 -> views.setImageViewResource(R.id.dino_obstacle_img_near, obsDrawable)
            }

            // Click Intent to jump
            val jumpIntent = Intent(context, DinoGameWidgetProvider::class.java).apply {
                action = ACTION_JUMP
            }
            val pendingIntent = PendingIntent.getBroadcast(
                context,
                0,
                jumpIntent,
                PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
            )
            views.setOnClickPendingIntent(R.id.dino_widget_root, pendingIntent)
            views.setOnClickPendingIntent(R.id.dino_game_area, pendingIntent)

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
