package co.micol.prj.notice.command;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import co.micol.prj.common.Command;

public class NoticePaging implements Command {

	@Override
	public String exec(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		return "jquery/noticePagingForm.tiles";
	}

}
