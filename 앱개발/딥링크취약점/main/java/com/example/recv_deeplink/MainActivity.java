package com.example.recv_deeplink;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import android.Manifest;
import android.app.AlertDialog;
import android.app.LocaleManager;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.location.Criteria;
import android.location.Location;
import android.location.LocationManager;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.provider.Settings;
import android.os.Handler;
import android.util.Log;
import android.view.View;
import android.webkit.JavascriptInterface;
import android.webkit.WebChromeClient;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import org.w3c.dom.Text;


public class MainActivity extends AppCompatActivity {

    static boolean isStringEmpty(String str) {
        return str == null || str.isEmpty();
    }


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        ActivityCompat.requestPermissions( MainActivity.this, new String[] {  Manifest.permission.ACCESS_FINE_LOCATION  },0 );

                Uri data = this.getIntent().getData();

                if ( data!=null )
                {
                    String uri = this.getIntent().getDataString(); // 인텐트로 받아온 URI 정보 저장
                    String actionUrl = data.getQueryParameter("Url"); // URI에서 특정 파라미터 값 가져오기

                    WebView myWebView = (WebView)findViewById(R.id.webview);
                    myWebView.setWebChromeClient(new WebChromeClient()); // 웹뷰에서 크롬 사용허용
                    myWebView.setWebViewClient(new WebViewClient()); // 새 창 열기없이 앱 내부에서 웹뷰 열기

                    myWebView.getSettings().setJavaScriptEnabled(true);
                    myWebView.addJavascriptInterface(new Object() { // 웹↔앱 인터페이스 정의

                        LocationManager locationManager = (LocationManager)getSystemService(LOCATION_SERVICE);
                        Criteria criteria = new Criteria();
                        String bestProvider = locationManager.getBestProvider(criteria, false);

                        int gpsCheck = ContextCompat.checkSelfPermission(getApplicationContext(), Manifest.permission.ACCESS_COARSE_LOCATION);
                        Location location = locationManager.getLastKnownLocation(LocationManager.GPS_PROVIDER);

                        @JavascriptInterface
                        public void getGPSLocation() {
                            myWebView.post(new Runnable() {
                                @Override
                                public void run() {
                                    String provider = location.getProvider();
                                    double longitude = location.getLongitude();
                                    double latitude = location.getLatitude();
                                    double altitude = location.getAltitude();

                                    myWebView.evaluateJavascript("javascript:send_gpsinfo(\"경도:"+(String.valueOf(longitude)+
                                                    "<br>위도:"+String.valueOf(latitude))+"\")"
                                            ,null);
                                }
                            });
                        }

                    }, "Android");

                    myWebView.loadUrl(actionUrl);

                }
        }
}