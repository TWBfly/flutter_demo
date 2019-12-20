package tangwin.flutter_app_test

import android.app.Activity
import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {

    private lateinit var result: MethodChannel.Result
    private lateinit var mContext: MainActivity
    private val COUNT_REQUEST = 1
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        //创建与调用方标识符一样的方法通道
        //MethodChannel
//        MethodChannel(flutterEngine.dartExecutor, "tami").setMethodCallHandler { call, result ->
//            //判断方法名是否支持
//            if(call.method == "123456") {
//                Log.e("twb","flutter --> android")
//                result.success("flutter->Android,sucess")
//            }else{
//                result.notImplemented()
//            }
//        }

        //MethodChannel PlatformView 跳转页面
        MethodChannel(flutterEngine.dartExecutor, "PlatformView").setMethodCallHandler { call, result ->
            this.result = result
            //判断方法名是否支持
            if (call.method == "switchView") {
                val count = call.arguments as Int
                onLaunchFullScreen(count)
            } else {
                result.notImplemented()
            }
        }
    }

    //MethodChannel PlatformView 跳转页面
    private fun onLaunchFullScreen(count: Int) {
        val fullScreenIntent = Intent(this, PlatformViewActivity::class.java)
        fullScreenIntent.putExtra(PlatformViewActivity.EXTRA_COUNTER, count)
        startActivityForResult(fullScreenIntent, COUNT_REQUEST)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent) {
        if (requestCode == COUNT_REQUEST) {
            if (resultCode == Activity.RESULT_OK) {
                result.success(data.getIntExtra(PlatformViewActivity.EXTRA_COUNTER, 0))
            } else {
                result.error("ACTIVITY_FAILURE", "Failed while launching activity", null)
            }
        }
    }

//    override fun onCreate(savedInstanceState: Bundle?) {
//        super.onCreate(savedInstanceState)
//        val inflate = layoutInflater.inflate(R.layout.activity_test, null, false)
//        val btn = inflate.findViewById<Button>(R.id.btn)
//        btn.setOnClickListener {
//            Toast.makeText(mContext,"android view",Toast.LENGTH_LONG).show()
//        }
//        mContext = this
//        Log.e("twb", "flutterEngine==$flutterEngine")
//
//        if (flutterEngine!=null){
////            flutterEngine!!.platformViewsController.registry.registerViewFactory("sampleView",object : PlatformViewFactory(StandardMessageCodec.INSTANCE){
////                override fun create(p0: Context?, p1: Int, p2: Any?): PlatformView {
////                    return SimpleViewControl(mContext)
////                }
////            })
//            val shimPluginRegistry = ShimPluginRegistry(flutterEngine!!)
//            shimPluginRegistry.registrarFor("samples.flutter/native_views")
//                    .platformViewRegistry()
//                    .registerViewFactory("sampleView",object : PlatformViewFactory(StandardMessageCodec.INSTANCE){
//                        override fun create(p0: Context?, viewId: Int, p2: Any?): PlatformView {
////                            return SimpleViewControl(mContext)
//                            return SimpleViewControl(mContext,inflate)
//                        }
//
//                    })
//        }
//    }
}
//
//
////原生视图封装类
//internal class SimpleViewControl(context: Context, private val view: View) : PlatformView {
////    private val view: View = View(context)//缓存原生视图
////    init {
//        //        view.setBackgroundColor(Color.rgb(255, 0, 0))
////    }
//
//    //返回原生视图
//    override fun getView(): View {
//        return view
//    }
//
//    //原生视图销毁回调
//    override fun dispose() {}
//}
