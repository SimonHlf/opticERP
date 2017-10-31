package com.optic.web;

import java.io.StringReader;
import java.io.StringWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import com.blogspot.radialmind.html.HTMLParser;
import com.blogspot.radialmind.xss.XSSFilter;

/**
 * 防止xss攻击的自定义方法
 * @author wm
 * @createDate 2016-4-7
 */

public class NewXssHttpServletRequestWrapper extends HttpServletRequestWrapper{

	HttpServletRequest orgRequest = null;

	 public NewXssHttpServletRequestWrapper(HttpServletRequest request) {
		 super(request);
		 orgRequest = request;
	 }

	 /**
	 * 覆盖getParameter方法，将参数名和参数值都做xss过滤�?
	 * 如果�?��获得原始的�?，则通过super.getParameterValues(name)来获�?
	 * getParameterNames,getParameterValues和getParameterMap也可能需要覆�?
	 */
	 @Override
	 public String getParameter(String name) {
		 System.out.println("NewXssFilter处理前的 Value = " + super.getParameterValues(name));  
		 String value = super.getParameter(xssEncode(name));
		 if (value != null) {
			 value = xssEncode(value);
		 }
		 System.out.println("NewXssFilter处理后的 Value = " + value);  
		 return value;
	 }

	 /**
	 * 覆盖getHeader方法，将参数名和参数值都做xss过滤�?
	 * 如果�?��获得原始的�?，则通过super.getHeaders(name)来获�?
	 * getHeaderNames 也可能需要覆�?
	 */
	 @Override
	 public String getHeader(String name) {

		 String value = super.getHeader(xssEncode(name));
		 if (value != null) {
			 value = xssEncode(value);
		 }
		 return value;
	 }

	 /**
	 * 将容易引起xss漏洞的半角字符直接替换成全角字符
	 * 
	 * @param s
	 * @return
	 */
	 private static String xssEncode(String s) {
		 if (s == null || s.isEmpty()) {
			 return s;
		 }
		 StringReader reader = new StringReader(s);
		 StringWriter writer = new StringWriter();
		 try {
			 HTMLParser.process(reader, writer, new XSSFilter(), true);
			 String result = writer.toString();
			 return result;
		 } catch (NullPointerException e) {
			 return s;
		 } catch (Exception ex) {
			 ex.printStackTrace();
		 }
		 return null;
	 }

	 /**
	 * 获取�?��始的request
	 * 
	 * @return
	 */
	 public HttpServletRequest getOrgRequest() {
		 return orgRequest;
	 }

	 /**
	 * 获取�?��始的request的静态方�?
	 * 
	 * @return
	 */
	 public static HttpServletRequest getOrgRequest(HttpServletRequest req) {
		 
		 if (req instanceof NewXssHttpServletRequestWrapper) {
			 return ((NewXssHttpServletRequestWrapper) req).getOrgRequest();
		 }
		 return req;
	 }

}
