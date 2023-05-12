<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
//파일 업로드를 위한 디렉토리 설정
//윈도우즈는 c:\\
String upload_path = "C:\\upload";

//파일 업로드 최대 사이즈 
int size=10*1024*1024; //(10MB)
String name="";
String subject="";
String filename="", filename2="";
int filesize=0, filesize2=0;

try{
	MultipartRequest multi = new MultipartRequest(request, upload_path, size, "utf-8",
			new DefaultFileRenamePolicy());
	//MultipartRequest: request를 확장한 객체
	//MultipartRequest(request, "업로드 디렉토리", 제한용량, "인코딩방식", 파일명 중복방지처리옵션)
	
	name = multi.getParameter("name"); 
	subject = multi.getParameter("subject");
	Enumeration files = multi.getFileNames();
	String file1 = (String)files.nextElement(); //클라이언트측이 보내온 파일이름
	String file2 = (String)files.nextElement();
	
	filename = multi.getFilesystemName(file1); //서버에 업로드될 파일이름
	File f1 = multi.getFile(file1); //파일의 정보를 참조
	filesize = (int)f1.length();
	
	filename2 = multi.getFilesystemName(file2);
	File f2 = multi.getFile(file2);
	filesize2 = (int)f2.length();
	
	//이 경우 uploadpath에 파일이 자동으로 생성되고 
	//이름 중복시에는 defaultFileRenamePolicy를 따름.
	
} catch(Exception e){
	e.printStackTrace();
}
%>

이름 : <%=name%><br>
제목 : <%=subject %><br>
파일1 이름: <%=filename%><br>
파일1 크기: <%=filesize%><br>
파일2 이름: <%=filename2%><br>
파일2 크기: <%=filesize2%><br>



</body>
</html>