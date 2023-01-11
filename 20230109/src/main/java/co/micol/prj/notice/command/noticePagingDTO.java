package co.micol.prj.notice.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import co.micol.prj.common.Command;
import co.micol.prj.notice.service.NoticeService;
import co.micol.prj.notice.serviceImpl.NoticeServiceImpl;

public class noticePagingDTO implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		
		// 페이지마다 가지고 오기 위한 용도 / 페이지
		String page = request.getParameter("page");
		String amount = request.getParameter("amount");
		
		//검색
		String searchCondition = request.getParameter("searchCondition");
		String keyword = request.getParameter("keyword");

		Criteria cri = new Criteria(Integer.parseInt(page), Integer.parseInt(amount));
		cri.setSearchCondition(searchCondition);
		cri.setKeyword(keyword);
		
		//전체건수 계산
		NoticeService service = new NoticeServiceImpl();
		int total = service.pagingAllCount(cri); // 전체 건수 가지고 오기

//		int total = 256; // 전체 데이터가 256개라는 가정 
//		int pageInt = Integer.parseInt(page); // 파라미터는 문자열이기때문에 int타입으로 변환

		PageDTO pageDTO = new PageDTO(cri, total);

		ObjectMapper mapper = new ObjectMapper();

		String json = "";

		try {
			json = mapper.writeValueAsString(pageDTO);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}

		return "Ajax:" + json;
	}

}
