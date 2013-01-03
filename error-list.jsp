<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${!empty(errors)}">
  <c:forEach var="error" items="${errors}">
    <p style="padding:0;font-size:1em;color: red;">*${error }<br/></p>
  </c:forEach>
</c:if>
