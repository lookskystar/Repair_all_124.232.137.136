package com.repair.admin.action;

import java.io.FileInputStream;
import java.io.InputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.Action;

public class DownloadAction implements Action {

	public String downloadInput() throws Exception {
		return "download";
	}

	private String inputPath;
	private HttpServletRequest req = ServletActionContext.getRequest();
	String filename = req.getParameter("filename");

	public String getInputPath() {
		return inputPath;
	}

	public void setInputPath(String value) {
		inputPath = value;
	}

	public InputStream getInputStream() throws Exception {
//		try {
//			filename = new String(filename.getBytes("iso-8859-1"), "UTF-8");
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
		// System.out.println(filename);
		inputPath = "/doc/" + filename;
		// System.out.println("------"
		// + ServletActionContext.getServletContext().getResourceAsStream(
		// inputPath));
		return ServletActionContext.getServletContext().getResourceAsStream(
				inputPath);
	}

	public String getFileName() throws Exception {
		String fileName = filename;
		try {
			fileName = new String(fileName.getBytes(), "ISO8859-1");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return fileName;
	}

	public String execute() throws Exception {
		return SUCCESS;
	}
}
