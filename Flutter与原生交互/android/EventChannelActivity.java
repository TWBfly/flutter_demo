package tangwin.flutter_app_test;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

/**
 * Created by Tang on 2019/12/20
 */
public class EventChannelActivity extends FlutterActivity {
    private static final String CHARGING_CHANNEL = "eventchannel";
    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        new EventChannel(flutterEngine.getDartExecutor(), CHARGING_CHANNEL).setStreamHandler(
                new EventChannel.StreamHandler() {
                    private BroadcastReceiver chargingStateChangeReceiver;
                    @Override
                    public void onListen(Object arguments, EventChannel.EventSink events) {
                        chargingStateChangeReceiver = createChargingStateChangeReceiver(events);
                        registerReceiver(
                                chargingStateChangeReceiver, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
                    }

                    @Override
                    public void onCancel(Object arguments) {
                        unregisterReceiver(chargingStateChangeReceiver);
                        chargingStateChangeReceiver = null;
                    }
                }
        );
    }

    private BroadcastReceiver createChargingStateChangeReceiver(final EventChannel.EventSink events) {
        return new BroadcastReceiver() {
            @Override
            public void onReceive(Context context, Intent intent) {
                int status = intent.getIntExtra(BatteryManager.EXTRA_STATUS, -1);

                if (status == BatteryManager.BATTERY_STATUS_UNKNOWN) {
                    events.error("UNAVAILABLE", "Charging status unavailable", null);
                } else {
                    boolean isCharging = status == BatteryManager.BATTERY_STATUS_CHARGING ||
                            status == BatteryManager.BATTERY_STATUS_FULL;
                    events.success(isCharging ? "charging" : "discharging");
                }
            }
        };
    }
}
