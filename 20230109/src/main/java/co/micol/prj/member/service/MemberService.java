package co.micol.prj.member.service;

import java.util.List;
import java.util.Map;

public interface MemberService {
	List<MemberVO> memberSelectList(); //전체조회
	MemberVO memberSelect(MemberVO vo); //한사람 조회 또는 로그인
	int memberInsert(MemberVO vo);  //입력
	int memberDelete(MemberVO vo);  //삭제
	int memberUpdate(MemberVO vo);  //수정
	
	boolean isIdCheck(String id);  //아이디 중복체크 존재하면 false
	
	//상품 목록 
	List<Map<String, Object>> productList(); //상품 조회
	
	Map<String, Object> productDetail(String item);  //상품 상세
	
	List<Map<String, Object>> relatedProducts(); //평점기준 4개 관련상품
}
