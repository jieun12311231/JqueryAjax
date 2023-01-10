package co.micol.prj.member.command;


import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import co.micol.prj.common.Command;
import co.micol.prj.member.service.MemberService;
import co.micol.prj.member.serviceImpl.MemberServiceImpl;

public class RelatedProducts implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		// 상위 4개의 상품 데이터 가지고와서 띄우기
		MemberService service = new MemberServiceImpl();

		List<Map<String, Object>> map = service.relatedProducts();

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
