package com.greenrobot.affiliatestats;

import com.greenrobot.affiliatestats.R;

import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.widget.EditText;

public class Neverblue_Settings extends Dialog {
	public EditText emailText;
	public EditText passwordText;
	

	public Neverblue_Settings(Context context) {
		super(context);
		// TODO Auto-generated constructor stub
	}

	public Neverblue_Settings(Context context, int theme) {
		super(context, theme);
		// TODO Auto-generated constructor stub
	}

	public Neverblue_Settings(Context context, boolean cancelable,
			OnCancelListener cancelListener) {
		super(context, cancelable, cancelListener);
		// TODO Auto-generated constructor stub
	}

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.neverblue_settings);
		setCanceledOnTouchOutside(false);
		setTitle("Neverblue Settings");
		emailText = (EditText) this.findViewById(R.id.EmailText);
//		passwordText = (EditText) this.findViewById(R.id.PasswordText);
	}
}
