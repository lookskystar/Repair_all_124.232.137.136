package com.repair.common.util;

import org.comet4j.core.CometConnection;
import org.comet4j.core.event.DropEvent;
import org.comet4j.core.listener.DropListener;

import com.repair.common.pojo.UsersPrivs;

public class LeftListener extends DropListener {

	public boolean handleEvent(DropEvent anEvent) {
		CometConnection conn = anEvent.getConn();
		if(conn.getRequest().getSession().getAttribute("session_user")!=null){
			UsersPrivs user = (UsersPrivs)conn.getRequest().getSession().getAttribute("session_user");
			if(user.getBzid()!=null){
				CometUtil.removeConnect(user.getBzid(),conn.getId());
			}
		}
		return true;
	}
}
