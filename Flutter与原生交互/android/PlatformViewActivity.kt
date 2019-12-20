package tangwin.flutter_app_test

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import kotlinx.android.synthetic.main.android_full_screen_layout.*

/**
 * Created by Tang on 2019/12/20
 */
class PlatformViewActivity :AppCompatActivity(){
    companion object{
        val EXTRA_COUNTER = "counter"
    }

    private var counter: Int = 0
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.android_full_screen_layout)
        my_toolbar.title = "原生 Platform View"
        setSupportActionBar(my_toolbar)

        counter = intent.getIntExtra(EXTRA_COUNTER, 0)
        updateText()
        fab.setOnClickListener {
            counter++
            updateText()
        }

        button.setOnClickListener { returnToFlutterView() }
    }

    private fun updateText() {
        val value = "Button tapped " + counter + if (counter == 1) " time" else " times"
        button_tap.text = value
    }

    private fun returnToFlutterView() {
        val returnIntent = Intent()
        returnIntent.putExtra(EXTRA_COUNTER, counter)
        setResult(Activity.RESULT_OK, returnIntent)
        finish()
    }

    override fun onBackPressed() {
        returnToFlutterView()
    }
}