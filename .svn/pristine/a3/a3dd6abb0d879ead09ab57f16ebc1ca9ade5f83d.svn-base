package com.optic.factory;

import java.io.File;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import com.optic.util.WebUrl;


public class DaoFactory {
	private Map<String , Object> daoMap = new HashMap<String , Object>(); 
    private static DaoFactory df;
    @SuppressWarnings("unchecked")
	private DaoFactory(String path)throws Exception
    {
    	Document doc =  new SAXReader().read(new File(WebUrl.DATA_URL_WEB_INFO + "/daoContext.xml"));
        
        Element root = doc.getRootElement();
        List el =  root.elements();
        for (Iterator it = el.iterator();it.hasNext() ; )
        {
            Element em = (Element)it.next();
            String id = em.attributeValue("id");
            String impl = em.attributeValue("class");
            Class implClazz = Class.forName(impl);
            Object obj = implClazz.newInstance();
            daoMap.put(id , obj);            
        }
    }

    public static DaoFactory instance(String path)throws Exception
    {
        if (df == null)
        {
            df = new DaoFactory(path); 
        }
        return df;
    }

    public Object getDao(String id)
    {
        return daoMap.get(id);
    }
}
