package com.freshplanet.ane.AirFacebook.functions;

import android.content.Intent;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.facebook.share.model.ShareLinkContent;
import com.freshplanet.ane.AirFacebook.AirFacebookExtension;
import com.freshplanet.ane.AirFacebook.ShareDialogActivity;
import com.freshplanet.ane.AirFacebook.utils.FREConversionUtil;
import com.freshplanet.ane.AirFacebook.utils.FacebookObjectsConversionUtil;

public class ShareLinkDialogFunction implements FREFunction
{
	public FREObject call(FREContext context, FREObject[] args)
	{
		ShareLinkContent.Builder builder = new ShareLinkContent.Builder();
		FacebookObjectsConversionUtil.parseShareLinkContent(args[0], builder);
		ShareLinkContent content = builder.build();
		Boolean useShareApi = FREConversionUtil.toBoolean(args[1]);
		String callback = FREConversionUtil.toString(args[2]);

		AirFacebookExtension.log("ShareLinkDialogFunction content:" + content +
				" useShareApi:" + useShareApi + " callback:" + callback);

		// Start dialog activity
		Intent i = new Intent(context.getActivity().getApplicationContext(), ShareDialogActivity.class);
		i.putExtra(ShareDialogActivity.extraPrefix + ".callback", callback);
		i.putExtra(ShareDialogActivity.extraPrefix + ".content", content);
		i.putExtra(ShareDialogActivity.extraPrefix + ".useShareApi", useShareApi);
		context.getActivity().startActivity(i);

		return null;
		
	}
}