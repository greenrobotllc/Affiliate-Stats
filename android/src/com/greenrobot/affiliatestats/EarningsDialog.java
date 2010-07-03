package com.greenrobot.affiliatestats;

import com.greenrobot.affiliatestats.R;

import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.widget.EditText;
import android.widget.TextView;

public class EarningsDialog extends Dialog {
	public TextView today;
	public TextView yesterday;
	public TextView month;
	

	public EarningsDialog(Context context) {
		super(context);
		// TODO Auto-generated constructor stub
	}

	public EarningsDialog(Context context, int theme) {
		super(context, theme);
		// TODO Auto-generated constructor stub
	}

	public EarningsDialog(Context context, boolean cancelable,
			OnCancelListener cancelListener) {
		super(context, cancelable, cancelListener);
		// TODO Auto-generated constructor stub
	}

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.earnings_dialog);
		setCanceledOnTouchOutside(true);
		setTitle("Earnings");
		today = (TextView) this.findViewById(R.id.todayText);
		yesterday = (TextView) this.findViewById(R.id.yesterdayText);
		month = (TextView) this.findViewById(R.id.monthText);
	}

}
