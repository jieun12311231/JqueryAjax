package co.micol.prj.member.command;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import co.micol.prj.common.Command;
import co.micol.prj.member.service.MemberService;
import co.micol.prj.member.service.MemberVO;
import co.micol.prj.member.serviceImpl.MemberServiceImpl;

public class MemberDelAjax implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		// 회원삭제  --> 여기서 성공을 하면 db에서 지워진것!!
		String id = request.getParameter("id"); // 삭제하기 위한 파라미터 받아오기

		MemberService service = new MemberServiceImpl();

		MemberVO vo = new MemberVO();

		vo.setMemberId(id);

		int cnt = service.memberDelete(vo);

		Map<String, Object> map = new HashMap<>();

		if (cnt > 0) {
			map.put("retCode", "Success");
		} else {
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
