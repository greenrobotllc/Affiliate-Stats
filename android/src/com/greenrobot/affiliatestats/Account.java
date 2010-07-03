package com.greenrobot.affiliatestats;

import android.app.Activity;
import android.content.SharedPreferences;
import android.util.Log;

public class Account {

	private String provider;
	SharedPreferences settings;

	public Account(Activity parent, String provider) {
		Log.i("Account", "account object initialized, provider: " + provider);
		this.provider = provider;
		this.settings = parent.getSharedPreferences(AffiliateStats.PREFS_NAME, 0);
	}

	public String getProvider() {
		return provider;
	}

	public void setProvider(String provider) {
		this.provider = provider;
	}

	public String getLogin() {
		return settings.getString(provider + ".login", "");
	}

	public void setLogin(String login) {
		SharedPreferences.Editor editor = settings.edit();
		editor.putString(provider + ".login", login);
		editor.commit();
	}
	
	public String getPassword() {
		return settings.getString(provider + ".password", "");
	}
	
	public String getClient() {
		return settings.getString(provider + ".client", "");
	}
	
	public void setClient(String client) {
		SharedPreferences.Editor editor = settings.edit();
		editor.putString(provider + ".client", client);
		editor.commit();
	}

	public void setPassword(String password) {
		SharedPreferences.Editor editor = settings.edit();
		editor.putString(provider + ".password", password);
		editor.commit();
	}
	
	public boolean isVerified() {
		return settings.getBoolean(provider + ".verified", false);
	}
	
	public void setVerified(boolean verified)
	{
		SharedPreferences.Editor editor = settings.edit();
		editor.putBoolean(provider + ".verified", verified);
		editor.commit();
	}
	
}