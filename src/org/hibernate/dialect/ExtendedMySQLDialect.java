package org.hibernate.dialect;

import org.hibernate.Hibernate;
import org.hibernate.dialect.MySQLDialect;
import org.hibernate.dialect.function.SQLFunctionTemplate;

/**
 * Hibernate的HQL语句中并不支持date_add函数的使用
 * 所以使用下列方式来让hibernate支持date_add函数
 * 1:将这个类编译好的class文件放到hibernate.jar包中
 * 2:修改hibernate.cfg.xml中修为为
 * <property name="dialect">
		org.hibernate.dialect.ExtendedMySQLDialect
	</property>
 * @author Administrator
 *
 */
public class ExtendedMySQLDialect extends MySQLDialect {
	/*
	* 使用方式 date_add(now(), 1, WEEK) 
	* 使用方式 date_add(now(), 1, day)
	*/
	public ExtendedMySQLDialect() {
		super();
		registerFunction("date_add", new SQLFunctionTemplate(Hibernate.DATE,"date_add(?1, INTERVAL ?2 ?3)"));
	}
}
