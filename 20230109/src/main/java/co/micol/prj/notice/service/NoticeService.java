package co.micol.prj.notice.service;

import java.util.List;

import co.micol.prj.notice.command.Criteria;

public interface NoticeService {
	List<NoticeVO> noticeSelectList();

	NoticeVO noticeSelect(NoticeVO vo); // 첨부파일 한개만 받음

	int noticeInsert(NoticeVO vo); // 게시글 저장

	int noticeUpdate(NoticeVO vo); // 게시글 수정

	int noticeDelete(NoticeVO vo); // 게시글 삭제

	int noticeAttechDelete(NoticeAttechVO vo); // 첨부파일 삭제

	int noticeAttechInsert(NoticeAttechVO vo); // 첨부파일 저장

	void noticeHitUpdate(int id); // 조회수 증가

	List<NoticeVO> noticeSearchList(String key, String val); // 게시글 내 검색을 위해

	List<NoticeVO> noticeListPaging(Criteria cri);  //페이징 변수로 페이지가 들어감 amount : 한페이지에 보여줄 데이터 개수
	
	int pagingAllCount(Criteria cri);  // 전체 데이터의 개수 가지고 오기 
}
