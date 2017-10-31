package com.optic.action.base;

import javax.servlet.http.HttpServletRequest;

import com.optic.tools.CommonTools;

public class Transcode {

	public static String MyTranscodeUTF(String name) throws Exception{
		if(name.equals("") || name.equals("null")){
			
		}else{
			return new String(name.getBytes("iso-8859-1"),"UTF-8");
		}
		return "";
	}
	//自己定义编译函数
	public static String escape(String src) {  
        int i;  
        char j;  
        StringBuffer tmp = new StringBuffer();  
        tmp.ensureCapacity(src.length() * 6);  
        for (i = 0; i < src.length(); i++) {  
            j = src.charAt(i);  
            if (Character.isDigit(j) || Character.isLowerCase(j)  
                    || Character.isUpperCase(j))  
                tmp.append(j);  
            else if (j < 256) {  
                tmp.append("%");  
                if (j < 16)  
                    tmp.append("0");  
                tmp.append(Integer.toString(j, 16));  
            } else {  
                tmp.append("%u");  
                tmp.append(Integer.toString(j, 16));  
            }  
        }  
        return tmp.toString();  
    }  
	//自己定义的反编译函数
    public static String unescape(String src,HttpServletRequest request) { 
    	src = String.valueOf(src);
    	if(src.equals("null") || src.equals("")){
    		return "";
    	}else{
    		String cilentInfo = CommonTools.getCilentInfo_new(request);
    		if(cilentInfo.equals("andriodApp")){//新版本安卓无需转码
//    			try {
//					return Transcode.MyTranscodeUTF(src);
//				} catch (Exception e) {
//					// TODO Auto-generated catch block
//					e.printStackTrace();
//				}
				return src;
    		}
    		Integer inputStrLength = src.length();
    		StringBuffer tmp = new StringBuffer();  
            tmp.ensureCapacity(inputStrLength);  
            int lastPos = 0, pos = 0;  
            char ch;  
            while (lastPos < src.length()) {  
                pos = src.indexOf("%", lastPos);  
                if (pos == lastPos) {  
                    if (src.charAt(pos + 1) == 'u') {  
                        ch = (char) Integer.parseInt(src.substring(pos + 2, pos + 6), 16);  
                        tmp.append(ch);  
                        lastPos = pos + 6;  
                    } else {  
                        ch = (char) Integer.parseInt(src.substring(pos + 1, pos + 3), 16);  
                        tmp.append(ch);  
                        lastPos = pos + 3;  
                    }  
                } else {  
                    if (pos == -1) {  
                        tmp.append(src.substring(lastPos));  
                        lastPos = src.length();  
                    } else {  
                        tmp.append(src.substring(lastPos, pos));  
                        lastPos = pos;  
                    }  
                }  
            }  
            return tmp.toString();
    	}
    }  
    
    /**
     * Unicode转UTF-8的转化
     * @description
     * @author wm
     * @date 2016-7-15 上午09:38:39
     * @param src
     * @return
     */
    public static String decodeUnicode(String src){
    	char aChar;
        int len = src.length();
        StringBuffer outBuffer = new StringBuffer(len);
        for (int x = 0; x < len;) {
            aChar = src.charAt(x++);
            if (aChar == '\\') {
                aChar = src.charAt(x++);
                if (aChar == 'u') {
                    int value = 0;
                    for (int i = 0; i < 4; i++) {
                        aChar = src.charAt(x++);
                        switch (aChar) {
                        case '0':
                        case '1':
                        case '2':
                        case '3':
                        case '4':
                        case '5':
                        case '6':
                        case '7':
                        case '8':
                        case '9':
                            value = (value << 4) + aChar - '0';
                            break;
                        case 'a':
                        case 'b':
                        case 'c':
                        case 'd':
                        case 'e':
                        case 'f':
                            value = (value << 4) + 10 + aChar - 'a';
                            break;
                        case 'A':
                        case 'B':
                        case 'C':
                        case 'D':
                        case 'E':
                        case 'F':
                            value = (value << 4) + 10 + aChar - 'A';
                            break;
                        default:
                            throw new IllegalArgumentException(
                                    "Malformed   \\uxxxx   encoding.");
                        }

                    }
                    outBuffer.append((char) value);
                } else {
                    if (aChar == 't')
                        aChar = '\t';
                    else if (aChar == 'r')
                        aChar = '\r';
                    else if (aChar == 'n')
                        aChar = '\n';
                    else if (aChar == 'f')
                        aChar = '\f';
                    outBuffer.append(aChar);
                }
            } else
                outBuffer.append(aChar);
        }
        return outBuffer.toString();
    }
}
