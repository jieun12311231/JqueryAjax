package co.micol.prj.notice.command;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria { // 페이지 개수를 지정하기 위한 클래스

	//페이지 개수지정
	private int page;// 현재 페이지 정보
	private int amount;// 한페이지당 보여줘야할거

	//검색
	private String searchCondition;
	private String keyword;

	public Criteria() {
		this.page = 1;
		this.amount = 10; // 아무 설정이 없으면 기본 값을 10개로 지저해서 보여줌
	}

	public Criteria(int page, int amount) {
		this.page = page;
		this.amount = amount;// 지정한 페이지가 있으면 지정한 값으로 보여줘라
	}

}
