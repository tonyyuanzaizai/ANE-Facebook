package com.freshplanet.ane.AirFacebook.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.facebook.share.widget.AppInviteDialog;
import com.freshplanet.ane.AirFacebook.utils.FREConversionUtil;

public class CanPresentAppInviteDialogFunction implements FREFunction
{
	public FREObject call(FREContext context, FREObject[] args)
	{
		return FREConversionUtil.fromBoolean(AppInviteDialog.canShow());
	}
}