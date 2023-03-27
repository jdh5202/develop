package com.example.recv_deeplink;

import androidx.appcompat.app.AppCompatActivity;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;
import android.webkit.WebChromeClient;
import android.webkit.WebView;
import android.webkit.WebViewClient;

import java.util.Arrays;


public class loadActivity extends AppCompatActivity {

    public boolean BlacklistDomain(String gourl)
    {
        final String Blockdomain[] = {"abc.com","attacker.com","untrust.co.kr"};
         Uri url = Uri.parse( gourl );
         String hostname = url.getHost();
         Log.d("myTag", hostname );

         for ( String domchk: Arrays.asList(Blockdomain))
         {
             if ( domchk.equals(hostname) )
             {
                 return false;
             }
         }
        return true;
    }


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_load);

        Intent intent=new Intent(this.getIntent());
        String gourl=intent.getStringExtra("gourl");

        if ( BlacklistDomain(gourl) ) {
            WebView myWebView = (WebView)findViewById(R.id.webview);
            myWebView.setWebChromeClient(new WebChromeClient()); // 웹뷰에서 크롬 사용허용
            myWebView.setWebViewClient(new WebViewClient()); // 새 창 열기없이 앱 내부에서 웹뷰 열기
            myWebView.loadUrl(Uri.parse(gourl).getHost());
        } else {
            AlertDialog.Builder builder = new AlertDialog.Builder(this);

            builder.setTitle("Block").setMessage(gourl+"\n허용되지 않은 도메인입니다.");
            builder.setPositiveButton("확인", new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    finish();
                }
            });
            AlertDialog alertDialog = builder.create();
            alertDialog.show();
        }
    }
}