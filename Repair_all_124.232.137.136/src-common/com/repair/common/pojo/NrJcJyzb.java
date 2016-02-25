package com.repair.common.pojo;

import java.io.Serializable;
import java.util.Map;

/**
 * 内燃机车交车检测项目主表
 * 
 * @author zx
 * 
 */
public class NrJcJyzb implements Serializable{
	private static final long serialVersionUID = 8330585832021033807L;
	// 内燃机车交车检测项目主ID
	private Integer jyzId;
	// 检修记录主表ID
	private Integer dpId;
	// 车型
	private String jclx;
	// 车号
	private String jch;
	// 修程修次
	private String xcxc;
	// 交车时间
	private String jcsj;
	// 实际启车时间
	private String sjqcsj;
	// 停时
	private String ts;
	// 压缩压力
	private Float ysyl1;
	// 压缩压力
	private Float ysyl2;
	// 压缩压力
	private Float ysyl3;
	// 压缩压力
	private Float ysyl4;
	// 压缩压力
	private Float ysyl5;
	// 压缩压力
	private Float ysyl6;
	// 压缩压力
	private Float ysyl7;
	// 压缩压力
	private Float ysyl8;
	// 压缩压力
	private Float ysyl9;
	// 压缩压力
	private Float ysyl10;
	// 压缩压力
	private Float ysyl11;
	// 压缩压力
	private Float ysyl12;
	// 压缩压力
	private Float ysyl13;
	// 压缩压力
	private Float ysyl14;
	// 压缩压力
	private Float ysyl15;
	// 压缩压力
	private Float ysyl16;
	// 滑油压力转速1
	private Float hyylzs1;
	// 滑油压力转速2
	private Float hyylzs2;
	// 滑油压力一室1
	private Float hyylys1;
	// 滑油压力一室2
	private Float hyylys2;
	// 滑油压力出口1
	private Float hyylck1;
	// 滑油压力出口2
	private Float hyylck2;
	// 滑油压力粗前1
	private Float hyylcq1;
	// 滑油压力粗前2
	private Float hyylcq2;
	// 滑油压力粗后1
	private Float hyylch1;
	// 滑油压力粗后2
	private Float hyylch2;
	// 滑油压力前增1
	private Float hyylqz1;
	// 滑油压力前增2
	private Float hyylqz2;
	// 滑油压力后增1
	private Float hyylhz1;
	// 滑油压力后增2
	private Float hyylhz2;
	// 滑油压力二室1
	private Float hyyles1;
	// 滑油压力二室2
	private Float hyyles2;
	// 燃油压力一室1
	private Float ryylys1;
	// 燃油压力一室2
	private Float ryylys2;
	// 燃油压力机械间1
	private Float ryyljxj1;
	// 燃油压力机械间2
	private Float ryyljxj2;
	// 燃油压力二室1
	private Float ryyles1;
	// 燃油压力二室2
	private Float ryyles2;
	// 对地绝缘励磁
	private Float ddjylc;
	// 对地绝缘主
	private Float ddjyz;
	// 对地绝缘控
	private Float ddjyk;
	// 对地绝缘照
	private Float ddjyzh;
	// 对地绝缘主对控
	private Float ddjyzdk;
	// 保护装置过压
	private String bhzzgy;
	// 保护装置差示
	private String bhzzcs;
	// 保护装置极限
	private String bhzzjx;
	// 保护装置固发
	private String bhzzgf;
	// 保护装置UDK
	private String bhzzudk;
	//工人(工长)
	private String fixEmp;
	//交车工长ID
	private UsersPrivs gzId;
	//质检ID
	private UsersPrivs zjId;
	//质检签认时间
	private String zjqrTime;
	//验收ID
	private UsersPrivs ysId;
	//验收签认时间
	private String ysqrTime;
	
	
	public UsersPrivs getGzId() {
		return gzId;
	}

	public void setGzId(UsersPrivs gzId) {
		this.gzId = gzId;
	}

	public UsersPrivs getZjId() {
		return zjId;
	}

	public void setZjId(UsersPrivs zjId) {
		this.zjId = zjId;
	}

	public UsersPrivs getYsId() {
		return ysId;
	}

	public void setYsId(UsersPrivs ysId) {
		this.ysId = ysId;
	}

	public NrJcJyzb() {
		
	}

	public Integer getJyzId() {
		return jyzId;
	}

	public void setJyzId(Integer jyzId) {
		this.jyzId = jyzId;
	}

	public Integer getDpId() {
		return dpId;
	}

	public void setDpId(Integer dpId) {
		this.dpId = dpId;
	}

	public String getJclx() {
		return jclx;
	}

	public void setJclx(String jclx) {
		this.jclx = jclx;
	}

	public String getJch() {
		return jch;
	}

	public void setJch(String jch) {
		this.jch = jch;
	}

	public String getXcxc() {
		return xcxc;
	}

	public void setXcxc(String xcxc) {
		this.xcxc = xcxc;
	}

	public String getJcsj() {
		return jcsj;
	}

	public void setJcsj(String jcsj) {
		this.jcsj = jcsj;
	}

	public String getSjqcsj() {
		return sjqcsj;
	}

	public void setSjqcsj(String sjqcsj) {
		this.sjqcsj = sjqcsj;
	}

	public String getTs() {
		return ts;
	}

	public void setTs(String ts) {
		this.ts = ts;
	}

	public Float getYsyl1() {
		return ysyl1;
	}

	public void setYsyl1(Float ysyl1) {
		this.ysyl1 = ysyl1;
	}

	public Float getYsyl2() {
		return ysyl2;
	}

	public void setYsyl2(Float ysyl2) {
		this.ysyl2 = ysyl2;
	}

	public Float getYsyl3() {
		return ysyl3;
	}

	public void setYsyl3(Float ysyl3) {
		this.ysyl3 = ysyl3;
	}

	public Float getYsyl4() {
		return ysyl4;
	}

	public void setYsyl4(Float ysyl4) {
		this.ysyl4 = ysyl4;
	}

	public Float getYsyl5() {
		return ysyl5;
	}

	public void setYsyl5(Float ysyl5) {
		this.ysyl5 = ysyl5;
	}

	public Float getYsyl6() {
		return ysyl6;
	}

	public void setYsyl6(Float ysyl6) {
		this.ysyl6 = ysyl6;
	}

	public Float getYsyl7() {
		return ysyl7;
	}

	public void setYsyl7(Float ysyl7) {
		this.ysyl7 = ysyl7;
	}

	public Float getYsyl8() {
		return ysyl8;
	}

	public void setYsyl8(Float ysyl8) {
		this.ysyl8 = ysyl8;
	}

	public Float getYsyl9() {
		return ysyl9;
	}

	public void setYsyl9(Float ysyl9) {
		this.ysyl9 = ysyl9;
	}

	public Float getYsyl10() {
		return ysyl10;
	}

	public void setYsyl10(Float ysyl10) {
		this.ysyl10 = ysyl10;
	}

	public Float getYsyl11() {
		return ysyl11;
	}

	public void setYsyl11(Float ysyl11) {
		this.ysyl11 = ysyl11;
	}

	public Float getYsyl12() {
		return ysyl12;
	}

	public void setYsyl12(Float ysyl12) {
		this.ysyl12 = ysyl12;
	}

	public Float getYsyl13() {
		return ysyl13;
	}

	public void setYsyl13(Float ysyl13) {
		this.ysyl13 = ysyl13;
	}

	public Float getYsyl14() {
		return ysyl14;
	}

	public void setYsyl14(Float ysyl14) {
		this.ysyl14 = ysyl14;
	}

	public Float getYsyl15() {
		return ysyl15;
	}

	public void setYsyl15(Float ysyl15) {
		this.ysyl15 = ysyl15;
	}

	public Float getYsyl16() {
		return ysyl16;
	}

	public void setYsyl16(Float ysyl16) {
		this.ysyl16 = ysyl16;
	}

	public Float getHyylzs1() {
		return hyylzs1;
	}

	public void setHyylzs1(Float hyylzs1) {
		this.hyylzs1 = hyylzs1;
	}

	public Float getHyylzs2() {
		return hyylzs2;
	}

	public void setHyylzs2(Float hyylzs2) {
		this.hyylzs2 = hyylzs2;
	}

	public Float getHyylys1() {
		return hyylys1;
	}

	public void setHyylys1(Float hyylys1) {
		this.hyylys1 = hyylys1;
	}

	public Float getHyylys2() {
		return hyylys2;
	}

	public void setHyylys2(Float hyylys2) {
		this.hyylys2 = hyylys2;
	}

	public Float getHyylck1() {
		return hyylck1;
	}

	public void setHyylck1(Float hyylck1) {
		this.hyylck1 = hyylck1;
	}

	public Float getHyylck2() {
		return hyylck2;
	}

	public void setHyylck2(Float hyylck2) {
		this.hyylck2 = hyylck2;
	}

	public Float getHyylcq1() {
		return hyylcq1;
	}

	public void setHyylcq1(Float hyylcq1) {
		this.hyylcq1 = hyylcq1;
	}

	public Float getHyylcq2() {
		return hyylcq2;
	}

	public void setHyylcq2(Float hyylcq2) {
		this.hyylcq2 = hyylcq2;
	}

	public Float getHyylch1() {
		return hyylch1;
	}

	public void setHyylch1(Float hyylch1) {
		this.hyylch1 = hyylch1;
	}

	public Float getHyylch2() {
		return hyylch2;
	}

	public void setHyylch2(Float hyylch2) {
		this.hyylch2 = hyylch2;
	}

	public Float getHyylqz1() {
		return hyylqz1;
	}

	public void setHyylqz1(Float hyylqz1) {
		this.hyylqz1 = hyylqz1;
	}

	public Float getHyylqz2() {
		return hyylqz2;
	}

	public void setHyylqz2(Float hyylqz2) {
		this.hyylqz2 = hyylqz2;
	}

	public Float getHyylhz1() {
		return hyylhz1;
	}

	public void setHyylhz1(Float hyylhz1) {
		this.hyylhz1 = hyylhz1;
	}

	public Float getHyylhz2() {
		return hyylhz2;
	}

	public void setHyylhz2(Float hyylhz2) {
		this.hyylhz2 = hyylhz2;
	}

	public Float getHyyles1() {
		return hyyles1;
	}

	public void setHyyles1(Float hyyles1) {
		this.hyyles1 = hyyles1;
	}

	public Float getHyyles2() {
		return hyyles2;
	}

	public void setHyyles2(Float hyyles2) {
		this.hyyles2 = hyyles2;
	}

	public Float getRyylys1() {
		return ryylys1;
	}

	public void setRyylys1(Float ryylys1) {
		this.ryylys1 = ryylys1;
	}

	public Float getRyylys2() {
		return ryylys2;
	}

	public void setRyylys2(Float ryylys2) {
		this.ryylys2 = ryylys2;
	}

	public Float getRyyljxj1() {
		return ryyljxj1;
	}

	public void setRyyljxj1(Float ryyljxj1) {
		this.ryyljxj1 = ryyljxj1;
	}

	public Float getRyyljxj2() {
		return ryyljxj2;
	}

	public void setRyyljxj2(Float ryyljxj2) {
		this.ryyljxj2 = ryyljxj2;
	}

	public Float getRyyles1() {
		return ryyles1;
	}

	public void setRyyles1(Float ryyles1) {
		this.ryyles1 = ryyles1;
	}

	public Float getRyyles2() {
		return ryyles2;
	}

	public void setRyyles2(Float ryyles2) {
		this.ryyles2 = ryyles2;
	}

	public Float getDdjylc() {
		return ddjylc;
	}

	public void setDdjylc(Float ddjylc) {
		this.ddjylc = ddjylc;
	}

	public Float getDdjyz() {
		return ddjyz;
	}

	public void setDdjyz(Float ddjyz) {
		this.ddjyz = ddjyz;
	}

	public Float getDdjyk() {
		return ddjyk;
	}

	public void setDdjyk(Float ddjyk) {
		this.ddjyk = ddjyk;
	}

	public Float getDdjyzh() {
		return ddjyzh;
	}

	public void setDdjyzh(Float ddjyzh) {
		this.ddjyzh = ddjyzh;
	}

	public Float getDdjyzdk() {
		return ddjyzdk;
	}

	public void setDdjyzdk(Float ddjyzdk) {
		this.ddjyzdk = ddjyzdk;
	}


	public String getBhzzgy() {
		return bhzzgy;
	}

	public void setBhzzgy(String bhzzgy) {
		this.bhzzgy = bhzzgy;
	}

	public String getBhzzcs() {
		return bhzzcs;
	}

	public void setBhzzcs(String bhzzcs) {
		this.bhzzcs = bhzzcs;
	}

	public String getBhzzjx() {
		return bhzzjx;
	}

	public void setBhzzjx(String bhzzjx) {
		this.bhzzjx = bhzzjx;
	}

	public String getBhzzgf() {
		return bhzzgf;
	}

	public void setBhzzgf(String bhzzgf) {
		this.bhzzgf = bhzzgf;
	}

	public String getBhzzudk() {
		return bhzzudk;
	}

	public void setBhzzudk(String bhzzudk) {
		this.bhzzudk = bhzzudk;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((jyzId == null) ? 0 : jyzId.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		NrJcJyzb other = (NrJcJyzb) obj;
		if (jyzId == null) {
			if (other.jyzId != null)
				return false;
		} else if (!jyzId.equals(other.jyzId))
			return false;
		return true;
	}

	public String getFixEmp() {
		return fixEmp;
	}

	public void setFixEmp(String fixEmp) {
		this.fixEmp = fixEmp;
	}

	public String getZjqrTime() {
		return zjqrTime;
	}

	public void setZjqrTime(String zjqrTime) {
		this.zjqrTime = zjqrTime;
	}

	public String getYsqrTime() {
		return ysqrTime;
	}

	public void setYsqrTime(String ysqrTime) {
		this.ysqrTime = ysqrTime;
	}
	
	

	
}
