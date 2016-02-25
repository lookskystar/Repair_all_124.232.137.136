package com.repair.jgxm.action;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.struts2.ServletActionContext;

import com.repair.common.pojo.DictJcType;
import com.repair.common.pojo.JgJgxm;
import com.repair.common.pojo.JgxmRunKiloRec;
import com.repair.common.pojo.JtRunKiloRec;
import com.repair.jgxm.service.DictJcTypeService;
import com.repair.jgxm.service.JtRunKiloRecService;
import com.repair.plan.action.BaseAction;

/**
 * 加装改造action层
 * @author 周云韬
 *
 */
public class JgxmAction extends BaseAction{
	
	private DictJcTypeService dictJcTypeService;
	private JtRunKiloRecService jtRunKiloRecService;
	
	/**列出机车类型*/
	public String listJcType(){
		List<DictJcType> list=dictJcTypeService.listDictJcType();

		request.put("jcTypeList", list);
		return "listJcType";
	}
	
	/**  统计加改机车 */
	public String statistical(){
		Integer jcTypeId=(Integer) request.get("jcTypeId");
		DictJcType jcType=dictJcTypeService.findById(jcTypeId);
		if(jcType == null){
			return "statistical";
		}
		Iterator<JgJgxm> it=jcType.getJgxmSet().iterator();
		
//		加改项目-->对应机车型号和加改次数
		Map<JgJgxm, Map<String, Integer>> statisticalMap=new HashMap<JgJgxm, Map<String, Integer>>();
		
		/**
		 * 遍历加改项目，并且统计出每个机型所对应的加改数量
		 */
		while (it.hasNext()) {
			JgJgxm jgxm=it.next();
			Iterator<JgxmRunKiloRec> runKiloRecIt=jgxm.getJgxmRunKiloRecSet().iterator();		
			
			Map<String, Integer> jcSTypeMap=new HashMap<String, Integer>();
			while (runKiloRecIt.hasNext()) {
				JgxmRunKiloRec rec=runKiloRecIt.next();
				
				String jcSType=rec.getJtRunKiloRec().getJcType();
				
				if(jcSTypeMap.get(jcSType) == null){
					jcSTypeMap.put(jcSType, 1);
				}else{
					jcSTypeMap.put(jcSType, jcSTypeMap.get(jcSType).intValue()+1);
				}
				
			}
			statisticalMap.put(jgxm, jcSTypeMap);
		}
		request.put("dictJcType", jcType);
		request.put("statisticalMap", statisticalMap);
		return "statistical";
	}
	
	/**  列出加改机车 */
	public String listJgJc(){
		return "";
		
	}
}
