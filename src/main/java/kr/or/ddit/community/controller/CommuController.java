package kr.or.ddit.community.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.comm.vo.PaginationVO;
import kr.or.ddit.community.service.CommuService;
import kr.or.ddit.community.vo.CommuBKMKVO;
import kr.or.ddit.community.vo.CommuBoardFileVO;
import kr.or.ddit.community.vo.CommuBoardRepleVO;
import kr.or.ddit.community.vo.CommuBoardVO;
import kr.or.ddit.community.vo.CommuVO;
import kr.or.ddit.emp.vo.EmpVO;
import kr.or.ddit.jobTitle.vo.JobTitleVO;
import kr.or.ddit.vote.vo.VotePostEmpDeptVO;
import kr.or.ddit.vote.vo.VotePostVO;

@Controller
public class CommuController {

	
	private static final Logger logger = LoggerFactory.getLogger(CommuController.class);
	
	@Resource(name = "commuService")
	private CommuService commuService;
	
	
	
	
	
	
	
	@RequestMapping("/commu/myCommuManage")
	public String  myCommuManage(HttpSession session, Model model) {
		
		// 로그인시 세션에 저장된 사원정보 가져오기
		EmpVO empVO = (EmpVO) session.getAttribute("EMP");
		CommuVO commuVO = new CommuVO();
		commuVO.setEmpId(empVO.getEmpId());
		
		// 사원이 생성한 커뮤니티 정보리스트 가져오기
		List<CommuVO> commuList = commuService.selectMyCommu(commuVO);
		model.addAttribute("commuList", commuList);
		return "tiles/commu/myCommuManage";
	}
	
	
	
	
	
	
	
	@RequestMapping("/commu/createCommuView")
	public String createCommuVIew() {
		// 커뮤니티 생성 페이지 이동
		return "tiles/commu/createCommu";
	}
	
	
	
	
	
	
	
	@RequestMapping("/commu/createCommu")
	public String createCommu(HttpSession session, CommuVO commuVO, @RequestPart(name = "file") MultipartFile file) {
		// 로그인시 세션에 저장된 사원정보 가져오기
		EmpVO dbEmp = (EmpVO) session.getAttribute("EMP");
		commuVO.setEmpId(dbEmp.getEmpId());
		
		// 생성하려는 커뮤니티 정보 DB에 저장
		int insertCommu = commuService.insertCommu(commuVO, file);
		if(insertCommu == 1) {
			return "redirect:/commu/myCommuManage";
		}else {
			return "/commu/createCommu";
		}
	}
	
	
	
	
	
	
	
	
	
	
	@RequestMapping("/commu/updateCommu")
	public String updateCommu(CommuVO commuVO) {
		// DB에 접속 후 해당 커뮤티니정보를 가져온 커뮤티니 정보로 수정
		int updateCommuRes = commuService.updateCommu(commuVO);
		return "redirect:/commu/myCommuManage";
	}
	
	
	
	
	
	
	
	
	
	
	
	@RequestMapping("/commu/commuKindView")
	public String commuKindView(EmpVO empVO, Model model, HttpSession session) {
		
		// session의 emp정보에 담긴 사원id를 추출
		EmpVO dbEmp = (EmpVO) session.getAttribute("EMP");
		
		// 커뮤니티 전체 불러오기
		// 사원이 즐겨찾기에 추가한 커뮤니티 불러오기
		Map<String, Object> myCommuMap = commuService.selectCommuMap(dbEmp);
		model.addAttribute("commuList", myCommuMap.get("commuList")); 
		model.addAttribute("commuBKMKList", myCommuMap.get("commuBKMKList")); 
		
		return "tiles/commu/commuKindView";
	}
	
	
	
	
	@RequestMapping("/commu/commuIconView")
	public String commuIconView(CommuVO commuVO, Model model) {
		
		CommuVO DBcommuVO = commuService.selectCommuIcon(commuVO);
		if(DBcommuVO != null) {
			model.addAttribute("commuIconPath", DBcommuVO.getCommuIconPath());
		}
		return "commuIconView";
	}
	
	
	
	
	
	
	@RequestMapping("/commu/insertCommuBKMK")
	public String insertCommuBKMK(CommuBKMKVO commuBkmk, HttpSession session) {
		
		EmpVO empVO = (EmpVO) session.getAttribute("EMP");
		commuBkmk.setEmpId(empVO.getEmpId());
		
		int insertCommuBKMK = commuService.insertCommuBKMK(commuBkmk);
		return "redirect:/commu/commuBoardList?commuSeq="+commuBkmk.getCommuSeq();
	}
	
	
	
	
	
	@RequestMapping("/commu/deleteCommuBKMK")
	public String deleteCommuBKMK(CommuBKMKVO commuBkmk, HttpSession session) {
		
		EmpVO empVO = (EmpVO) session.getAttribute("EMP");
		commuBkmk.setEmpId(empVO.getEmpId());
		
		int deleteCommuBKMK = commuService.deleteCommuBKMK(commuBkmk);
		return "redirect:/commu/commuBoardList?commuSeq="+commuBkmk.getCommuSeq();
	}
	
	
	
	
	
	
	
	
	@RequestMapping("/commu/commuBoardList")
	public String commuBoardView(CommuBoardVO commuBoardVO, Model model, HttpSession session) {
		try {
			// 커뮤니티 board 리스트
			List<CommuBoardVO> commuBoardList = commuService.selectListCommuPost(commuBoardVO);
			// 커뮤니티 전체 페이지 수
			int commuListCount = commuService.selectCommuBoardPageAllCount(commuBoardVO);
			CommuVO commuVO = new CommuVO();
			commuVO.setCommuSeq(commuBoardVO.getCommuSeq());
			// 커뮤니티 이름
			List<CommuVO> commuList = commuService.selectCommu(commuVO);
			
			// 커뮤니티 북마크 확인
			EmpVO emp = (EmpVO) session.getAttribute("EMP"); // 로그인한 사원의 사원정보
			CommuBKMKVO commuBkmk = new CommuBKMKVO();
			commuBkmk.setCommuSeq(commuBoardVO.getCommuSeq());
			commuBkmk.setEmpId(emp.getEmpId());
			
			// 로그인한 사원의 해당 커뮤니티 북마크 유무 정보
			CommuBKMKVO dbCommuBkmk = commuService.selectMyBookMark(commuBkmk);
			// 해당 게시글 작성자의 직급
			// 해당 게시 작성자의 부서, 팀명
			List<String> empTitleList = null;
			List<VotePostEmpDeptVO> empDeptInfoList = null;
			if(commuBoardList.size() > 0 && commuBoardList != null) {
				empTitleList = new ArrayList<String>();
				empDeptInfoList = new ArrayList<VotePostEmpDeptVO>();
				// 작성한 사원의 직급정보와 부서정보, 팀정보 가져오기 
				for(CommuBoardVO tempVO  : commuBoardList) {
					// 직급정보 가져오기
					JobTitleVO empJobTitleVO = commuService.selectCommuBoardListEmpJobTitle(tempVO.getEmpId());
					empJobTitleVO.setEmpId(tempVO.getEmpId());
					// 부서, 팀 정보 가져오기
					VotePostEmpDeptVO empDeptVO = commuService.selectCommuBoardListEmpDeptInfo(empJobTitleVO);
					empTitleList.add(empJobTitleVO.getJobtitleNm());
					empDeptInfoList.add(empDeptVO);
				}
				model.addAttribute("empTitleList", empTitleList);
				model.addAttribute("empDeptInfoList", empDeptInfoList);
			}
			// 페이징 처리
			PaginationVO pagination = new PaginationVO(commuBoardVO.getPageIndex(), commuBoardVO.getRecordCountPerPage(), 
					   								   commuBoardVO.getPageSize(), commuListCount);
			// 게시글 번호 넘버링 처리
			int boardFrontNum = ((commuBoardVO.getPageIndex() - 1) * commuBoardVO.getRecordCountPerPage());
			
			model.addAttribute("pagination", pagination);
			model.addAttribute("dbCommuBkmk", dbCommuBkmk);				
			model.addAttribute("commuNm", commuList.get(0).getCommuNm());				
			model.addAttribute("commuSeq", commuBoardVO.getCommuSeq());
			model.addAttribute("commuBoardList", commuBoardList);
			model.addAttribute("searchKeyword", commuBoardVO.getSearchKeyword());
			model.addAttribute("searchCondition", commuBoardVO.getSearchCondition());
			model.addAttribute("boardFrontNum", boardFrontNum);
		} catch (Exception e) { e.printStackTrace(); }
		return "tiles/commu/commuBoard";
	}
	
	
	
	
	
	
	
	@RequestMapping("/commu/commuPostInsertView")
	public String commuBoardInsertView(int commuSeq, Model model) {
		// 커뮤니티 번호를 저장 후 게시글작성 페이지 이동
		model.addAttribute("commuSeq", commuSeq);
		return "tiles/commu/commuPostInsert";
	}
	
	
	
	
	
	
	
	
	@RequestMapping("/commu/insertPost")
	public String insertPost(@RequestPart(name = "file", required = false) List<MultipartFile> fileList, 
							 CommuBoardVO commuBoardVO, HttpSession session) {
		// 로그인한 사원의 사원정보 가져오기
		EmpVO dbEmp = (EmpVO) session.getAttribute("EMP");
		// 입력한 게시글정보와 첨부파일정보 DB의 commuboard테이블에 저장
		int insertCommuBoardRes = commuService.insertCommuBoard(fileList, commuBoardVO, dbEmp);
		if(insertCommuBoardRes == 1) {
			// 저장한 게시글의 게시글번호 가져오기
			int commuBoardCurrval = commuService.selectCurrval();
			return "redirect:/commu/commuPostView?boardSeq="+commuBoardCurrval;				
		}else {
			return "/commu/insertPost";	
		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	@RequestMapping("/commu/commuPostView")
	public String commuPostView(CommuBoardVO commuBoardVO, Model model) {
		// 선택한 커뮤니티 게시글 정보를 가지고 DB의 commuboard테이블에서 게시글번호와 선택한 게시글번호가 일치하는 데이터의 정보 가져오기 
		Map<String, Object> commuBoardMap = commuService.selectCommuBoard(commuBoardVO);
		if(commuBoardMap != null) {
			model.addAttribute("commuBoard", commuBoardMap.get("dbCommuBoard")); // 게시글 정보
			model.addAttribute("commuBoardFileList", commuBoardMap.get("commuBoardFileList")); // 게시글 첨부파일 리스트 
			model.addAttribute("repleList", commuBoardMap.get("commuBoardRepleList")); // 게시글 댓글 리스트
			model.addAttribute("empTitle", commuBoardMap.get("empTitle")); // 게시글 작성자 직급
			model.addAttribute("commuRepleEmpTitleList", commuBoardMap.get("commuRepleEmpTitleList")); // 댓글 작성자 직급
		}
		return "tiles/commu/commuPostView";
	}
	
	
	
	
	
	
	
	
	
	
	
	@RequestMapping("/commu/updateBoardView")
	public String updateBoard(CommuBoardVO commuBoardVO, Model model) {
		
		Map<String, Object> commuBoardMap = commuService.selectCommuBoard(commuBoardVO);
		CommuBoardVO dbCommuBoardVO = (CommuBoardVO) commuBoardMap.get("dbCommuBoard");
		List<CommuBoardFileVO> commuBoardFileList = (List<CommuBoardFileVO>) commuBoardMap.get("commuBoardFileList");
		if(dbCommuBoardVO != null) {
			model.addAttribute("commuBoard", dbCommuBoardVO);
			model.addAttribute("commuBoardFileList", commuBoardFileList);
		}
		return "tiles/commu/commuPostUpdate";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	@RequestMapping("/commu/updatePost")
	public String postUpdateForm(HttpSession session, 
								 CommuBoardVO commuBoardVO, 
								 @RequestPart(name = "file", required = false) List<MultipartFile> fileList,
								 @RequestParam(name = "delFile", required = false) List<Integer> delFileList) {
		// 게시글 정보 수정
		int updatePostResult = commuService.updatePost(session, commuBoardVO, fileList, delFileList);
		
		if(updatePostResult == 1) {
			return "redirect:/commu/commuPostView?boardSeq="+commuBoardVO.getBoardSeq();						
		}else {
			return "/commu/updatePost";			
		}
	}
	
	
	
	
	
	@RequestMapping("/commu/deleteCommuBoard")
	public String deleteCommuBoard(HttpSession session, 
			 					   CommuBoardVO commuBoardVO) {
		// 선택한 커뮤니티 정보와 세션정보를 가져가서 선택한 게시글의 상태코드를 'Y'에서 'N'으로 변경한다.
		int delUpPostResult = commuService.delUpCommuBoard(session, commuBoardVO);
		if(delUpPostResult == 1) {
			return "redirect:/commu/commuBoardList?commuSeq="+commuBoardVO.getCommuSeq();
		}else {
			return "redirect:/commu/commuPostView?boardSeq="+commuBoardVO.getBoardSeq();
		}
	}
	
	
	
	
	
	
	@RequestMapping("/commu/repleRegist")
	public String repleRegist(CommuBoardRepleVO commuRepleVO, HttpSession session) {
		// 작성한 댓글정보에서 개행문자인 '\n'을 '<br>'로 변경 후 setter에 대입한다.
		String repleCont = commuRepleVO.getRepleCont().replace("\n", "<br>");
		commuRepleVO.setRepleCont(repleCont);
		// 로그인한 사원의 사원정보 가져오기
		EmpVO dbEmp = (EmpVO) session.getAttribute("EMP");
		commuRepleVO.setEmpId(dbEmp.getEmpId());
		commuRepleVO.setEmpNm(dbEmp.getEmpNm());
		// 작성한 댓글 정보를 DB의 commureple테이블에 저장한다.
		int insertRepleRes = commuService.insertCommuReple(commuRepleVO);
		return "redirect:/commu/commuPostView?boardSeq="+commuRepleVO.getBoardSeq();
	}
	
	
	
	
	
	@RequestMapping("/commu/deleteCommuReple")
	public String deleteCommuReple(CommuBoardRepleVO commuRepleVO) {

		int deleteCommuRepleCnt = commuService.updateRepleSt(commuRepleVO);
		if(deleteCommuRepleCnt == 1) {
			return "redirect:/commu/commuPostView?boardSeq="+commuRepleVO.getBoardSeq();
		}else {
			return "/commu/deleteCommuReple";			
		}
	}
	
	
	
	
	
	@RequestMapping("/commu/fileDown")
	public String commuBoardFileDown(CommuBoardFileVO commuBoardFile, Model model) {
		
		List<CommuBoardFileVO> dbFileList = commuService.selectCommuBoardFile(commuBoardFile);
		
		if(dbFileList != null && dbFileList.size() > 0) {
			model.addAttribute("dbFile", dbFileList.get(0));
			return "commuBoardFileDownView";
		}else {
			return "/commu/commuPostView?boardSeq="+commuBoardFile.getBoardSeq();
		}
		
	}
	
	
	
	
	
}
