package com.freshplanet.ane.AirFacebook.functions;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.facebook.share.model.ShareContent;
import com.facebook.share.model.ShareLinkContent;
import com.facebook.share.model.ShareOpenGraphContent;
import com.facebook.share.widget.ShareDialog;
import com.freshplanet.ane.AirFacebook.AirFacebookExtension;
import com.freshplanet.ane.AirFacebook.ShareDialogActivity;
import com.freshplanet.ane.AirFacebook.utils.FREConversionUtil;
import com.freshplanet.ane.AirFacebook.utils.FacebookObjectsConversionUtil;

import java.util.List;

public class ShareOpenGraphFunction implements FREFunction
{
	public FREObject call(FREContext context, FREObject[] args)
	{
		ShareOpenGraphContent.Builder builder = new ShareOpenGraphContent.Builder();
		FacebookObjectsConversionUtil.parseShareOpenGraphContent(args[0], builder);
		ShareOpenGraphContent content = builder.build();
		Boolean useShareApi = FREConversionUtil.toBoolean(args[1]);
		String callback = FREConversionUtil.toString(args[2]);

		AirFacebookExtension.log("ShareOpenGraphFunction content:" + FacebookObjectsConversionUtil.toString(content) + " useShareApi:" + useShareApi
				+ " callback:" + callback);

		// Start dialog activity
		Intent i = new Intent(context.getActivity().getApplicationContext(), ShareDialogActivity.class);
		i.putExtra(ShareDialogActivity.extraPrefix + ".callback", callback);
		i.putExtra(ShareDialogActivity.extraPrefix + ".useShareApi", useShareApi);
		i.putExtra(ShareDialogActivity.extraPrefix + ".content", content);
		context.getActivity().startActivity(i);

		return null;
		
	}
}