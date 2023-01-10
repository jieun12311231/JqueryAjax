package co.micol.prj.member.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import co.micol.prj.common.Command;
import co.micol.prj.member.service.MemberService;
import co.micol.prj.member.service.MemberVO;
import co.micol.prj.member.serviceImpl.MemberServiceImpl;

public class MemberGetAjax implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		//회원 수정을 위한 회원 한명 조회
		String id = request.getParameter("id");
		
		MemberService service = new MemberServiceImpl();
		MemberVO vo = new MemberVO();
		vo.setMemberId(id);
		
		MemberVO svo =service.memberSelect(vo);  //리턴되는 타입이 MemberVO임

		System.out.println(id +"===========");
		String json = "";
		ObjectMapper mapper = new ObjectMapper();
		
		try {
			json = mapper.writeValueAsString(svo);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "Ajax:" + json;
	}

}
