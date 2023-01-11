package co.micol.prj.notice.command;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import co.micol.prj.common.Command;
import co.micol.prj.notice.service.NoticeService;
import co.micol.prj.notice.service.NoticeVO;
import co.micol.prj.notice.serviceImpl.NoticeServiceImpl;

public class NoticePagingAjax implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		// 데이터 받아오는 곳 
		
		String page = request.getParameter("page");
		String amount = request.getParameter("amount");
		
		//검색
		String searchCondition = request.getParameter("searchCondition");
		String keyword = request.getParameter("keyword");
		
		//두개의 매개값을 받아옴 
		Criteria cri = new Criteria(Integer.parseInt(page),Integer.parseInt(amount));
		
		
		cri.setSearchCondition(searchCondition);
		cri.setKeyword(keyword);
				
		NoticeService service = new NoticeServiceImpl();
		
		List<NoticeVO> list = service.noticeListPaging(cri);
		
		ObjectMapper mapper = new ObjectMapper();
		
		String json = "";
		
		try {
			json = mapper.writeValueAsString(list);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "Ajax:" + json;
	}

}
