package com.freshplanet.ane.AirFacebook.functions;

import java.util.ArrayList;
import java.util.List;

import android.content.Intent;
import com.adobe.fre.FREArray;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.freshplanet.ane.AirFacebook.AirFacebookExtension;
import com.freshplanet.ane.AirFacebook.LoginActivity;
import com.freshplanet.ane.AirFacebook.utils.FREConversionUtil;

public class LogInWithPermissionsFunction implements FREFunction
{
	public FREObject call(FREContext context, FREObject[] args)
	{
		ArrayList<String> permissions = FREConversionUtil.toStringArray(args[0]);
		String type = FREConversionUtil.toString(args[1]);

		AirFacebookExtension.log("LogInWithPermissionsFunction type:" + type + " permissions:" + permissions);

		Intent i = new Intent(context.getActivity().getApplicationContext(), LoginActivity.class);
		i.putStringArrayListExtra(LoginActivity.extraPrefix+".permissions", permissions);
		i.putExtra(LoginActivity.extraPrefix + ".type", type);
		context.getActivity().startActivity(i);
		
		return null;
	}

}