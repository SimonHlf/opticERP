package com.optic.web;


import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.hibernate.SessionFactory;

import com.optic.util.WebUrl;
import com.optic.factory.AppFactory;
import com.optic.factory.DaoFactory;
import com.optic.tools.HibernateUtil;

public class FactoryLoaderListener implements ServletContextListener{
	DaoFactory df = null;
	AppFactory af = null;
	SessionFactory sf = null;
    public void contextInitialized(ServletContextEvent sce)
    {
		try
		{
			sf = HibernateUtil.currentSession().getSessionFactory();
			System.out.println("Hibernate的SessionFactory已经被初始化... " + sf);	
		}
		catch (Exception e)
		{
			System.out.println("初始化SessionFactory工厂时出现异常" + e);
		}
		try
		{
			//daoContext.xml和appContext.xml的路径
			WebUrl.DATA_URL_WEB_INFO = sce.getServletContext().getRealPath("/WEB-INF/").replace("\\", "/");
			df = DaoFactory.instance(WebUrl.DATA_URL_WEB_INFO);
			af = AppFactory.instance(WebUrl.DATA_URL_WEB_INFO);
			System.out.println("DAO工厂已经被初始化... " + df);
			System.out.println("APP工厂已经被初始化... " + df);

		}
		catch (Exception e)
		{
			System.out.println("初始化DAO工厂时出现异常" + e);
			System.out.println("初始化APP工厂时出现异常" + e);
		}
    } 
    
    public void contextDestroyed(ServletContextEvent sce)
    {
		sf = null;
		df = null;
    }
}