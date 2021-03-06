package kr.or.ddit.vacation.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.or.ddit.emp.vo.EmpVO;
import kr.or.ddit.vacation.dao.VacationMapperDao;
import kr.or.ddit.vacation.vo.VacatTypeVO;
import kr.or.ddit.vacation.vo.VacationVO;

@Service("vacationService")
public class VacationService {

	
	@Resource(name = "vacationMapperDao")
	private VacationMapperDao vacationMapperDao;
	
	
	
	public List<VacationVO> selectEmpVacateInfo(VacationVO vacateVO){
		
		List<VacationVO> empVacateList = null;
		try {
			empVacateList = vacationMapperDao.selectEmpVacateInfo(vacateVO);
		} catch (Exception e) { e.printStackTrace(); }
		return empVacateList;
	}



	public List<VacatTypeVO> selectVacatTypeList() {
		List<VacatTypeVO> vacatTypeList = null;
		try {
			vacatTypeList = vacationMapperDao.selectVacatTypeList();
		} catch (Exception e) { e.printStackTrace(); }
		return vacatTypeList;
	}






	public int selectEmpJobTitleVacateDayCnt(EmpVO empVO) {
		Integer empVacateJobTitleDayCnt = 0;
		try {
			empVacateJobTitleDayCnt = vacationMapperDao.selectEmpJobTitleVacateDayCnt(empVO);
			if(empVacateJobTitleDayCnt == null) {
				empVacateJobTitleDayCnt = 0;
			}
		} catch (Exception e) { e.printStackTrace(); }
		return empVacateJobTitleDayCnt;
	}



	public List<String> selectYearStrList() {
		List<String> yearStrList = null;
		try {
			yearStrList = vacationMapperDao.selectYearStrList();
		} catch (Exception e) { e.printStackTrace(); }
		return yearStrList;
	}



	public List<VacationVO> selectIsInsertVacateInfo(VacationVO vacateVO) {
		List<VacationVO> isEmpVacateInfoList = null;
		try {
			isEmpVacateInfoList = vacationMapperDao.selectIsInsertVacateInfo(vacateVO);
		} catch (Exception e) { e.printStackTrace(); }
		return isEmpVacateInfoList;
	}



}
