package com.freshplanet.ane.AirFacebook.utils;

import com.facebook.share.model.ShareOpenGraphAction;
import com.facebook.share.model.ShareOpenGraphObject;
import com.facebook.share.model.ShareOpenGraphValueContainer;
import com.freshplanet.ane.AirFacebook.AirFacebookExtension;

import java.util.ArrayList;
import java.util.List;

public class FacebookValueContainerBuilder {

    public static ShareOpenGraphAction toOpenGraphAction(ValueContainer valueContainer)
    {
        ShareOpenGraphAction.Builder builder = new ShareOpenGraphAction.Builder();
        addValuesToBuilder(valueContainer, builder);
        return builder.build();
    }

    private static <T extends ShareOpenGraphValueContainer.Builder> void addValuesToBuilder(ValueContainer vc, T builder) {
        List<String> keys = vc.keys;
        List<ConversionType> types = vc.types;
        List<Object> values = vc.values;

        for(int i = 0; i<keys.size(); i++){

            String key = keys.get(i);
            ConversionType conversionType = types.get(i);
//            AirFacebookExtension.log("addValuesToBuilder key:" + key + " conversionType:" + conversionType);
            switch (conversionType){
                case STRING:
                    builder.putString(key, (String)values.get(i));
                    break;
                case INT:
                    builder.putInt(key, (Integer) values.get(i));
                    break;
                case BOOL:
                    builder.putBoolean(key, (Boolean) values.get(i));
                    break;
                case DOUBLE:
                    builder.putDouble(key, (Double) values.get(i));
                    break;
                case LONG:
                    builder.putLong(key, (Long) values.get(i));
                    break;
                case STRING_ARRAY:
                    builder.putStringArrayList(key, (ArrayList<String>) values.get(i));
                    break;
                case INT_ARRAY:
                {
                    List<Integer> list = (List<Integer>)values.get(i);
                    int[] primitiveList = new int[list.size()];
                    for(int j = 0; j<list.size(); j++){
                        primitiveList[j] = list.get(j);
                    }
                    builder.putIntArray(key, primitiveList);
                }
                break;
                case BOOL_ARRAY:
                {
                    List<Boolean> list = (List<Boolean>) values.get(i);
                    boolean[] primitiveList = new boolean[list.size()];
                    for (int j = 0; j < list.size(); j++) {
                        primitiveList[j] = list.get(j);
                    }
                    builder.putBooleanArray(key, primitiveList);
                }
                break;
                case DOUBLE_ARRAY:
                {
                    List<Double> list = (List<Double>) values.get(i);
                    double[] primitiveList = new double[list.size()];
                    for (int j = 0; j < list.size(); j++) {
                        primitiveList[j] = list.get(j);
                    }
                    builder.putDoubleArray(key, primitiveList);
                }
                break;
                case LONG_ARRAY:
                {
                    List<Long> list = (List<Long>) values.get(i);
                    long[] primitiveList = new long[list.size()];
                    for (int j = 0; j < list.size(); j++) {
                        primitiveList[j] = list.get(j);
                    }
                    builder.putLongArray(key, primitiveList);
                }
                break;
                case OBJECT:
                {
                    ValueContainer valueContainer = (ValueContainer) values.get(i);
                    ShareOpenGraphObject.Builder objectBuilder = new ShareOpenGraphObject.Builder();
                    addValuesToBuilder(valueContainer, objectBuilder);
                    ShareOpenGraphObject object = objectBuilder.build();
                    builder.putObject(key, object);
                }
                break;
                case OBJECT_ARRAY:
                {
                    ArrayList<ShareOpenGraphObject> newList = new ArrayList<>();
                    List<ValueContainer> list = (List<ValueContainer>) values.get(i);
                    for (ValueContainer valueContainer : list) {
                        ShareOpenGraphObject.Builder objectBuilder = new ShareOpenGraphObject.Builder();
                        addValuesToBuilder(valueContainer, objectBuilder);
                        ShareOpenGraphObject object = objectBuilder.build();
                        newList.add(object);
                    }
                    builder.putObjectArrayList(key, newList);
                }
                break;
                default:
            }
        }
    }
}
