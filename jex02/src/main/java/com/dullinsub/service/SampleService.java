package com.dullinsub.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dullinsub.mapper.SampleMapper;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class SampleService {
	private SampleMapper mapper;
	
	@Transactional // 하나라도 실패하면 전체 적용 안하게 해줌
	public void test(String str) {
		mapper.insert1(str);
		mapper.insert2(str);
	}
	
	public void test2(String str) {
		mapper.insert1(str);
		mapper.insert2(str);
	}
}
