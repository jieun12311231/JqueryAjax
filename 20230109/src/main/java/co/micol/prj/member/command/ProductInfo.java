package co.micol.prj.member.command;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import co.micol.prj.common.Command;

public class ProductInfo implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		//상품 상세 목록
		
		//상품에 대한 CF001에대한 상세 정보를  => json형식으로 넘겨줘야함
		//평점 순위 4개 상품 정보를 json형식으로 넘겨줘야함
		//데이터를 받아오는 컨트롤러를 새로 만들어서 
		//여기서 하나의 정보는 담아 놔야지 productInfo여기에 넣어서 보낼수 있음
		String item_code = request.getParameter("item");
		request.setAttribute("productCode", item_code);  //json넘겨주는 용으로 사용

		System.out.println("ProductInfo item_code ="+item_code);
		return "jquery/productInfo.tiles";
	}

}
