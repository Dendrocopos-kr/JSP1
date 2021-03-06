<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="kr.co.dendrocopos.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>


<%
	String url = "jdbc:oracle:thin:@localhost:1521:orcl";
String userName = "hr";
String password = "koreait2020";
Connection conn = null;
PreparedStatement ps = null;
ResultSet rs = null;

Class.forName("oracle.jdbc.driver.OracleDriver");

String sql = "SELECT * FROM countries";

List<CountriesVO> list = new ArrayList<CountriesVO>();

try {
	conn = DriverManager.getConnection(url, userName, password);
	ps = conn.prepareStatement(sql);
	rs = ps.executeQuery();

	while (rs.next()) {
		String country_id = rs.getString("country_id");
		String country_name = rs.getString("country_name");
		int region_id = rs.getInt("region_id");
		CountriesVO vo = new CountriesVO();

		vo.setCountry_id(country_id);
		vo.setCountry_name(country_name);
		vo.setRegion_id(region_id);

		list.add(vo);
	}

} catch (Exception e) {

} finally {
	try {
		rs.close();
		ps.close();
		conn.close();
	} catch (Exception e) {
	}
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
table {
	margin: 0 auto;
	border-collapse: collapse;
	border: 1px black solid
}
table caption{
	font-size: 2em;
	font-weight: bold;
}

td, th {
	border: 1px black solid;
	text-align: center;
	padding: 5px;
}
</style>
<body>
	<div>
		<table>
			<caption>
				나라정보
			</caption>
			<tr>
				<th>country_id</th>
				<th>나라명</th>
				<th>지역 ID</th>
			</tr>
			<%
				for (CountriesVO vo : list) {
			%>
			<tr>
				<td><%=vo.getCountry_id()%></td>
				<td><%=vo.getCountry_name()%></td>
				<td><%=vo.getRegion_id()%></td>
			</tr>
			<%
				}
			%>
		</table>
	</div>
</body>
</html>