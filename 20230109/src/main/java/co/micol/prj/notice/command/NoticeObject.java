package co.micol.prj.notice.command;

import java.sql.Date;
import java.text.SimpleDateFormat;
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

public class NoticeObject implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		// 객체 타입으로 데이터 받아오기
		
		NoticeService service = new NoticeServiceImpl();
		List<NoticeVO> notices = new ArrayList<NoticeVO>();

		notices = service.noticeSelectList();
		
//		for(NoticeVO vo : notices) {
//			List<String> data = new ArrayList<>();
//			data.add(String.valueOf(vo.getNoticeId())); 
//			data.add(vo.getNoticeWriter());
//			data.add(vo.getNoticeDate().toLocaleString());
//			data.add(vo.getNoticeTitle());
//			data.add(vo.getNoticeFile());
//			data.add(String.valueOf(vo.getNoticeHit())); 
//		}
		
		Map<String, Object> map = new HashMap<>();

		map.put("data", notices);
		
		ObjectMapper mapper = new ObjectMapper();
		String json = "";

		try {
			json = mapper.writeValueAsString(map);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}

		return "Ajax:" + json;
	}

}
