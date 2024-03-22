package com.kh.da4jo.service;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import com.kh.da4jo.dao.CertDao;
import com.kh.da4jo.dao.MemberDao;

@Service
public class ScheduleService {

	@Autowired
	private CertDao certDao;
	@Autowired
	private MemberDao memberDao;
	
	@Scheduled(cron = "0 0 * * * *")
	public void clearCert() {
//		System.out.println(LocalDateTime.now());
		certDao.deleteLegacy();
		memberDao.realRealDeleteMember();
	}
	
	
}
