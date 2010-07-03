package com.greenrobot.affiliatestats;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URI;
import java.net.URISyntaxException;
import java.net.URL;
 
import org.apache.http.HttpEntity;
import org.apache.http.HttpHost;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
 
import android.util.Log;
 
public class RestClient {
 
    private static String convertStreamToString(InputStream is) {
        
        BufferedReader reader = new BufferedReader(new InputStreamReader(is));
        StringBuilder sb = new StringBuilder();
 
        String line = null;
        try {
            while ((line = reader.readLine()) != null) {
                sb.append(line + "\n");
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                is.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return sb.toString();
    }


    public static JSONArray connect(String url)
    {
    	
    	URI theUri;
        try {
			theUri = new URI(url);
		
    	//HttpHost host = new HttpHost(theUri.getHost(), 443, theUri.getScheme());
		HttpHost host = new HttpHost(theUri.getHost(), 80, theUri.getScheme());	
        HttpClient httpclient = new DefaultHttpClient();
 
        // Prepare a request object
        HttpGet httpget = new HttpGet(url); 
 
        // Execute the request
        HttpResponse response;

            //response = httpclient.execute(httpget);
            response = httpclient.execute(host, httpget);
            
            // Examine the response status
            if (AffiliateStats.log)
            Log.i("RestClient",response.getStatusLine().toString());
 
            // Get hold of the response entity
            HttpEntity entity = response.getEntity();
            // If the response does not enclose an entity, there is no need
            // to worry about connection release
 
            if (entity != null) {
 
                // A Simple JSON Response Read
                InputStream instream = entity.getContent();
                String result= convertStreamToString(instream);
                if (AffiliateStats.log)
                Log.i("RestClient",result);
                
                
 				if (AffiliateStats.log)
 				Log.i("RestClient","Converting result to JSONObject..");
                // A Simple JSONObject Creation
                JSONObject json=new JSONObject(result);
                if (AffiliateStats.log)
                Log.i("RestClient","<jsonobject>\n"+json.toString()+"\n</jsonobject>");
 
                // A Simple JSONObject Parsing
                
                JSONArray nameArray=json.names();
                JSONArray valArray=json.toJSONArray(nameArray);
                /*
                Log.i("RestClient","number of elements: " + valArray.length());
                for(int i=0;i<valArray.length();i++)
                {
                    Log.i("RestClient","<jsonname"+i+">\n"+nameArray.getString(i)+"\n</jsonname"+i+">\n"
                            +"<jsonvalue"+i+">\n"+valArray.getString(i)+"\n</jsonvalue"+i+">");
                }
 				*/
 				
 				/*
                json.put("sample key", "sample value");
                Log.i("RestClient","<jsonobject>\n"+json.toString()+"\n</jsonobject>");*/
 
                // Closing the input stream will trigger connection release
                instream.close();
                return valArray;
            }
 
 
        } catch (ClientProtocolException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (JSONException e) {
            e.printStackTrace();
            return (JSONArray)null;
        } catch (URISyntaxException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        return (JSONArray)null;
    }
 
}