package co.micol.prj.notice.command;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import co.micol.prj.common.Command;
import co.micol.prj.notice.service.NoticeService;
import co.micol.prj.notice.service.NoticeVO;
import co.micol.prj.notice.serviceImpl.NoticeServiceImpl;

public class NoticeDelListAjax implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		// 리스트 삭제
		String id = request.getParameter("id"); // 삭제하기 위한 파라미터 받아오기
//		String page = request.getParameter("page");
//		String amount = request.getParameter("amount");
//		//검색
//		String searchCondition = request.getParameter("searchCondition");
//		String keyword = request.getParameter("keyword");
//
//		Criteria cri = new Criteria(Integer.parseInt(page),Integer.parseInt(amount));
//		cri.setSearchCondition(searchCondition);
//		cri.setKeyword(keyword);
		
		NoticeService service = new NoticeServiceImpl();
		
		NoticeVO vo = new NoticeVO();
	
		vo.setNoticeId(Integer.parseInt(id));
		
		int cnt = service.noticeDelete(vo);
		
		Map<String, Object> map = new HashMap<>();
		
		if(cnt > 0) {
			map.put("retCode", "Success");
		}else {
			map.put("retCode", "Fail");
		}
		
		ObjectMapper mapper = new ObjectMapper();
		
		String json = "";
		
		try {
			json = mapper.writeValueAsString(map);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "Ajax:" + json;
	}

}
