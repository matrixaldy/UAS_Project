<%
    session.removeAttribute("status");
    session.invalidate();
    response.sendRedirect("index.jsp");
%>

