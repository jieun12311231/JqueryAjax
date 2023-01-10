package co.micol.prj.notice.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.micol.prj.common.Command;

public class NoticeObjectPaging implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		// 두번째 게시판
		return "jquery/noticeObjectPaging.tiles";
	}

}
