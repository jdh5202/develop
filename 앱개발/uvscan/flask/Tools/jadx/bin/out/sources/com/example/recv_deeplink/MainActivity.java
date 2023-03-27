package com.example.recv_deeplink;

import android.location.Criteria;
import android.location.Location;
import android.location.LocationManager;
import android.net.Uri;
import android.os.Bundle;
import android.webkit.JavascriptInterface;
import android.webkit.WebChromeClient;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;
/* loaded from: classes.dex */
public class MainActivity extends AppCompatActivity {
    static boolean isStringEmpty(String str) {
        return str == null || str.isEmpty();
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // androidx.fragment.app.FragmentActivity, androidx.activity.ComponentActivity, androidx.core.app.ComponentActivity, android.app.Activity
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        setContentView(R.layout.activity_main);
        ActivityCompat.requestPermissions(this, new String[]{"android.permission.ACCESS_FINE_LOCATION"}, 0);
        Uri data = getIntent().getData();
        if (data != null) {
            getIntent().getDataString();
            String queryParameter = data.getQueryParameter("Url");
            WebView webView = (WebView) findViewById(R.id.webview);
            webView.setWebChromeClient(new WebChromeClient());
            webView.setWebViewClient(new WebViewClient());
            webView.getSettings().setJavaScriptEnabled(true);
            webView.addJavascriptInterface(new AnonymousClass1(webView), "Android");
            webView.loadUrl(queryParameter);
        }
    }

    /* renamed from: com.example.recv_deeplink.MainActivity$1  reason: invalid class name */
    /* loaded from: classes.dex */
    class AnonymousClass1 {
        String bestProvider;
        Criteria criteria;
        int gpsCheck;
        Location location;
        LocationManager locationManager;
        final /* synthetic */ WebView val$myWebView;

        AnonymousClass1(WebView webView) {
            this.val$myWebView = webView;
            this.locationManager = (LocationManager) MainActivity.this.getSystemService("location");
            Criteria criteria = new Criteria();
            this.criteria = criteria;
            this.bestProvider = this.locationManager.getBestProvider(criteria, false);
            this.gpsCheck = ContextCompat.checkSelfPermission(MainActivity.this.getApplicationContext(), "android.permission.ACCESS_COARSE_LOCATION");
            this.location = this.locationManager.getLastKnownLocation("gps");
        }

        @JavascriptInterface
        public void getGPSLocation() {
            this.val$myWebView.post(new Runnable() { // from class: com.example.recv_deeplink.MainActivity.1.1
                @Override // java.lang.Runnable
                public void run() {
                    AnonymousClass1.this.location.getProvider();
                    double longitude = AnonymousClass1.this.location.getLongitude();
                    double latitude = AnonymousClass1.this.location.getLatitude();
                    AnonymousClass1.this.location.getAltitude();
                    WebView webView = AnonymousClass1.this.val$myWebView;
                    webView.evaluateJavascript("javascript:send_gpsinfo(\"경도:" + String.valueOf(longitude) + "<br>위도:" + String.valueOf(latitude) + "\")", null);
                }
            });
        }
    }
}
