package com.example.recv_deeplink;

import androidx.appcompat.app.AppCompatActivity;

import android.app.AlertDialog;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.provider.Settings;
import android.util.Log;
import android.view.View;
import android.webkit.JavascriptInterface;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {

    static boolean isStringEmpty(String str) {
        return str == null || str.isEmpty();
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

                Uri data = this.getIntent().getData();

                if ( data!=null )
                {
                    String uri = this.getIntent().getDataString(); // 인텐트로 받아온 URI 정보 저장
                    String actionUrl = data.getQueryParameter("actionUrl"); // URI에서 특정 파라미터 값 가져오기

                    WebView myWebView = (WebView)findViewById(R.id.webview);
                    myWebView.setWebViewClient(new WebViewClient()); // 새 창 열기없이 웹뷰 내에서 열기
                    myWebView.loadUrl(actionUrl);
                }
        }

}
