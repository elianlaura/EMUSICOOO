package com.example.emusicooo_app;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;

import android.os.AsyncTask;
import android.os.Bundle;
import android.app.Activity;
import android.content.Intent;
import android.util.Log;
import android.view.Menu;
import android.widget.TextView;
import org.ksoap2.SoapEnvelope;
import org.ksoap2.serialization.PropertyInfo;
import org.ksoap2.serialization.SoapObject;
import org.ksoap2.serialization.SoapPrimitive;
import org.ksoap2.serialization.SoapSerializationEnvelope;
import org.ksoap2.transport.HttpTransportSE;
import org.xmlpull.v1.XmlPullParserException;

import org.json.JSONObject;
import java.net.URL;
import java.net.URLConnection;


public class DisplayMessageActivity extends Activity {

	public final static String URL = "http://192.168.1.33:8080/EMUSICOOOWS/services/BuscarCancion2?wsdl";
	public static final String NAMESPACE = "http://WebService";
	public static final String SOAP_ACTION_PREFIX = "/";
	private static final String METHOD = "buscar2";
		
	private TextView textView;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_display_message);

		Log.d("EMUSICOOO", "ini" );
		
		System.out.println("Error");
		
		Intent intent = getIntent();
		String message = intent.getStringExtra(MainActivity.EXTRA_MESSAGE);
		
		textView = (TextView) findViewById(R.id.test);
		
		AsyncTaskRunner runner = new AsyncTaskRunner();
		runner.SetMessage(message);
		runner.execute();
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.display_message, menu);
		return true;
	}

	
	
	private class AsyncTaskRunner extends AsyncTask<String, String, String> {

		private String resp = "";
		private String message = "";
		
		public void SetMessage(String m){
			message = m;
		}

		@Override
		protected String doInBackground(String... params) {
			Log.d("EMUSICOOO", "empezando" );
			
			publishProgress("Por favor espere..."); // Calls onProgressUpdate()
			try {				
				SoapSerializationEnvelope envelope = new SoapSerializationEnvelope(
						SoapEnvelope.VER11);
				SoapObject request = new SoapObject(NAMESPACE, METHOD);
				request.addProperty("cadena", message);				
				
				envelope.bodyOut = request;
				HttpTransportSE transport = new HttpTransportSE(URL);
				try {
					Log.d("EMUSICOOO", "calling" );
					
					transport.call(NAMESPACE + SOAP_ACTION_PREFIX + METHOD, envelope);
					
					Log.d("EMUSICOOO", "called" );
				} catch (IOException e) {
					e.printStackTrace();
				} catch (XmlPullParserException e) {
					e.printStackTrace();
				}
				//bodyIn is the body object received with this envelope
				if (envelope.bodyIn != null) {
					Log.d("EMUSICOOO", "hay data" );
									
					SoapObject Table = (SoapObject) envelope.bodyIn;

					String[][] output = null;
					if (Table != null) {
						SoapObject row = (SoapObject) Table.getProperty(0);

						if (row != null) {
							int rCount = Table.getPropertyCount();
							int cCount = ((SoapObject) Table.getProperty(0))
									.getPropertyCount();
							output = new String[rCount][cCount];
							for (int i = 0; i < rCount; i++) {
								
								
								for (int j = 0; j < cCount; j++){
									output[i][j] = ((SoapObject) Table
											.getProperty(i)).getProperty(j)
											.toString();
								
									//resp += output[i][j] + " ";
								}
								resp += " - " + output[i][1] + " ";
								resp += "\n";
							}
						}
					}
										
					Log.d("EMUSICOOO", "data to soap" );					
				}
			} catch (Exception e) {
				e.printStackTrace();
				resp = e.getMessage();
			}
			return resp;
		}

		/**
		 * 
		 * @see android.os.AsyncTask#onPostExecute(java.lang.Object)
		 */
		@Override
		protected void onPostExecute(String result) {
			// execution of result of Long time consuming operation
			// In this example it is the return value from the web service
			textView.setText(result);
		}

		/**
		 * 
		 * @see android.os.AsyncTask#onPreExecute()
		 */
		@Override
		protected void onPreExecute() {
			// Things to be done before execution of long running operation. For
			// example showing ProgessDialog
		}

		/**
		 * 
		 * @see android.os.AsyncTask#onProgressUpdate(Progress[])
		 */
		@Override
		protected void onProgressUpdate(String... text) {
			textView.setText(text[0]);
			// Things to be done while execution of long running operation is in
			// progress. For example updating ProgessDialog
		}
	}
}
