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

public class UpdateMemberAjax implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		// 변경 버튼 누르면 회원 정보수정
		String id = request.getParameter("id");
		String address = request.getParameter("address");
		String phone = request.getParameter("phone");

		MemberVO vo = new MemberVO();

		vo.setMemberId(id);
		vo.setMemberAddress(address);
		vo.setMemberTel(phone);
		System.out.println(vo + "==============================");
		MemberService service = new MemberServiceImpl();
		int cnt = service.memberUpdate(vo);

		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> map = new HashMap<>();
		String json = "";
		if (cnt > 0) {
//			json = "{\"retCode\": \"Success\"}, \"memberId\": " +vo.getMemberId()+"}";  //mapper을 안쓰면 이렇게 어럽게 적어야함

			MemberVO svo = service.memberSelect(vo); // 여기의 id값으로 전체 값을 반환하주고 그것을 svo에 담음
			map.put("retCode", "Success");
			map.put("data", svo);
			try {
				json = mapper.writeValueAsString(map); // writeValueAsString : 객체를 json문자열로 바꿔주는것
			} catch (JsonProcessingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {
//			json = "{\"retCode\": \"Fail\"}";
			map.put("retCode", "Fail");
		}

		return "Ajax:" + json;
	}

}
