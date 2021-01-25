package kr.or.ddit.community.service;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.community.controller.FileUploadUtil;
import kr.or.ddit.community.dao.CommuMapperDao;
import kr.or.ddit.community.vo.CommuBKMKVO;
import kr.or.ddit.community.vo.CommuBoardFileVO;
import kr.or.ddit.community.vo.CommuBoardRepleVO;
import kr.or.ddit.community.vo.CommuBoardVO;
import kr.or.ddit.community.vo.CommuVO;
import kr.or.ddit.emp.vo.EmpVO;
import kr.or.ddit.jobTitle.vo.JobTitleVO;
import kr.or.ddit.vote.vo.VotePostEmpDeptVO;

@Service("commuService")
public class CommuService {
	
	@Resource(name = "commuMapperDao")
	private CommuMapperDao commuMapperDao;
	
	private static final Logger logger = LoggerFactory.getLogger(CommuService.class);

	
	
	public List<CommuVO> selectMyCommu(CommuVO commuVO) {
		List<CommuVO> commuList = null;
		try {
			commuList = commuMapperDao.selectMyCommuList(commuVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return commuList;
	}
	
	
	
	
	public int insertCommu(CommuVO commuVO, MultipartFile file) {
		
		int insertCommuRes = 0;
		
		if(!file.getOriginalFilename().equals("") && file.getSize() > 0) {
			
			try {
				String uuid = UUID.randomUUID().toString();								// uuid
				String fileEx = FileUploadUtil.getExtension(file.getOriginalFilename());// file 확장자
				
				// db에 저장할 파일의 경로와 파일의 이름 + 확장자
				String filePath = "D:\\sendbox\\commu_img\\" + uuid + "." + fileEx;
				
				// 파일 업로드
				File insertFile = new File(filePath);
				file.transferTo(insertFile);
				
				commuVO.setCommuIconNm(file.getOriginalFilename());
				commuVO.setCommuIconPath(filePath);
			
				insertCommuRes = commuMapperDao.insertCommu(commuVO);
				
			} catch (Exception e) { e.printStackTrace(); }
		}
		return insertCommuRes;
	}
	
	
	
	
	
	
	public int updateCommu(CommuVO commuVO) {
		
		int updateCommuCnt = 0;
		try {
			updateCommuCnt = commuMapperDao.updateCommu(commuVO);
		} catch (Exception e) { e.printStackTrace(); }
		return updateCommuCnt;
	}
	
	
	
	
	
	
	
	/**
	 * 전체 커뮤니티, 사원이 북마크한 커뮤니티 정보를 반환하는 메서드
	 * @param empVO
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectCommuMap(EmpVO empVO) {
		
		Map<String, Object> myCommuMap = new HashMap<String, Object>();
		
		CommuVO commuVO = null;
		
		List<CommuVO> commuList = null;
		List<CommuBKMKVO> commuBKMKList = null;
		try {
			commuList = commuMapperDao.selectListCommu(commuVO);
			commuBKMKList = commuMapperDao.selectListCommuBKMK(empVO);
		} catch (Exception e) { e.printStackTrace(); }
		
		myCommuMap.put("commuList", commuList);
		myCommuMap.put("commuBKMKList", commuBKMKList);
		
		return myCommuMap;
	}
	
	
	
	
	/**
	 * 커뮤니티의 정보를 반환하는 메서드
	 * @param commuVO
	 * @return
	 * @throws Exception
	 */
	public List<CommuVO> selectCommu(CommuVO commuVO) throws Exception{
		return commuMapperDao.selectListCommu(commuVO);
	}
	
	
	
	/**
	 * 커뮤니티의 boardList 정보들을 반환하는 메서드
	 * @param commuBoardVO
	 * @return
	 * @throws Exception
	 */
	public List<CommuBoardVO> selectListCommuPost(CommuBoardVO commuBoardVO) throws Exception{
		return commuMapperDao.selectListCommuPost(commuBoardVO);
	}
	
	
	
	
	
	/**
	 * 선택한 게시글의 정보를 반환하는 메서드
	 * @param commuBoardVO
	 * @return
	 */
	public Map<String, Object> selectCommuBoard(CommuBoardVO commuBoardVO) {
		
		Map<String, Object> commuInfoMap = null;
		try {
			commuInfoMap = new HashMap<String, Object>();
			
			// 게시글의 정보
			CommuBoardVO dbCommuBoard = commuMapperDao.selectCommuBoard(commuBoardVO);
			commuInfoMap.put("dbCommuBoard", dbCommuBoard);
			
			if(dbCommuBoard != null) {
				
				String empTitle = commuMapperDao.selectEmpTitle(dbCommuBoard.getEmpId());
				commuInfoMap.put("empTitle", empTitle);
				
				// boardFileVO List 가져오기
				CommuBoardFileVO commuBF = new CommuBoardFileVO();
				commuBF.setBoardSeq(commuBoardVO.getBoardSeq());
				
				List<CommuBoardFileVO> commuBoardFileList = commuMapperDao.selectListCommuBoardFile(commuBF);
				commuInfoMap.put("commuBoardFileList", commuBoardFileList);
				
				// repleVO List 가져오기
				CommuBoardRepleVO commuBoardRepleVO = new CommuBoardRepleVO();
				commuBoardRepleVO.setBoardSeq(commuBoardVO.getBoardSeq());
				
				List<CommuBoardRepleVO> commuBoardRepleList = commuMapperDao.selectListReple(commuBoardRepleVO);
				commuInfoMap.put("commuBoardRepleList", commuBoardRepleList);
				
				List<String> commuRepleEmpTitleList = null;
				if(commuBoardRepleList.size() > 0 && commuBoardRepleList != null) {
					commuRepleEmpTitleList = new ArrayList<String>();
					for(CommuBoardRepleVO commuReple : commuBoardRepleList) {
						String commuRepleEmpTitle = commuMapperDao.selectEmpTitle(commuReple.getEmpId());
						commuRepleEmpTitleList.add(commuRepleEmpTitle);
					}
				}
				commuInfoMap.put("commuRepleEmpTitleList", commuRepleEmpTitleList);
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return commuInfoMap;
	}
	
	
	
	
	
	
	
	
	/**
	 * 커뮤니티에 게시글을 등록 후 결과를 반환하는 메서드
	 * @param fileList
	 * @param commuBoardVO
	 * @param session
	 * @return
	 * @throws Exception 
	 */
	public int insertCommuBoard(List<MultipartFile> fileList, CommuBoardVO commuBoardVO, EmpVO dbEmp) {
		// 게시글 등록
		commuBoardVO.setEmpId(dbEmp.getEmpId());
		commuBoardVO.setEmpNm(dbEmp.getEmpNm());
		
		int insertRes = 0;			// 게시글 전체 저장결과
		int boardFileAllCnt = 0;	// 전체 파일의 수
		int boardInsertFileCnt = 0; // 저장한 파일의 수
		int commuBoardInsert = 0; 	// 게시글 작성 결과
		try {
			commuBoardInsert = commuMapperDao.insertCommuBoard(commuBoardVO);
			CommuBoardFileVO commuBoardFileVO = null;
			// 게시글 등록 성공시 실행
			if(commuBoardInsert > 0) {
				// file 등록
				if(fileList.size() > 0 && fileList != null) {
					for(MultipartFile file : fileList) {
						if(!file.getOriginalFilename().equals("") && file.getSize() > 0) {
							boardFileAllCnt++; // 파일의 전체갯수 카운트
							String fileRealName = file.getOriginalFilename(); // 파일의 진짜 이름(이름 + 확장자)
							String tempName = UUID.randomUUID().toString(); // uuid 생성 후 대입
							
							String fileEx = FileUploadUtil.getExtension(fileRealName); // file 확장자
							// db에 저장할 파일의 경로와 파일의 이름 + 확장자
							String filePath = "D:\\sendbox\\commuFile\\" + tempName + "." + fileEx;
							File insertFile = new File(filePath);
							file.transferTo(insertFile); // 파일 업로드
							commuBoardFileVO = new CommuBoardFileVO(); // 파일경로를 db에 저장
							commuBoardFileVO.setFilepath(filePath);
							commuBoardFileVO.setRealfilename(fileRealName);
							// 첨부파일정보를 DB의 commufile테이블에 저장
							int insertFileCnt = commuMapperDao.insertCommuBoardFile(commuBoardFileVO);
							if(insertFileCnt == 1) {
								boardInsertFileCnt++;
							}
						}
					}
				}
			}
		}catch(Exception e) { e.printStackTrace(); }
		// 게시글정보 저장을 성공하면서 전송한 파일갯수와 저장성공된 파일갯수가 일치할시 게시글 저장성공 처리
		if(commuBoardInsert == 1 && boardFileAllCnt == boardInsertFileCnt) {
			insertRes = 1;
		}
		return insertRes;
	}
	
	
	
	
	/**
	 * board의 현재 시퀀스 정보를 반환하는 메서드
	 * @return
	 * @throws Exception
	 */
	public int selectCurrval() {
		int currNum = 0;;
		try {
			currNum = commuMapperDao.selectCurrval();
		} catch (Exception e) { e.printStackTrace(); }
		return currNum;
	}
	
	
	
	
	
	
	
	
	
	
	/**
	 * 게시글 정보를 수정한 뒤 결과를 반환하는 메서드
	 * @param session
	 * @param commuBoardVO
	 * @param fileList
	 * @param delFileList
	 * @return
	 * @throws Exception
	 */
	public int updatePost(HttpSession session, CommuBoardVO commuBoardVO, List<MultipartFile> fileList, List<Integer> delFileList) {
		int boardFileAllCnt = 0;			// 추가한 파일의 전체 파일의 수
		int boardInsertFileCnt = 0; 		// 추가한 파일의 저장한 파일의 수
		int delCommuBoardFileAllCnt = 0;	// 삭제파일의 전체 파일의 수
		int delCommuBoardFileCnt = 0;		// 삭제파일의 삭제한 파일의 수
		EmpVO dbEmp = (EmpVO) session.getAttribute("EMP");
		commuBoardVO.setEmpId(dbEmp.getEmpId());
		int updateCommuBoard = 0;;
		try {
			updateCommuBoard = commuMapperDao.updateCommuBoard(commuBoardVO);
			// update 성공시 실행
			if(updateCommuBoard == 1) {
				// 삭제한 파일 리스트
				if(delFileList != null && delFileList.size() > 0) {
					for(Integer delFileId : delFileList) {
						delCommuBoardFileAllCnt++;
						CommuBoardFileVO commuBoardFileVO = new CommuBoardFileVO();
						commuBoardFileVO.setAttachfileSeq(delFileId);
						// 선택한 첨부파일 삭제처리 ==> 상태코드 'Y'에서 'N'으로 변경
						int updateBoardFile = commuMapperDao.updateCommuBoardFile(commuBoardFileVO);
						if(updateBoardFile == 1) {
							delCommuBoardFileCnt++;
						}
					}
				}
				// file 등록
				if(fileList.size() > 0 && fileList != null) {
					for(MultipartFile file : fileList) {
						if(!file.getOriginalFilename().equals("") && file.getSize() > 0) {
							boardFileAllCnt++; // 게시글 첨부파일 총 갯수
							String fileRealName = file.getOriginalFilename(); // 파일의 진짜 이름(이름 + 확장자)
							String tempName = UUID.randomUUID().toString(); // uuid
							String fileEx = FileUploadUtil.getExtension(fileRealName); // file 확장자
							// db에 저장할 파일의 경로와 파일의 이름 + 확장자
							String filePath = "D:\\sendbox\\commuFile\\" + tempName + "." + fileEx;
							File insertFile = new File(filePath);
							file.transferTo(insertFile); // 파일 업로드
							// 파일경로를 db에 저장
							CommuBoardFileVO commuBoardFileVO = new CommuBoardFileVO();
							commuBoardFileVO.setFilepath(filePath);
							commuBoardFileVO.setRealfilename(fileRealName);
							commuBoardFileVO.setBoardSeq(commuBoardVO.getBoardSeq());
							// 새로운 첨부파일 저장
							int insertFileCnt = commuMapperDao.insertCommuBoardFile(commuBoardFileVO);
							if(insertFileCnt == 1) {
								boardInsertFileCnt++;
							}
						}
					}
				}
			}
		} catch (Exception e) { e.printStackTrace(); }
		// 저장첨부파일의 전체갯수와 저장성공한 첨부파일 갯수가 일치하고 삭제첨부파일의 전체갯수와 삭제성공한 첨부파일 갯수가 일치하면서 게시글 수정결과가 성공일 경우 성공처리
		if((boardFileAllCnt == boardInsertFileCnt) && (delCommuBoardFileAllCnt == delCommuBoardFileCnt) && (updateCommuBoard == 1)) {
			return 1;
		}else {
			return 0;
		}
	}
	
	
	
	
	
	
	
	
	
	/**
	 * 게시글의 상태코드를 삭제상태코드로 변경한 뒤 결과를 반환하는 메서드
	 * @param session
	 * @param commuBoardVO
	 * @return
	 * @throws Exception 
	 */
	public int delUpCommuBoard(HttpSession session, CommuBoardVO commuBoardVO) {
		
		
		EmpVO dbEmp = (EmpVO) session.getAttribute("EMP");
		
		commuBoardVO.setEmpId(dbEmp.getEmpId());
		commuBoardVO.setBoardTitle("삭제된 게시글 입니다.");
		
		
		int updateCommuBoard = 0;
		try {
			updateCommuBoard = commuMapperDao.updateCommuBoard(commuBoardVO);
		} catch (Exception e) { e.printStackTrace(); }
		
		return updateCommuBoard;
	}
	
	
	
	
	
	/**
	 * 게시글의 댓글을 DB에 저장한 뒤 결과를 반환하는 메서드
	 * @param commuRepleVO
	 * @return
	 * @throws Exception
	 */
	public int insertCommuReple(CommuBoardRepleVO commuRepleVO) {
		int insertCommuRepleCnt = 0;
		try {
			insertCommuRepleCnt = commuMapperDao.insertCommuReple(commuRepleVO);
		} catch (Exception e) { e.printStackTrace(); }
		return insertCommuRepleCnt;
	}
	
	
	
	
	public int updateRepleSt(CommuBoardRepleVO commuRepleVO) {
		
		int updateCommuRepleStCnt = 0;
		try {
			updateCommuRepleStCnt = commuMapperDao.updateCommuRepleSt(commuRepleVO);
		} catch (Exception e) { e.printStackTrace(); }
		return updateCommuRepleStCnt;
	}
	
	
	
	public List<CommuBoardFileVO> selectCommuBoardFile(CommuBoardFileVO commuBoardFile) {
		List<CommuBoardFileVO> commuBoardFileList = null;
		try {
			commuBoardFileList = commuMapperDao.selectListCommuBoardFile(commuBoardFile);
		} catch (Exception e) { e.printStackTrace(); }
		return commuBoardFileList;
	}




	public CommuVO selectCommuIcon(CommuVO commuVO) {
		
		CommuVO dbCommuVO = null;
		try {
			dbCommuVO = commuMapperDao.selectCommuIcon(commuVO);
		} catch (Exception e) { e.printStackTrace(); }
		return dbCommuVO;
	}




	public int selectCommuBoardPageAllCount(CommuBoardVO commuBoardVO) throws Exception {
		return commuMapperDao.selectCommuBoardPageAllCount(commuBoardVO);
	}




	public CommuBKMKVO selectMyBookMark(CommuBKMKVO commuBkmk) throws Exception {
		return commuMapperDao.selectMyBookMarkInfo(commuBkmk);
	}




	public int insertCommuBKMK(CommuBKMKVO commuBkmk) {
		int insertCommuBKMKCnt = 0;
		try {
			insertCommuBKMKCnt = commuMapperDao.insertCommuBKMK(commuBkmk);
		} catch (Exception e) { e.printStackTrace(); }
		return insertCommuBKMKCnt;
	}




	public int deleteCommuBKMK(CommuBKMKVO commuBkmk) {
		int deleteCommuBKMKCnt = 0;
		try {
			deleteCommuBKMKCnt = commuMapperDao.deleteCommuBKMK(commuBkmk);
		} catch (Exception e) { e.printStackTrace(); }
		return deleteCommuBKMKCnt;
	}




	public JobTitleVO selectCommuBoardListEmpJobTitle(String empId) {
		JobTitleVO empJobTitleVO = null;
		try {
			empJobTitleVO = commuMapperDao.selectCommuBoardListEmpJobTitle(empId);
		} catch (Exception e) { e.printStackTrace(); }
		return empJobTitleVO;
	}




	public VotePostEmpDeptVO selectCommuBoardListEmpDeptInfo(JobTitleVO empJobTitleVO) {
		VotePostEmpDeptVO votePostEmpDeptInfoVO = null;
		try {
			votePostEmpDeptInfoVO = commuMapperDao.selectCommuBoardListEmpDeptInfo(empJobTitleVO);
		} catch (Exception e) { e.printStackTrace(); }
		return votePostEmpDeptInfoVO;
	}




	
	

	
}
