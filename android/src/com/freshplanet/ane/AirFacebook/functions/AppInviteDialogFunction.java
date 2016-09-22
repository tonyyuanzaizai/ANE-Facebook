package com.freshplanet.ane.AirFacebook.functions;

import android.content.Intent;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.facebook.share.model.AppInviteContent;
import com.freshplanet.ane.AirFacebook.AirFacebookExtension;
import com.freshplanet.ane.AirFacebook.AppInviteActivity;
import com.freshplanet.ane.AirFacebook.utils.FREConversionUtil;
import com.freshplanet.ane.AirFacebook.utils.FacebookObjectsConversionUtil;

public class AppInviteDialogFunction implements FREFunction
{
	public FREObject call(FREContext context, FREObject[] args)
	{
		AppInviteContent.Builder builder = new AppInviteContent.Builder();
		FacebookObjectsConversionUtil.parseAppInviteContent(args[0], builder);
		AppInviteContent content = builder.build();
		String callback = FREConversionUtil.toString(args[1]);

		AirFacebookExtension.log("AppInviteDialogFunction content:" + FacebookObjectsConversionUtil.toString(content) +
						" callback:" + callback);

		// Start dialog activity
		Intent i = new Intent(context.getActivity().getApplicationContext(), AppInviteActivity.class);
		i.putExtra(AppInviteActivity.extraPrefix + ".callback", callback);
		i.putExtra(AppInviteActivity.extraPrefix + ".content", content);
		context.getActivity().startActivity(i);

		return null;
		
	}
}