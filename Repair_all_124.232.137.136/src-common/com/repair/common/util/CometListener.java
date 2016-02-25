package com.repair.common.util;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import org.comet4j.core.CometContext;
import org.comet4j.core.CometEngine;

public class CometListener implements ServletContextListener{
	
	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		 CometContext cc = CometContext.getInstance();
	     CometEngine engine = cc.getEngine();
	     cc.registChannel("report");
	     engine.addConnectListener(new JoinListener());
	     engine.addDropListener(new LeftListener());
	}
}
