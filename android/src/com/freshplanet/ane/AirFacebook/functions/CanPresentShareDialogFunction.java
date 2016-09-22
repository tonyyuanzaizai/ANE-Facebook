package com.freshplanet.ane.AirFacebook.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.facebook.share.model.ShareLinkContent;
import com.facebook.share.widget.ShareDialog;
import com.freshplanet.ane.AirFacebook.utils.FREConversionUtil;

public class CanPresentShareDialogFunction implements FREFunction
{
	public FREObject call(FREContext context, FREObject[] args)
	{
		return FREConversionUtil.fromBoolean(ShareDialog.canShow(ShareLinkContent.class));
	}
}