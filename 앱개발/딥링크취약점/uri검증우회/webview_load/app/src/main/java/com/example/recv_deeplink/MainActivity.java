package com.example.recv_deeplink;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import android.Manifest;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;


public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        ActivityCompat.requestPermissions( MainActivity.this, new String[] {  Manifest.permission.ACCESS_FINE_LOCATION  },0 );

            EditText edit = (EditText)findViewById(R.id.editText);
            Button button = (Button)findViewById(R.id.button);
            button.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    String url = edit.getText().toString();
                    Intent intent = new Intent(MainActivity.this, loadActivity.class);
                    intent.putExtra("gourl",url);
                    startActivity(intent);
                }
            });

        }
}