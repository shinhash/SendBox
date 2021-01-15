package kr.or.ddit.business.library.dao;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.or.ddit.business.library.vo.LibEmpVO;
import kr.or.ddit.business.library.vo.LibVO;

@Mapper("libMapperDao")
public interface LibMapperDao {
	
	/**
	 * 파일 리스트를 출력하는 메서드
	 * @param libVO
	 * @return List
	 * @throws Exception
	 */
	List<LibVO> libList(LibVO libVO) throws Exception;
	
	/**
	 * 직급에 맞는 자료실 출력 메서드
	 * @param libEmpVO
	 * @return List
	 * @throws Exception
	 */
	List<LibEmpVO> libSelect(LibEmpVO libEmpVO) throws Exception;
	
	/**
	 * 파일 업로드
	 * @param libVO
	 * @return 성공 : 1, 실패 : 0
	 * @throws Exception
	 */
	int fileUpload(LibVO libVO) throws Exception;
	
	/**
	 * 파일 상태를 삭제로 변경하는 메서드
	 * @param libVO
	 * @return 성공 : 1, 실패 : 0
	 * @throws Exception
	 */
	int deleteFile(LibVO libVO) throws Exception;
	
	/**
	 * 파일 하나 검색하는 메서드
	 * @param libVO
	 * @return VO
	 * @throws Exception
	 */
	LibVO fileSelect(LibVO libVO) throws Exception;
	
	/**
	 * 폴더 업로드를 위한 메서드
	 * @param libVO
	 * @return 성공 : 1, 실패 : 0
	 * @throws Exception
	 */
	int folderUpload(LibVO libVO) throws Exception; 
	
	/**
	 * 폴더에 해당하는 파일 리스트
	 * @param libVO
	 * @return List
	 * @throws Exception
	 */
	List<LibVO> folderSearch(LibVO libVO) throws Exception;
	
	/**
	 * 파일 정보를 변경할 메서드
	 * @param libVO
	 * @return 성공 : 1, 실패 : 0
	 * @throws Exception
	 */
	int fileChange(LibVO libVO) throws Exception;

	/**
	 * 자료실에 해당하는 폴더 리스트
	 * @param libVO
	 * @return List
	 * @throws Exception
	 */
	List<LibVO> folderList(LibVO libVO) throws Exception;
	
	/**
	 * 자료실 저장공간을 반환하는 메서드
	 * @param libVO
	 * @return String
	 * @throws Exception
	 */
	String libFileSize(LibVO libVO) throws Exception;
 
	/**
	 * 자료실에 등록한 파일 리스트
	 * @param libVO
	 * @return List
	 * @throws Exception
	 */
	List<LibVO> libFileList(LibVO libVO) throws Exception;
	
	List<LibVO> fileSearchList(LibVO libVO) throws Exception;
	
}
