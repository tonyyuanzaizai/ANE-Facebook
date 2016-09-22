package com.freshplanet.ane.AirFacebook.functions;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.facebook.share.widget.GameRequestDialog;
import com.freshplanet.ane.AirFacebook.utils.FREConversionUtil;

public class CanPresentGameRequestDialogFunction implements FREFunction
{
	public FREObject call(FREContext context, FREObject[] args)
	{
		return FREConversionUtil.fromBoolean(GameRequestDialog.canShow());
	}
}