package kr.or.ddit.vacation.dao;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.or.ddit.emp.vo.EmpVO;
import kr.or.ddit.vacation.vo.VacatTypeVO;
import kr.or.ddit.vacation.vo.VacationVO;

@Mapper("vacationMapperDao")
public interface VacationMapperDao {
	
	List<VacationVO> selectEmpVacateInfo(VacationVO vacateVO) throws Exception;

	List<VacatTypeVO> selectVacatTypeList() throws Exception;

	Integer selectEmpJobTitleVacateDayCnt(EmpVO empVO) throws Exception;

	List<String> selectYearStrList() throws Exception;
	
	VacatTypeVO selectVacatType(VacatTypeVO vacatTypeVo) throws Exception;

	List<VacationVO> selectIsInsertVacateInfo(VacationVO vacateVO) throws Exception;

}
