package co.micol.prj.notice.command;

import java.util.ArrayList;
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

public class NoticeListPaging implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		// 데이터 가지고 오기
		NoticeService service = new NoticeServiceImpl();
		List<NoticeVO> notices = new ArrayList<NoticeVO>();

		notices = service.noticeSelectList();
		
		List<List<String>> collect = new ArrayList<>();
		for(NoticeVO vo : notices) {  // 반복문 돌면서 보에 원하는 형식으로 데이터를 담아줌
			List<String> data = new ArrayList<>(); 
			data.add(String.valueOf(vo.getNoticeId()));  // id
			data.add(vo.getNoticeWriter());
			data.add(vo.getNoticeDate().toLocaleString());  // ?
			data.add(vo.getNoticeTitle());
			data.add(vo.getNoticeFile());
			data.add(String.valueOf(vo.getNoticeHit()));
			
			collect.add(data);  //반복문으로 담은 data를 list에 담아줌
		}
//		request.setAttribute("notices", notices);

		Map<String, Object>map = new HashMap<>();
		
		map.put("data", collect);
		
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
