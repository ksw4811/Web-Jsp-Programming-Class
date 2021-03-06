<%@page import="java.sql.*"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "dto.Product" %>
<%@ page import = "dto.ProductRepository" %>
<%@ include file = "dbconn.jsp" %>
<%
	request.setCharacterEncoding("euc-kr");
	
	String root_path = request.getSession().getServletContext().getRealPath("/");
	String realFolder = root_path + "resoureces/images/";
	int maxSize = 5 * 1024 * 1024;
	String encType = "EUC-KR";
	
	MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	
	String productId = multi.getParameter("productId");
	String name = multi.getParameter("name");
	String unitPrice = multi.getParameter("unitPrice");
	String description = multi.getParameter("description");
	String manufacturer = multi.getParameter("manufacturer");
	String category = multi.getParameter("category");
	String unitsInStock = multi.getParameter("unitsInStock");
	String condition = multi.getParameter("unitsInStock");
	
	Integer price;
	if(unitPrice.isEmpty()){
		price = 0;	
	}
	else{
		price = Integer.valueOf(unitPrice);
	}
	
	long stock;
	if(unitPrice.isEmpty()){
		stock = 0;	
	}
	else{
		stock = Long.valueOf(unitsInStock);
	}
	
	Enumeration files = multi.getFileNames();
	String fname = (String)files.nextElement();
	String filename = multi.getFilesystemName(fname);
	
	PreparedStatement pstmt = null;
	String sql = "insert into product values(?,?,?,?,?,?,?,?,?)";
	
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, productId);
	pstmt.setString(2, name);
	pstmt.setInt(3, price);
	pstmt.setString(4, description);
	pstmt.setString(5, category);
	pstmt.setString(6, manufacturer);
	pstmt.setLong(7, stock);
	pstmt.setString(8, condition);
	pstmt.setString(9, filename);
	pstmt.executeUpdate();
	
	if(pstmt != null) pstmt.close();
	if(conn != null) conn.close();
	
	response.sendRedirect("products.jsp");
	
%>