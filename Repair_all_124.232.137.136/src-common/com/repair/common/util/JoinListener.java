package com.repair.common.util;

import org.comet4j.core.CometConnection;
import org.comet4j.core.event.ConnectEvent;
import org.comet4j.core.listener.ConnectListener;

import com.repair.common.pojo.UsersPrivs;

public class JoinListener extends ConnectListener {

	public boolean handleEvent(ConnectEvent anEvent) {
		CometConnection conn = anEvent.getConn();
		if(conn.getRequest().getSession().getAttribute("session_user")!=null){
			UsersPrivs user = (UsersPrivs)conn.getRequest().getSession().getAttribute("session_user");
			if(user.getBzid()!=null){
				CometUtil.addConnect(user.getBzid(),conn.getId());
			}
		}
		return true;
	}
}
