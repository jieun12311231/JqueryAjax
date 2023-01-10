package co.micol.prj.member.command;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import co.micol.prj.common.Command;
import co.micol.prj.member.service.MemberService;
import co.micol.prj.member.serviceImpl.MemberServiceImpl;

public class ProductDetail implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		// 상품의 데이터를 넘겨주는 클래스
		String productCd = request.getParameter("item");

		System.out.println("productCd " + productCd);

		MemberService service = new MemberServiceImpl();
		Map<String, Object> map = service.productDetail(productCd);

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
