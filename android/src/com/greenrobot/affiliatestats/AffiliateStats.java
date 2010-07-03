package com.greenrobot.affiliatestats;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import com.greenrobot.affiliatestats.R;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.Dialog;
import android.app.ListActivity;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.DialogInterface.OnDismissListener;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.view.View.OnClickListener;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.AdapterView.OnItemClickListener;

public class AffiliateStats extends ListActivity implements OnDismissListener, OnClickListener {
	/** Called when the activity is first created. */
	
	// Set to true for console logging
	public static final boolean log = false;

	public static final String PREFS_NAME = "AffiliateStatsPreferences2";
	private static final int DIALOG_MAXBOUNTY_EARNINGS = 1;
	private static final int DIALOG_NEVERBLUE_EARNINGS = 2;
	private static final int DIALOG_CLICKBOOTH_EARNINGS = 3;
	private ArrayList<Account> m_accounts = null;
	private AccountAdapter m_adapter;
	private Account maxbounty_account;
	private Account neverblue_account;
	private Account clickbooth_account;
	private Account last_account;
	private Runnable earningsThread;
	private TextView toptext;

	private String earningsToday = "";
	private String earningsYesterday = "";
	private String earningsMonth = "";
	private String earningsTitle;

	private Button totalsButton;
	private ProgressDialog m_ProgressDialog = null;
	private String progress_message;

	private boolean fail = false;

	private Runnable returnRes = new Runnable() {

		@Override
		public void run() {
			m_ProgressDialog.dismiss();

			if (fail)
				connectFailed();
			else
				showEarnings();

		}
	};

	private Runnable setProgressMessage = new Runnable() {

		@Override
		public void run() {
			m_ProgressDialog.setMessage(progress_message);
		}
	};

	private void showEarnings() {
		if (log)
			Log.i(this.toString(), earningsTitle + "/" + earningsToday + "/" + earningsYesterday + "/" + earningsMonth);
		showDialog(0);
	}

	private void connectFailed() {

		AlertDialog alertDialog = new AlertDialog.Builder(this).create();
		alertDialog.setTitle("Error");
		alertDialog.setMessage("Could not log in to " + last_account.getProvider());
		alertDialog.setIcon(android.R.drawable.ic_dialog_alert);
		alertDialog.setButton("OK", new DialogInterface.OnClickListener() {
			public void onClick(DialogInterface dialog, int which) {
				return;
			}
		});

		alertDialog.show();

	}

	private void getEarnings(Account a) {
		if (log)
			Log.i(this.toString(), "Getting earnings for: " + a.getProvider());
		fail = false;
		if (a.getProvider() == "MaxBounty") {
			String key = Stats.MaxBounty_GetKey(maxbounty_account.getLogin(), maxbounty_account.getPassword());
			if (key.startsWith("error"))
				fail = true;
			else {
				earningsToday = Stats.MaxBounty_GetStats(key, "getTodayStats");
				earningsYesterday = Stats.MaxBounty_GetStats(key, "getYesterdayStats");
				earningsMonth = Stats.MaxBounty_GetStats(key, "getMonthToDateStats");
				earningsTitle = "MaxBounty earnings";
			}
		} else if (a.getProvider() == "Neverblue") {
			earningsToday = Stats.Neverblue_GetStats(neverblue_account.getLogin(), "today");
			earningsYesterday = Stats.Neverblue_GetStats(neverblue_account.getLogin(), "yesterday");
			earningsMonth = Stats.Neverblue_GetStats(neverblue_account.getLogin(), "this_month");
			earningsTitle = "Neverblue earnings";
		} else if (a.getProvider() == "Clickbooth") {
			earningsToday = Stats.Clickbooth_GetStats(clickbooth_account.getLogin(), clickbooth_account.getPassword(), "today");
			earningsYesterday = Stats.Clickbooth_GetStats(clickbooth_account.getLogin(), clickbooth_account.getPassword(), "yesterday");
			earningsMonth = Stats.Clickbooth_GetStats(clickbooth_account.getLogin(), clickbooth_account.getPassword(), "this_month");
			earningsTitle = "Clickbooth earnings";
		}

		if (earningsToday.startsWith("error"))
			fail = true;
		else if (earningsYesterday.startsWith("error"))
			fail = true;
		else if (earningsMonth.startsWith("error"))
			fail = true;
		runOnUiThread(returnRes);
	}

	private void getEarnings() {
		// Gets all combined earnings
		Account a;

		double today = 0.0;
		double yesterday = 0.0;
		double month = 0.0;

		earningsTitle = "Combined earnings";

		for (int i = 0; i < m_accounts.size(); i++) {
			a = m_accounts.get(i);
			last_account = a;
			progress_message = "Downloading data from " + a.getProvider() + "..";
			if (m_ProgressDialog != null)
				runOnUiThread(setProgressMessage);
			if (log)
				Log.i(this.toString(), "COMBINED|Getting earnings for: " + a.getProvider());
			fail = false;
			if (a.getProvider() == "MaxBounty") {
				String key = Stats.MaxBounty_GetKey(maxbounty_account.getLogin(), maxbounty_account.getPassword());
				if (key.startsWith("error"))
					fail = true;
				else {
					earningsToday = Stats.MaxBounty_GetStats(key, "getTodayStats");
					earningsYesterday = Stats.MaxBounty_GetStats(key, "getYesterdayStats");
					earningsMonth = Stats.MaxBounty_GetStats(key, "getMonthToDateStats");
				}
			} else if (a.getProvider() == "Neverblue") {
				earningsToday = Stats.Neverblue_GetStats(neverblue_account.getLogin(), "today");
				earningsYesterday = Stats.Neverblue_GetStats(neverblue_account.getLogin(), "yesterday");
				earningsMonth = Stats.Neverblue_GetStats(neverblue_account.getLogin(), "this_month");
			} else if (a.getProvider() == "Clickbooth") {
				earningsToday = Stats.Clickbooth_GetStats(clickbooth_account.getLogin(), clickbooth_account.getPassword(), "today");
				earningsYesterday = Stats.Clickbooth_GetStats(clickbooth_account.getLogin(), clickbooth_account.getPassword(), "yesterday");
				earningsMonth = Stats.Clickbooth_GetStats(clickbooth_account.getLogin(), clickbooth_account.getPassword(), "this_month");
			}

			if (earningsToday.startsWith("error"))
				fail = true;
			else if (earningsYesterday.startsWith("error"))
				fail = true;
			else if (earningsMonth.startsWith("error"))
				fail = true;

			if (fail)
				break;

			today = today + Double.parseDouble(earningsToday);
			yesterday = yesterday + Double.parseDouble(earningsYesterday);
			month = month + Double.parseDouble(earningsMonth);
		}

		earningsToday = String.valueOf(today);
		earningsYesterday = String.valueOf(yesterday);
		earningsMonth = String.valueOf(month);

		runOnUiThread(returnRes);
	}

	@Override
	protected Dialog onCreateDialog(int id) {
		EarningsDialog dialog = new EarningsDialog(this);
		dialog.setOnDismissListener(this);
		return dialog;
	}

	@Override
	protected void onPrepareDialog(int id, Dialog dialog) {
		EarningsDialog earnings = (EarningsDialog) dialog;
		earnings.setTitle(earningsTitle);
		earnings.today.setText("$" + earningsToday);
		earnings.yesterday.setText("$" + earningsYesterday);
		earnings.month.setText("$" + earningsMonth);

		if (!earningsToday.startsWith("0"))
			earnings.today.setTextColor(0xff83a928);
		if (!earningsYesterday.startsWith("0"))
			earnings.yesterday.setTextColor(0xff83a928);
		if (!earningsMonth.startsWith("0"))
			earnings.month.setTextColor(0xff83a928);
	}

	@Override
	public void onDismiss(DialogInterface dialog) {
		if (dialog instanceof MaxBounty_Settings) {
			// TODO: process settings changes here
		}
	}

	private static final int ACCOUNTS = 0;

	public boolean onCreateOptionsMenu(Menu menu) {
		menu.add(0, ACCOUNTS, 0, "Accounts").setIcon(android.R.drawable.ic_menu_preferences);
		return true;
	}

	public boolean onOptionsItemSelected(MenuItem item) {
		if (log)
			Log.i("menu clicked: ", item.toString());
		switch (item.getItemId()) {
		case ACCOUNTS:
			Intent i = new Intent(this, AccountsView.class);
			startActivityForResult(i, 1);
			return true;
			// case SETTINGS:
		}
		return false;
	}

	@Override
	protected void onListItemClick(ListView l, View v, int position, long id) {

		if (log)
			Log.i(this.toString(), "item clicked: " + m_accounts.get(position).getProvider());

		if (m_accounts.get(position).getProvider() == "MaxBounty") {
			last_account = m_accounts.get(position);
			earningsThread = new Runnable() {
				@Override
				public void run() {
					getEarnings(maxbounty_account);
				}
			};
		} else if (m_accounts.get(position).getProvider() == "Neverblue") {
			last_account = m_accounts.get(position);
			earningsThread = new Runnable() {
				@Override
				public void run() {
					getEarnings(neverblue_account);
				}
			};
		} else if (m_accounts.get(position).getProvider() == "Clickbooth") {
			last_account = m_accounts.get(position);
			earningsThread = new Runnable() {
				@Override
				public void run() {
					getEarnings(clickbooth_account);
				}
			};
		}

		Thread thread = new Thread(null, earningsThread, "MagentoBackground");
		thread.start();
		m_ProgressDialog = ProgressDialog.show(AffiliateStats.this, "Please wait..", "Downloading data from " + last_account.getProvider() + "..", true);

		super.onListItemClick(l, v, position, id);
	}

	public void onClick(View v) {

		earningsThread = new Runnable() {
			@Override
			public void run() {
				getEarnings();
			}
		};

		Thread thread = new Thread(null, earningsThread, "MagentoBackground");
		thread.start();
		m_ProgressDialog = ProgressDialog.show(AffiliateStats.this, "Please wait..", "Downloading data from " + m_accounts.get(0).getProvider() + "..", true);

	}

	private void refreshAccounts() {

		m_accounts.clear();
		m_adapter.clear();

		if (clickbooth_account.isVerified())
			m_accounts.add(clickbooth_account);
		if (maxbounty_account.isVerified())
			m_accounts.add(maxbounty_account);
		if (neverblue_account.isVerified())
			m_accounts.add(neverblue_account);

		if (m_accounts != null && m_accounts.size() > 0) {
			m_adapter.notifyDataSetChanged();
			for (int i = 0; i < m_accounts.size(); i++)
				m_adapter.add(m_accounts.get(i));
		}

		if (m_accounts.size() > 1) {
			totalsButton.setVisibility(View.VISIBLE);
		} else {
			totalsButton.setVisibility(View.GONE);
		}

		if (m_accounts.size() == 0) {
			toptext.setText("No affiliate accounts configured. Please open the 'Accounts' menu.");
			toptext.setVisibility(View.VISIBLE);
		}

		else {
			toptext.setText("You have " + m_accounts.size() + " accounts configured.");
			toptext.setVisibility(View.GONE);
		}

	}

	@Override
	public void onStart() {
		super.onStart();

		if (log)
			Log.i(this.toString(), "main window resumed");

		SharedPreferences settings = getSharedPreferences(PREFS_NAME, 0);

		Map prefs = settings.getAll();

		if (log)
			Log.i(this.toString(), "prefs: " + prefs.toString());

		refreshAccounts();

		if (log)
			Log.i(this.toString(), "onStart finished");

	}

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		if (log)
			Log.i(this.toString(), "Affiliate stats started.");

		setContentView(R.layout.main);

		m_accounts = new ArrayList<Account>();
		this.m_adapter = new AccountAdapter(this, R.layout.account_row, m_accounts);
		setListAdapter(this.m_adapter);

		m_accounts = new ArrayList<Account>();

		maxbounty_account = new Account(this, "MaxBounty");
		neverblue_account = new Account(this, "Neverblue");
		clickbooth_account = new Account(this, "Clickbooth");

		toptext = (TextView) findViewById(R.id.TopText);
		totalsButton = (Button) findViewById(R.id.TotalsButton);
		totalsButton.setOnClickListener(this);

		totalsButton.setVisibility(View.GONE);

	}

	private class AccountAdapter extends ArrayAdapter<Account> {

		private ArrayList<Account> items;

		public AccountAdapter(Context context, int textViewResourceId, ArrayList<Account> items) {
			super(context, textViewResourceId, items);
			this.items = items;
		}

		@Override
		public View getView(int position, View convertView, ViewGroup parent) {
			View v = convertView;
			if (v == null) {
				LayoutInflater vi = (LayoutInflater) getSystemService(Context.LAYOUT_INFLATER_SERVICE);
				v = vi.inflate(R.layout.account_row, null);
			}
			Account a = items.get(position);
			if (a != null) {
				TextView tt = (TextView) v.findViewById(R.id.toptext);
				TextView bt = (TextView) v.findViewById(R.id.bottomtext);
				ImageView img = (ImageView) v.findViewById(R.id.icon);
				tt.setText(a.getProvider());
				img.setVisibility(View.INVISIBLE);
				bt.setText(a.getLogin());

			}
			return v;
		}
	}

}