package com.dullinsub.config;

import javax.servlet.Filter;
import javax.servlet.MultipartConfigElement;
import javax.servlet.ServletRegistration.Dynamic;

import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;

public class WebConfig extends AbstractAnnotationConfigDispatcherServletInitializer{

	@Override
	protected Class<?>[] getRootConfigClasses() { // root-context 대체
		// TODO Auto-generated method stub
		return new Class[] {RootConfig.class, SecurityConfig.class};
	}

	@Override
	protected Class<?>[] getServletConfigClasses() { // servlet-context 대체
		// TODO Auto-generated method stub
		return new Class[] {ServletConfig.class};
	}

	@Override
	protected String[] getServletMappings() { // url-pattern 관련
		// TODO Auto-generated method stub
		return new String[] {"/"};
	}


	@Override
	protected void customizeRegistration(Dynamic registration) {
		// TODO Auto-generated method stub
		MultipartConfigElement element = 
				new MultipartConfigElement("c:/upload", 1024 * 1024 * 2 * 10, 1024 * 1024 * 4 * 10, 1024 * 1024 * 2 * 10);
		registration.setMultipartConfig(element);
	}
	

}
