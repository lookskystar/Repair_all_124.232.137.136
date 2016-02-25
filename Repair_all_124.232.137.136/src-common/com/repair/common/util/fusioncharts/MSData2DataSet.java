package com.repair.common.util.fusioncharts;

import java.io.Serializable;
import java.util.List;

public class MSData2DataSet implements Serializable {

	private static final long serialVersionUID = 4398179836566273878L;

	private String seriesName = "";

	private String color = "";

	private String plotBorderColor = "";

	private List<MSData2Data> data;

	public String getSeriesName() {
		return seriesName;
	}

	public void setSeriesName(String seriesName) {
		this.seriesName = seriesName;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public String getPlotBorderColor() {
		return plotBorderColor;
	}

	public void setPlotBorderColor(String plotBorderColor) {
		this.plotBorderColor = plotBorderColor;
	}

	public List<MSData2Data> getData() {
		return data;
	}

	public void setData(List<MSData2Data> data) {
		this.data = data;
	}

}
