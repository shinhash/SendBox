package kr.or.ddit.emp.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.ddit.attend.service.AttendService;
import kr.or.ddit.business.busiboard.service.BusiBoardService;
import kr.or.ddit.business.busiboard.vo.BusiBoardVO;
import kr.or.ddit.business.library.service.LibService;
import kr.or.ddit.business.library.vo.LibEmpVO;
import kr.or.ddit.emp.service.EmpService;
import kr.or.ddit.emp.vo.EmpVO;
import kr.or.ddit.emp.vo.LeftItemVO;
import kr.or.ddit.mail.service.MailService;
import kr.or.ddit.mail.vo.MailVO;
import kr.or.ddit.notice.service.NoticeService;
import kr.or.ddit.notice.vo.NoticeVO;
import kr.or.ddit.report.service.ReportService;
import kr.or.ddit.report.vo.ApprovalVO;
import kr.or.ddit.report.vo.ReportVO;
import kr.or.ddit.report.vo.SubWorkerVO;



@Controller
public class MainController {
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);

	@Resource(name="empService")
	EmpService empService;
	
	@Resource(name = "noticeService")
	NoticeService noticeService;
	
	@Resource(name = "mailService")
	MailService mailService;
	
	@Resource(name="reportService")
	ReportService reportService;
	
	@Resource(name="attendService")
	AttendService attendService;
	
	@Resource(name="busiBoardService")
	BusiBoardService busiBoardService;
	
	@Resource(name="libService")
	LibService libService;
	
	@RequestMapping(path="/main", method=RequestMethod.GET)
	public String mainView(Model model, NoticeVO noticeVO,HttpSession session) {
		EmpVO empVo2 =null;
		EmpVO empVo = (EmpVO) session.getAttribute("EMP");
		String empId = empVo.getEmpId();
		
		MailVO mailVo= new MailVO();
		mailVo.setMailSt("RY");
		mailVo.setReceiver(empVo.getEmpId());
		
		ReportVO reportVo = new ReportVO();
		reportVo.setEmpId(empVo.getEmpId());
		reportVo.setReportSt("ing");
		reportVo.setPageSize(5);
		
		BusiBoardVO busiBoard = new BusiBoardVO("", empVo.getDeptId(), "", 0);
		LibEmpVO libEmp = new LibEmpVO();
		libEmp.setDeptId(empVo.getDeptId());
		
		List<MailVO> mailList = null;	
		List<ReportVO> reportList = null;
		List<BusiBoardVO> busiBoardList = null;
		List<LibEmpVO> libList = null;
		SubWorkerVO subWorker = null;
		String monday = "";
		String tuesday = "";
		String wednesday = "";
		String thursday = "";
		String friday = "";
		
		try {
			model.addAttribute("NoticeList", noticeService.mainNoticeList(noticeVO));
			subWorker = reportService.subWorkerCheck(reportVo);
			empVo = empService.getEmp(empVo);
			empVo2 = empService.getEmpDept(empVo);
			mailList = mailService.mailList(mailVo);
			reportList = reportService.getRepostList(reportVo);
			busiBoardList = busiBoardService.selectBusiBoardList(busiBoard);
			libList = libService.libSelect(libEmp);
			monday = attendService.monday(empId);
			tuesday = attendService.tuesday(empId);
			wednesday = attendService.wednesday(empId);
			thursday = attendService.thursday(empId);
			friday = attendService.friday(empId);
			System.out.println("--------------------------------------------------------");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		String week = monday +"," + tuesday + "," + wednesday + "," + thursday + "," + friday;
		session.setAttribute("subWorker", subWorker);
		session.setAttribute("busiBoardList", busiBoardList);
		session.setAttribute("libraryList", libList);
		session.setAttribute("EMP", empVo);
		model.addAttribute("emp",empVo2);
		model.addAttribute("MailList",mailList);
		model.addAttribute("weeklist",week);
		return "tiles/main/main";
	}
	
	
	@RequestMapping(path="/main/left")
	public String loadMainLeft(LeftItemVO left, HttpSession session, Model model) {
		EmpVO emp = (EmpVO) session.getAttribute("EMP");
		left.setEmpId(emp.getEmpId());
		SubWorkerVO subWorker = (SubWorkerVO)session.getAttribute("subWorker");
		//새로 업로드된 완료 카운트
		logger.debug("**left : {}", left);
		/*List<LibEmpVO> libList = (List<LibEmpVO>)session.getAttribute("libList");
		for (LibEmpVO libEmpVO : libList) {
			logger.debug("libEmpVO : {}", libEmpVO);
		}
		logger.debug("libList : {}", libList.toString());*/
		
		
		ReportVO report = new ReportVO();
		int completeCnt = 0;
		int declineCnt = 0;
		int toApprovCnt = 0;
		int approvFinCnt = 0;
		
		try {
			report.setEmpId(left.getEmpId());
			
			//사원의 서류완료함 카운팅 조회
			report.setReportSt("Y");
			report.setReadYn("Y");
			completeCnt = reportService.selectReportTotCnt(report);
			//사원의 서류반려함 카운팅 조회
			report.setReportSt("N");
			declineCnt = reportService.selectReportTotCnt(report);
			
			//결재자의 결재대기함 카운팅 조회
			report.setEmpId("");
			report.setReadYn("");
			report.setReportSt("W");
			report.setApprover(left.getEmpId());
			if(left.getSubEmpId() != null && !"".equals(left.getSubEmpId())) {
				report.setApprover(subWorker.getEmpId());
			}
			toApprovCnt = reportService.selectReportTotCnt(report);
			report.setReportSt("ing");
			toApprovCnt += reportService.selectReportTotCnt(report);
			
			//결재자의 결재완료함 카운팅 조회
			
			ApprovalVO approvalVo = new ApprovalVO();
			approvalVo.setEmpId(emp.getEmpId());
			if(left.getSubEmpId() != null && !"".equals(left.getSubEmpId())) {
				approvalVo.setEmpId(subWorker.getEmpId());
			}
			approvalVo.setCheckYn("N");
			approvFinCnt = reportService.selectApprovalTotCnt(approvalVo);
			
			left.setCompleteCnt(completeCnt);
			left.setDeclineCnt(declineCnt);
			left.setApprovCnt(toApprovCnt);
			left.setApprovFinCnt(approvFinCnt);
			
			logger.debug("##left : {}", left);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		session.setAttribute("menuLocation", left.getMenuLocation());
		session.setAttribute("openLeftId", left.getOpenLeftId());
		model.addAttribute("leftItemVo", left);
		return "jsonView";
	}
	
}
