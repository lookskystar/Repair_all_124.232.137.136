package com.repair.common.util.fusioncharts;

import java.io.Serializable;
import java.util.List;

public class MSArea2DCategory implements Serializable {

	private static final long serialVersionUID = -6915929037278154102L;

	private List<MSArea2DCategoryData> category;

	public List<MSArea2DCategoryData> getCategory() {
		return category;
	}

	public void setCategory(List<MSArea2DCategoryData> category) {
		this.category = category;
	}

}
