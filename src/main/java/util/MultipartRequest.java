package util;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import org.apache.tomcat.jakartaee.commons.io.IOUtils;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import jakarta.servlet.http.HttpServletRequest;

/**
 * multipart/form-data 요청을 처리하는 유틸리티 클래스다.
 * @author lee_e
 *
 */
public class MultipartRequest {
	/*
	 -----------------------------------------------------------------------------------------
	| POST add.jsp HTTP/1.1
	| Accept: ...
	| Accept-encoding: ...
	| Content-Type: multipart/form-data; boundary=----WebKitFormBoundaryCivtYSFX4A6vKt46
	|
	| ----WebKitFormBoundaryCivtYSFX4A6vKt46
	| Content-Disposition: form-data; name="title"
	|
	| 첨부파일업로드 연습
	| ----WebKitFormBoundaryCivtYSFX4A6vKt46
	| Content-Disposition: form-data; name="content"
	|
	| 첨부파일 업로드 연습입니다.
	| ----WebKitFormBoundaryCivtYSFX4A6vKt46
	| Content-Disposition: form-data; name="upfile"; filename="sample.gif"
	| Content-Type: image/gif
	| GIF871...............................D..; // sample.gif의 실제 데이터
	| ----WebKitFormBoundaryCivtYSFX4A6vKt46
	| 
	------------------------------------------------------------------------------------------
	
	분석이 완료된 정보
	parameters -> {
		KEY				VALUES
		---------------------------------------------------------------
		"title"			["업로드 연습"],
		"content"		["업로드 연습입니다."]
		"upfile"		["sample.gif"]
	}
	 */
	
	/**
	 *  분석된 요청메세지 정보를 저장하는 Map객체
	 */
	private Map<String, List<String>> parameters = new HashMap<>();
	
	/**
	 * multipart/form-data 요청을 처리하는 MultipartRequest객체를 초기화하는 생성자다.
	 * @param request 요청객체
	 * @param saveDirectory 업로드된 첨부파일을 저장할 폴더 경로
	 * @throws IOException 첨부파일 업로드 처리시 오류가 발생하면 이 예외를 던진다.
	 */
	public MultipartRequest(HttpServletRequest request, String saveDirectory) throws IOException {
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setDefaultCharset("utf-8");
		factory.setSizeThreshold(DiskFileItemFactory.DEFAULT_SIZE_THRESHOLD);
		ServletFileUpload upload = new ServletFileUpload(factory);
		Map<String, List<FileItem>> map = upload.parseParameterMap(request);
		
		Set<Entry<String, List<FileItem>>> entrySet =  map.entrySet();
		for (Entry<String, List<FileItem>> entry : entrySet) {
			String key = entry.getKey();				// 요청 파라미터명 추출
			List<String> values = new ArrayList<>();	// 요청 파라미터값 혹은 파일명을 저장하는 List객체 생성
			parameters.put(key, values);			
			
			List<FileItem> fileItems = entry.getValue();
			for (FileItem fileItem : fileItems) {
				if (fileItem.isFormField()) {					// FileItem객체가 입력필드정보를 포함하고 있는 경우
					values.add(fileItem.getString());			// 요청파라미터값을 주출해서 저장
				} else {										// FileItem객체가 업로드된 파일정보를 포함하고 있는 경우
					if (fileItem.getSize() > 0) {
						String filename = fileItem.getName();	// 업로드된 파일명을 추출함
						values.add(filename);					// 업로드된 파일명을 저장
																// 업로드된 파일을 지정된 폴더에 저장함
						IOUtils.copy(fileItem.getInputStream(), new FileOutputStream(new File(saveDirectory, filename)));		
					}
				}
			}
		}
	}
	
	/**
	 * 지정된 이름의 요청파라미터값을 반환한다.
	 * @param name 요청파라미터 이름
	 * @return 요청파라미터 값, 지정된 이름의 요청파라미터값이 없으면 null을 반환한다.
	 */
	public String getParameter(String name) {
		List<String> values = parameters.get(name);
		if (values == null) {
			return null;
		}
		if (values.isEmpty()) {
			return null;
		}
		return values.get(0);
	}
	
	/**
	 * 지정된 이름의 요청파라미터값을 배열로 반환한다.
	 * @param name 요청파라미터 이름
	 * @return 요청파라미터 값이 저장된 배열객체, 지정된 이름의 요청파라미터값이 없으면 null을 반환한다.
	 */
	public String[] getParameterValues(String name) {
		List<String> values = parameters.get(name);
		if (values == null) {
			return null;
		}
		if (values.isEmpty()) {
			return null;
		}
		String[] array = new String[values.size()];
		values.toArray(array);
		return array;
	}
	
	/**
	 * 지정된 필드명으로 업로드된 첨부파일의 이름을 반환한다.
	 * @param name 입력필드명
	 * @return 파일이름, 지정된 필드명으로 업로된 파일이 존재하지 않으면 null을 반환한다.
	 */
	public String getFilename(String name) {
		return getParameter(name);
	}
	
	/**
	 * 지정된 필드명으로 업로드된 첨부파일의 이름을 배열로 반환한다.
	 * @param name 입력필드명
	 * @return 파일이름이 저장된 배열객체, 지정된 필드명으로 업로된 파일이 존재하지 않으면 null을 반환한다.
	 */
	public String[] getFilenames(String name) {
		return getParameterValues(name);
	}
}
