<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "dto.Product" %>
<%@ page import = "dto.ProductRepository" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">
<title>Product List</title>
</head>
<body>
	<%@ include file = "menu.jsp" %>
		<div class="jumbotron">
           <div class="container">
               <h1 class="display-3"> 상품 목록 </h1>
           </div>
        </div>
        <%
        	ProductRepository dao = ProductRepository.getInstance();
        	ArrayList<Product> listOfProducts = dao.getAllProducts();
        %>
        <div class ="container">
        	<div class ="row" align = "center">
        		<%@ include file = "dbconn.jsp"	%>
        		<%
        			PreparedStatement pstmt = null;
        			ResultSet rs = null;
        			String sql = "select * from product";
        			pstmt = conn.prepareStatement(sql);
        			rs = pstmt.executeQuery();
        			
        			while(rs.next()) {
        		%>
        		<div class = "col-md-4">
        			<img src ="./resoureces/images/<%=rs.getString("p_fileName") %>" style ="width:100px">
        			<h3><%=rs.getString("p_name")%></h3>
        			<p><%=rs.getString("p_description")%> 
        			<p><%=rs.getString("p_unitPrice")%> 원
        			<p><a href = "./product.jsp?id=<%=rs.getString("p_id")%>" class = "btn btn-primary" role="button">상세정보</a>
        		</div>
        		<%
        			}
        			
        			if(rs != null) rs.close();
        			if(pstmt != null) pstmt.close();
        			if(conn != null) conn.close();
        		%> 
        	</div>
        </div>
        
        <%@ include file = "footer.jsp" %>
</body>
</html>