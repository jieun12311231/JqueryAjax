package co.micol.prj.notice.command;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PageDTO {

	// 135건이면 페이지는 14개가 나옴 (10개 기준)
	// 보여줄 화면 => 현재 페이지가 13페이지일 경우 : 11 ~ 13페이지 ~ 14. 이후는(X)

	// 235건이면 페이지는 24개가 나옴 (10개 기준)
	// 보여줄 화면 => 현재 페이지가 13페이지일 경우 : 11 ~ 13페이지 ~ 14. 이후는(O)

	private int startPage; // 한줄에 보여 줄 시작 페이지
	private int endPage; // 한줄에 보여줄 마지막 페이지
	private int currPage; // 현재 페이지
	private boolean prev, next; // 이전(이전 10 건으로 넘어감), 이후(이후 10 건을 보여줌)
	private int total; // 총 등록되어있는 데이터 건수

	// 생성자 - 한페이지가 10개라는 가정으로 만드는중..
	public PageDTO(Criteria cri, int total) {
		this.currPage = cri.getPage();  
		this.total = total;

		// 현재 페이지 기준 끝 페이지
		this.endPage = (int) Math.ceil((1.0 * this.currPage) / 10) * 10; // 현재 페이지가 5페이지 더라도 마지막인 10이 나와야함 //ceil : 올림 // 현재
																	// 페이지에서 10을 나누면 0.x으로 나오기떄문에 올림 하면 1-> 곱하기 10을하면
		this.startPage = this.endPage - 9;

		//
		int realEnd = (int) Math.ceil(total * 1.0 / cri.getAmount());
		if (this.endPage > realEnd)
			this.endPage = realEnd;
		

//		System.out.println(realEnd);
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd; // 다음페이지가 있다는 말임..
	}

}
