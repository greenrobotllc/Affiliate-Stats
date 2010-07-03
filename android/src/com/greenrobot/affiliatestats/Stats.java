package com.greenrobot.affiliatestats;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Vector;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.ksoap2.SoapEnvelope;
import org.ksoap2.serialization.SoapObject;
import org.ksoap2.serialization.SoapSerializationEnvelope;
import org.ksoap2.transport.AndroidHttpTransport;

import android.util.Log;

public class Stats {

	public static void Test_Backend() {
		/*
		 * String key = MaxBounty_GetKey("andy.triboletti@gmail.com",
		 * "ZuphAwu2"); Log.i("Test_Backend()", "GetKey() result: '" + key +
		 * "'"); String tmp = MaxBounty_GetStats(key, "getTodayStats");
		 * Log.i("Test_Backend()", "MaxBounty_GetStats(getTodayStats) result: "
		 * + tmp); tmp = MaxBounty_GetStats(key, "getYesterdayStats");
		 * Log.i("Test_Backend()",
		 * "MaxBounty_GetStats(getYesterdayStats) result: " + tmp); tmp =
		 * MaxBounty_GetStats(key, "getMonthToDateStats");
		 * Log.i("Test_Backend()",
		 * "MaxBounty_GetStats(getMonthToDateStats) result: " + tmp);
		 * 
		 * String cb = Clickbooth_GetStats("integraclick","CD111404",
		 * "ZuphAwu2", "today"); Log.i("Test_Backend()",
		 * "Clickbooth_GetStats() result: " + cb);
		 * 
		 * cb = Clickbooth_GetStats("integraclick","CD111404", "ZuphAwu2",
		 * "yesterday"); Log.i("Test_Backend()",
		 * "Clickbooth_GetStats() result: " + cb);
		 * 
		 * cb = Clickbooth_GetStats("integraclick","CD111404", "ZuphAwu2",
		 * "this_month"); Log.i("Test_Backend()",
		 * "Clickbooth_GetStats() result: " + cb);
		 * 
		 * String nb = Neverblue_GetStats(
		 * "c853fb817910348b6ec4839eddbd3a9eb0e6864d", "today");
		 * Log.i("Test_Backend()", "Neverblue_GetStats(today) result: " + nb);
		 * 
		 * nb = Neverblue_GetStats("c853fb817910348b6ec4839eddbd3a9eb0e6864d",
		 * "yesterday"); Log.i("Test_Backend()",
		 * "Neverblue_GetStats(yesterday) result: " + nb);
		 */

	}

	public static String Neverblue_GetStats(String apikey, String date) {
		// today
		// yesterday
		// this_month

		try {
			//String neverblueConnect="https://api.neverblue.com/service/aff/v2/rest/?output_format=format_json&key=" + apikey
			//+ "&function_name=runReport&columns=payout&aggregators=subid&rel_date=" + date;
			String neverblueConnect="http://api.neverblue.com/service/aff/v2/rest/?output_format=format_json&key=" + apikey
			+ "&function_name=runReport&columns=payout&aggregators=subid&rel_date=" + date;
			JSONArray res = RestClient.connect(neverblueConnect);
			if (AffiliateStats.log)
				Log.i("Neverblue_GetStats()", "RestClient() call finished");
			if (res == null)
				return "error: API request failed";
			JSONObject tmp = null;
			
			tmp = res.getJSONObject(0);
			JSONArray nameArray = tmp.names();
			JSONArray valArray = tmp.toJSONArray(nameArray);
			if (AffiliateStats.log)
				Log.i("Neverblue_GetStats()", "number of elements: " + valArray.length());

			String earnings = "0.00";
			float totalEarnings =0;
			
			for (int i = 0; i < valArray.length(); i++) {
				if (nameArray.getString(i).equalsIgnoreCase("status")) {
					if (!valArray.getString(i).equalsIgnoreCase("success"))
						return "error: API request failed";
				}

				if (nameArray.getString(i).equalsIgnoreCase("responsedata")) {
					String data = valArray.getString(i);
					//split based on 
					//JSONArray newArray = new JSONArray(data);
					//String value = newArray.toString();
					//int theLength = newArray.length();
					
					String [] a = null;
					a = data.split("cell");
					for (String eachone : a) {
						String [] b = null;
						b = eachone.split("\",\"");
						
						int bLength = b.length;
						
						if(bLength > 1) {
							String [] c = null;
							c = b[1].split("\"]");
							//Log.i("eachone", c[0]);
							String earningsString = c[0];
							float f = Float.valueOf(earningsString.trim()).floatValue();
							totalEarnings += f;
						}

					}
					//Log.i("Neverblue_GetStats()","***** data: " + a.toString());
					/*
					 String re1 = ".*?";
					String re2 = "([+-]?\\d*\\.\\d+)(?![-+0-9\\.])";

					Pattern p = Pattern.compile(re1 + re2, Pattern.CASE_INSENSITIVE | Pattern.DOTALL);
					Matcher m = p.matcher(data);
					if (m.find()) {
						earnings2 = m.group(2);
						earnings3 = m.group(3);
						earnings = m.group(1);
					}
					*/
				}
				/*
				 * Log.i("Neverblue_GetStats()", "<jsonname" + i + ">\n" +
				 * nameArray.getString(i) + "\n</jsonname" + i + ">\n" +
				 * "<jsonvalue" + i + ">\n" + valArray.getString(i) +
				 * "\n</jsonvalue" + i + ">");
				 */
				Log.i("date", date);
				Log.i("neverblue stats", earnings);
			}

			if (AffiliateStats.log)
				Log.i("Neverblue_GetStats()", "JSON object: " + tmp.toString());

			
			 totalEarnings = (float) (Math.round(totalEarnings*100.0f)/100.0f);
			
			    
			return Float.toString(totalEarnings);
			
		} catch (JSONException e) {
			e.printStackTrace();
			Log.i("error", e.toString());
			return "error: Could not connect";
		}

	}

	public static String MaxBounty_GetKey(String user, String password) {
		String SOAP_ACTION = "getKey";
		String NAMESPACE = "https://www.maxbounty.com/";
		String URL = "https://www.maxbounty.com/api/api.cfc?wsdl";
		String METHOD_NAME = SOAP_ACTION;
		Object resultRequestSOAP = null;
		try {

			SoapObject request = new SoapObject(NAMESPACE, METHOD_NAME);

			request.addProperty("user", user);
			request.addProperty("password", password);

			SoapSerializationEnvelope envelope = new SoapSerializationEnvelope(SoapEnvelope.VER11);
			envelope.setOutputSoapObject(request);

			AndroidHttpTransport androidHttpTransport = new AndroidHttpTransport(URL);

			androidHttpTransport.call(SOAP_ACTION, envelope);
			resultRequestSOAP = envelope.getResponse();
			SoapObject resultsRequestSOAP = (SoapObject) envelope.bodyIn;

			String res = resultsRequestSOAP.getProperty(0).toString();
			if (res.length() <= 2)
				return "error: Incorrect credentials";
			else
				return res;

		} catch (Exception e) {
			if (AffiliateStats.log)
				Log.e("MaxBounty_GetKey()", e.toString());
			return "error: Could not connect";
		}
	}

	public static String MaxBounty_GetStats(String key, String method) {
		String SOAP_ACTION = method;
		String NAMESPACE = "https://www.maxbounty.com/";
		String URL = "https://www.maxbounty.com/api/api.cfc?wsdl";
		String METHOD_NAME = SOAP_ACTION;
		Object resultRequestSOAP = null;
		try {

			SoapObject request = new SoapObject(NAMESPACE, METHOD_NAME);

			request.addProperty("keyStr", key);
			request.addProperty("offerId", "0");

			SoapSerializationEnvelope envelope = new SoapSerializationEnvelope(SoapEnvelope.VER11);
			envelope.setOutputSoapObject(request);

			AndroidHttpTransport androidHttpTransport = new AndroidHttpTransport(URL);

			androidHttpTransport.call(SOAP_ACTION, envelope);

			resultRequestSOAP = envelope.getResponse();
			SoapObject resultsRequestSOAP = (SoapObject) envelope.bodyIn;

			Vector result = (Vector) resultsRequestSOAP.getProperty(0);

			int numberOfCampaigns = result.size();
			float totalEarnings = 0;

			for(int jj = 0; jj < numberOfCampaigns - 1; jj++ ) {
				SoapObject r = (SoapObject) result.get(jj);
				String earnings = null;
				int i;

				for (i = 0; i < r.getPropertyCount(); i++) {
					SoapObject o = (SoapObject) r.getProperty(i);
					// Log.i(this.toString(), "o: " + o.getProperty(0).toString());
					if (o.getProperty(0).toString().equalsIgnoreCase("EARNINGS"))
						earnings = o.getProperty(1).toString();
					}

					if (earnings == null) {
						return "error: Could not find earnings";
					}
					float thisEarning = Float.valueOf(earnings.substring(1).trim()).floatValue();
					
					totalEarnings += thisEarning;
					
			}
					
			 totalEarnings = (float) (Math.round(totalEarnings*100.0f)/100.0f);

	        
			return Float.toString(totalEarnings);

		} catch (Exception e) {
			Log.e("MaxBounty_GetStats()", e.toString());
			return "error: Could not connect";
		}
	}

	public static String Clickbooth_GetStats(String add_code, String password, String date) {
		String SOAP_ACTION = "https://publishers.clickbooth.com/api/soap_affiliate.php/dailyStatsInfo";
		String NAMESPACE = "https://publishers.clickbooth.com/";
		// String URL =
		// "http://publishers.clickbooth.com/api/soap_affiliate.php?wsdl";
		String URL = "https://publishers.clickbooth.com/api/soap_affiliate.php";
		String METHOD_NAME = "dailyStatsInfo";
		Object resultRequestSOAP = null;
		String client = "integraclick";
		try {

			SoapObject request = new SoapObject(NAMESPACE, METHOD_NAME);

			Calendar c = Calendar.getInstance();

			String start_date = null;
			if (date.equalsIgnoreCase("yesterday")) {
				SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
				c.add(Calendar.DATE, -1);
				start_date = dateformat.format(c.getTime());
			} else if (date.equalsIgnoreCase("this_month")) {
				SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-");
				start_date = dateformat.format(c.getTime()) + "01";
			}

			if (start_date == null)
				start_date = "";

			if (AffiliateStats.log)
				Log.i("Clickbooth_GetStats()", "start_date: " + start_date);

			request.addProperty("client", client);
			request.addProperty("add_code", add_code);
			request.addProperty("password", password);

			request.addProperty("start_date", start_date);
			request.addProperty("end_date", "");

			SoapSerializationEnvelope envelope = new SoapSerializationEnvelope(SoapEnvelope.VER11);

			envelope.setOutputSoapObject(request);

			AndroidHttpTransport androidHttpTransport = new AndroidHttpTransport(URL);

			androidHttpTransport.setXmlVersionTag("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");

			androidHttpTransport.call(SOAP_ACTION, envelope);

			resultRequestSOAP = envelope.getResponse();
			SoapObject resultsRequestSOAP = (SoapObject) envelope.bodyIn;

			if (AffiliateStats.log)
				Log.i("Clickbooth_GetStats()", "resultsRequestSOAP prop count: " + resultsRequestSOAP.getPropertyCount());

			String res = resultsRequestSOAP.getProperty(0).toString();

			String data = res.substring(res.indexOf(";commission"));

			String earnings = null;
			if (AffiliateStats.log)
				Log.i("Clickbooth_GetStats()", "data for re: " + data);

			String re1 = ".*?";
			String re2 = "([+-]?\\d*\\.\\d+)(?![-+0-9\\.])";

			Pattern p = Pattern.compile(re1 + re2, Pattern.CASE_INSENSITIVE | Pattern.DOTALL);
			Matcher m = p.matcher(data);
			if (m.find()) {
				earnings = m.group(1);
			}

			if (earnings == null)
				return "error: Could not find earnings";

			return earnings;

		} catch (Exception e) {
			e.printStackTrace();
			if (AffiliateStats.log)
				Log.e("Clickbooth_GetStats()", e.toString());
			if (e.toString().contains("Invalid"))
				return "error: Invalid credentials";
			return "error: Could not connect";
		}
	}

}
