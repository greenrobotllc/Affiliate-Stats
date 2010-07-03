package com.greenrobot.affiliatestats;

import java.util.ArrayList;

import com.greenrobot.affiliatestats.R;

import android.app.AlertDialog;
import android.app.Dialog;
import android.app.ListActivity;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.DialogInterface.OnDismissListener;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;

public class AccountsView extends ListActivity implements OnDismissListener {

	private ProgressDialog m_ProgressDialog = null;
	private ArrayList<Account> m_accounts = null;
	private AccountAdapter m_adapter;
	private Runnable verifyAccount;
	private Account maxbounty_account;
	private Account neverblue_account;
	private Account clickbooth_account;
	private Account last_account;

	private static final int DIALOG_MAXBOUNTY_SETTINGS = 1;
	private static final int DIALOG_NEVERBLUE_SETTINGS = 2;
	private static final int DIALOG_CLICKBOOTH_SETTINGS = 3;

	private Runnable returnRes = new Runnable() {

		@Override
		public void run() {
			m_ProgressDialog.dismiss();

			if (!last_account.isVerified())
				verificationFailed();

			m_adapter.notifyDataSetChanged();
		}
	};

	private void verificationFailed() {

		AlertDialog alertDialog = new AlertDialog.Builder(this).create();
		alertDialog.setTitle("Error");
		alertDialog.setMessage("Could not log in.");
		alertDialog.setIcon(android.R.drawable.ic_dialog_alert);
		alertDialog.setButton("OK", new DialogInterface.OnClickListener() {
			public void onClick(DialogInterface dialog, int which) {
				return;
			}
		});

		alertDialog.show();

	}

	private void verify(Account a) {
		if (AffiliateStats.log)
			Log.i(this.toString(), "Verifying an account..");
		if (a.getProvider() == "MaxBounty") {
			String result = Stats.MaxBounty_GetKey(maxbounty_account.getLogin(), maxbounty_account.getPassword());
			if (result.startsWith("error"))
				maxbounty_account.setVerified(false);
			else
				maxbounty_account.setVerified(true);
		} else if (a.getProvider() == "Neverblue") {
			String result = Stats.Neverblue_GetStats(neverblue_account.getLogin(), "today");
			if (result.startsWith("error"))
				neverblue_account.setVerified(false);
			else
				neverblue_account.setVerified(true);
		} else if (a.getProvider() == "Clickbooth") {
			String result = Stats.Clickbooth_GetStats(clickbooth_account.getLogin(), clickbooth_account.getPassword(), "today");
			if (result.startsWith("error"))
				clickbooth_account.setVerified(false);
			else
				clickbooth_account.setVerified(true);
		}

		runOnUiThread(returnRes);
	}

	/*
	 * Dialog stuff
	 */

	@Override
	protected Dialog onCreateDialog(int id) {
		switch (id) {
		case DIALOG_MAXBOUNTY_SETTINGS:
			MaxBounty_Settings mb_dialog = new MaxBounty_Settings(this);
			mb_dialog.setOnDismissListener(this);
			return mb_dialog;
		case DIALOG_NEVERBLUE_SETTINGS:
			Neverblue_Settings nb_dialog = new Neverblue_Settings(this);
			nb_dialog.setOnDismissListener(this);
			return nb_dialog;
		case DIALOG_CLICKBOOTH_SETTINGS:
			Clickbooth_Settings cb_dialog = new Clickbooth_Settings(this);
			cb_dialog.setOnDismissListener(this);
			return cb_dialog;
		default:
			return super.onCreateDialog(id);
		}
	}

	@Override
	protected void onPrepareDialog(int id, Dialog dialog) {
		switch (id) {
		case DIALOG_MAXBOUNTY_SETTINGS:
			MaxBounty_Settings mb = (MaxBounty_Settings) dialog;
			mb.emailText.setText(maxbounty_account.getLogin());
			mb.passwordText.setText(maxbounty_account.getPassword());
			break;
		case DIALOG_NEVERBLUE_SETTINGS:
			Neverblue_Settings nb = (Neverblue_Settings) dialog;
			nb.emailText.setText(neverblue_account.getLogin());
			break;
		case DIALOG_CLICKBOOTH_SETTINGS:
			Clickbooth_Settings cb = (Clickbooth_Settings) dialog;
			// cb.clientText.setText(clickbooth_account.getClient());
			cb.emailText.setText(clickbooth_account.getLogin());
			cb.passwordText.setText(clickbooth_account.getPassword());
			break;
		default:
			super.onPrepareDialog(id, dialog);
		}
	}

	@Override
	public void onDismiss(DialogInterface dialog) {
		if (dialog instanceof MaxBounty_Settings) {
			MaxBounty_Settings mb = (MaxBounty_Settings) dialog;
			String email = mb.emailText.getText().toString();
			String password = mb.passwordText.getText().toString();
			last_account = maxbounty_account;
			if (email.length() > 1 && password.length() > 1) {
				maxbounty_account.setLogin(email);
				maxbounty_account.setPassword(password);
				maxbounty_account.setVerified(false);

				verifyAccount = new Runnable() {
					@Override
					public void run() {
						verify(maxbounty_account);
					}
				};
				Thread thread = new Thread(null, verifyAccount, "MagentoBackground");
				thread.start();
				m_ProgressDialog = ProgressDialog.show(AccountsView.this, "Please wait..", "Verifying account..", true);
			}
			if (AffiliateStats.log)
				Log.i(this.toString(), "A maxbounty dialog was closed");
		} else if (dialog instanceof Neverblue_Settings) {
			Neverblue_Settings nb = (Neverblue_Settings) dialog;
			String apikey = nb.emailText.getText().toString();
			last_account = neverblue_account;
			if (apikey.length() > 5) {
				neverblue_account.setLogin(apikey);

				verifyAccount = new Runnable() {
					@Override
					public void run() {
						verify(neverblue_account);
					}
				};
				Thread thread = new Thread(null, verifyAccount, "MagentoBackground");
				thread.start();
				m_ProgressDialog = ProgressDialog.show(AccountsView.this, "Please wait..", "Verifying account..", true);
			}
			if (AffiliateStats.log)
				Log.i(this.toString(), "A neverblue dialog was closed");
		} else if (dialog instanceof Clickbooth_Settings) {
			Clickbooth_Settings cb = (Clickbooth_Settings) dialog;
			// String client = cb.clientText.getText().toString();
			String email = cb.emailText.getText().toString();
			String password = cb.passwordText.getText().toString();
			last_account = clickbooth_account;
			if (email.length() > 1 && password.length() > 1) {
				// clickbooth_account.setClient(client);
				clickbooth_account.setLogin(email);
				clickbooth_account.setPassword(password);
				clickbooth_account.setVerified(false);

				verifyAccount = new Runnable() {
					@Override
					public void run() {
						verify(clickbooth_account);
					}
				};
				Thread thread = new Thread(null, verifyAccount, "MagentoBackground");
				thread.start();
				m_ProgressDialog = ProgressDialog.show(AccountsView.this, "Please wait..", "Verifying account..", true);
			}
			if (AffiliateStats.log)
				Log.i(this.toString(), "A clickbooth dialog was closed");
		}
	}

	@Override
	protected void onListItemClick(ListView l, View v, int position, long id) {

		if (m_accounts.get(position).getProvider() == "MaxBounty")
			showDialog(DIALOG_MAXBOUNTY_SETTINGS);
		else if (m_accounts.get(position).getProvider() == "Neverblue")
			showDialog(DIALOG_NEVERBLUE_SETTINGS);
		else if (m_accounts.get(position).getProvider() == "Clickbooth")
			showDialog(DIALOG_CLICKBOOTH_SETTINGS);

		super.onListItemClick(l, v, position, id);
	}

	/*
	 * Main code
	 */

	@Override
	public void onStart() {
		super.onStart();

		if (AffiliateStats.log)
			Log.i(this.toString(), "onStart() called");

		m_adapter.notifyDataSetChanged();

	}

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.account_view);
		m_accounts = new ArrayList<Account>();
		this.m_adapter = new AccountAdapter(this, R.layout.account_row, m_accounts);
		setListAdapter(this.m_adapter);

		m_accounts = new ArrayList<Account>();

		maxbounty_account = new Account(this, "MaxBounty");
		neverblue_account = new Account(this, "Neverblue");
		clickbooth_account = new Account(this, "Clickbooth");

		m_accounts.add(clickbooth_account);
		m_accounts.add(maxbounty_account);
		m_accounts.add(neverblue_account);

		if (m_accounts != null && m_accounts.size() > 0) {
			m_adapter.notifyDataSetChanged();
			for (int i = 0; i < m_accounts.size(); i++)
				m_adapter.add(m_accounts.get(i));
		}

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
				if (a.isVerified()) {
					img.setImageState(new int[] { android.R.attr.state_checked }, true);
					bt.setText(a.getLogin());
				} else {
					img.setImageState(new int[] { android.R.attr.state_expanded }, true);
					bt.setText("Not configured.");
				}
			}
			return v;
		}
	}
}