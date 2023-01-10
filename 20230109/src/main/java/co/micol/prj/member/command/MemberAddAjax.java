package co.micol.prj.member.command;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import co.micol.prj.common.AES256Util;
import co.micol.prj.common.Command;
import co.micol.prj.member.service.MemberService;
import co.micol.prj.member.service.MemberVO;
import co.micol.prj.member.serviceImpl.MemberServiceImpl;

public class MemberAddAjax implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		// 폼에서 name값들(파라미터)이 넘어오는것을 처리
		String id = request.getParameter("memberId");
		String name = request.getParameter("memberName");

		String password = request.getParameter("memberPassword");
		try {
			AES256Util aes = new AES256Util();
			try {
				password = aes.encrypt(password);
			} catch (NoSuchAlgorithmException e) {
				e.printStackTrace();
			} catch (GeneralSecurityException e) {
				e.printStackTrace();
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		String age = request.getParameter("memberAge");
		String address = request.getParameter("memberAddress");
		String phone = request.getParameter("memberTel");

		MemberVO vo = new MemberVO();

		vo.setMemberId(id);
		vo.setMemberName(name);
		vo.setMemberPassword(password);
		vo.setMemberAge(Integer.parseInt(age));
		vo.setMemberAddress(address);
		vo.setMemberTel(phone);
		vo.setMemberAuthor("USER");  //가입하면 기본으로 user가 되어서 등록 되도록
		
//		System.out.println(vo);
		
		MemberService dao = new MemberServiceImpl();
		
		int cnt = dao.memberInsert(vo); // 입력 되면 처리되는 건수 입력
		
		ObjectMapper mapper = new ObjectMapper();
		
		Map<String, Object> map = new HashMap<>();  //key:value형태로 받기위해서 Map을 사용
		// {"retCode":"Success","data":vo} //리턴이 성공하면 리턴값으로 vo넘겨주기
		if (cnt > 0) {
			map.put("retCode", "Success");
			map.put("data", vo);

		} else {
			map.put("retCode", "Fail");
		}

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
