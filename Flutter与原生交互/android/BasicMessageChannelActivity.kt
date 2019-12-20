package tangwin.flutter_app_test

import android.content.Intent
import android.os.Bundle
import android.util.Log
import androidx.appcompat.app.AppCompatActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.StringCodec
import kotlinx.android.synthetic.main.flutter_view_layout.*
import java.util.*

/**
 * Created by Tang on 2019/12/20
 */
class BasicMessageChannelActivity : AppCompatActivity() {
    private var flutterEngines: FlutterEngine? = null
    private lateinit var mContext: BasicMessageChannelActivity
    private var messageChannel: BasicMessageChannel<String>? = null
    private val CHANNEL = "BasicMessageChannel"
    private var counter: Int = 0

    private fun getArgsFromIntent(intent: Intent): Array<String>? {
        val args = ArrayList<String>()
        if (intent.getBooleanExtra("trace-startup", false)) {
            args.add("--trace-startup")
        }
        if (intent.getBooleanExtra("start-paused", false)) {
            args.add("--start-paused")
        }
        if (intent.getBooleanExtra("enable-dart-profiling", false)) {
            args.add("--enable-dart-profiling")
        }
        if (args.isNotEmpty()) {
            val argsArray = arrayOfNulls<String>(args.size)
            return args.toArray(argsArray)
        }
        return null
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        mContext = this
        val args = getArgsFromIntent(intent)
        if (flutterEngines == null) {
            flutterEngines = FlutterEngine(mContext, args)
            flutterEngines?.dartExecutor?.executeDartEntrypoint(DartExecutor.DartEntrypoint.createDefault())
        }
        setContentView(R.layout.flutter_view_layout)
        flutter_view.attachToFlutterEngine(flutterEngines!!)

        val actionBar = supportActionBar
        actionBar?.title ="原生的title"

        messageChannel = BasicMessageChannel(flutterEngines!!.dartExecutor, CHANNEL, StringCodec.INSTANCE)
        messageChannel?.setMessageHandler { s, reply ->
            Log.e("twb", "Flutter发送:$s")
            onFlutterIncrement()
            reply.reply("")
        }

        fab.setOnClickListener { sendAndroidIncrement() }
    }

    private fun sendAndroidIncrement() {
        messageChannel?.send("ping")
    }

    private fun onFlutterIncrement() {
        counter++
        val value = "Flutter button tapped " + counter + if (counter == 1) " time" else " times"
        button_tap.text = value
    }

    override fun onResume() {
        super.onResume()
        flutterEngines?.lifecycleChannel?.appIsResumed()
    }

    override fun onPause() {
        super.onPause()
        flutterEngines?.lifecycleChannel?.appIsInactive()
    }

    override fun onStop() {
        super.onStop()
        flutterEngines?.lifecycleChannel?.appIsPaused()
    }

    override fun onDestroy() {
        flutter_view.detachFromFlutterEngine()
        super.onDestroy()
    }
}