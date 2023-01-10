package co.micol.prj.member.command;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import co.micol.prj.common.Command;
import co.micol.prj.member.service.MemberService;
import co.micol.prj.member.service.MemberVO;
import co.micol.prj.member.serviceImpl.MemberServiceImpl;

public class MemberListAjax implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		MemberService sercive = new MemberServiceImpl();
		
		List<MemberVO> list = sercive.memberSelectList();  //memberSelectList이 콜렉션 타입이기때문에 list에 담아줌
		
		ObjectMapper mapper = new ObjectMapper();
		
		String json ="";
		try {
			json = mapper.writeValueAsString(list);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "Ajax:"+json;
	}

}
