<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false" %>

<html>
    <head>
        <title>Parts Page</title>

        <style type="text/css">
            .mainTable {
                width: 800px;
                margin: 10px;
                background: white;
            }
            #pagination {
                padding: 5px;
            }
            #pagination a:link { color: white; }
            #pagination a:visited { color: white; }
            #pagination a:hover { color: white; }
            #pagination a:active { color: white; }

            .addForm {
                width: 300px;
                margin: 10px;
                background: white;
            }
            h1 {
                color: white;
                background-color:#786455
            }
        </style>
    </head>

    <body style="background-color:whitesmoke">
        <div class="mainTable">
            <h1 align="center">Склад комплектующих</h1>

            <div >
                <form action="/parts">
                    <input type="text" placeholder="наименование" name="param" />
                    <input type="submit" value="Найти" />
                </form>
            </div>

            <form action="/parts">
                Показать
                <button name="param" type="submit" value="all">Все детали</button>
                <button name="param" type="submit" value="needOnly">Обязательные</button>
                <button name="param" type="submit" value="optionOnly">Опциональные</button>
            </form>

            <c:if test="${!empty listParts}">
                <table border="1" width="100%">
                    <thead style="background-color:#b39b89">
                        <tr>
                            <th width="5%">ID</th>
                            <th width="30%">Наименование</th>
                            <th width="20%">Необходимость</th>
                            <th width="15%">Количество</th>
                            <th width="15%">Изменение</th>
                            <th width="15%">Удаление</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${listParts}" var="part">
                        <tr>
                            <td align="center">${part.id}</td>
                            <td>${part.partName}</td>
                            <c:choose>
                                <c:when test = "${part.necessity}">
                                    <td align="center">да</td>
                                </c:when>
                                <c:otherwise>
                                    <td align="center">нет</td>
                                </c:otherwise>
                            </c:choose>
                            <td align="center">${part.amount}</td>
                            <td align="center"><a href="<c:url value='/edit/${part.id}'/>">Изменить</a></td>
                            <td align="center"><a href="<c:url value='/remove/${part.id}'/>">Убрать</a></td>
                        </tr>
                        </c:forEach>
                        <tr>
                            <td colspan="6" align="center">Данные о комплектации на складе</td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">Можно собрать</td>
                            <td colspan="2" align="center">${availableComputers}</td>
                            <td colspan="2" align="center">компьютеров</td>
                        </tr>
                    </tbody>
                </table>
            </c:if>
            <div align="center" id="pagination" style="background-color:#786455">
                <c:url value="/parts" var="prev">
                    <c:param name="page" value="${page-1}"/>
                </c:url>
                <c:if test="${page > 1}">
                    <a href="<c:out value="${prev}" />">Prev</a>
                </c:if>

                <c:forEach begin="1" end="${maxPages}" step="1" varStatus="i">
                    <c:choose>
                        <c:when test="${page == i.index}">
                            <span>${i.index}</span>
                        </c:when>
                        <c:otherwise>
                            <c:url value="/parts" var="url">
                                <c:param name="page" value="${i.index}"/>
                            </c:url>
                            <a href='<c:out value="${url}" />'>${i.index}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <c:url value="parts" var="next">
                    <c:param name="page" value="${page + 1}"/>
                </c:url>
                <c:if test="${page + 1 <= maxPages}">
                    <a href='<c:out value="${next}" />'>Next</a>
                </c:if>
            </div>
        </div>

        <div class="addForm">
            <c:url var="addAction" value="/parts/add"/>
            <form:form action="${addAction}" commandName="part">
                <h1 align="center">
                    <c:if test="${!empty part.partName}">
                        Изменить деталь
                    </c:if>
                    <c:if test="${empty part.partName}">
                        Добавить деталь
                    </c:if>
                </h1>
                <table border="1" width="100%">
                    <thead style="background-color:#b39b89">
                        <tr>
                            <th width="40%">Поле</th>
                            <th width="60%">Значение</th>
                        </tr>
                    </thead>
                    <c:if test="${!empty part.partName}">
                        <tr>
                            <td>
                                <form:label path="id">
                                    <spring:message text="ID"/>
                                </form:label>
                            </td>
                            <td>
                                <form:input path="id" readonly="true" size="8" disabled="true"/>
                                <%--<form:hidden path="id"/>--%>
                            </td>
                        </tr>
                    </c:if>
                    <tr>
                        <td>
                            <form:label path="partName">
                                <spring:message text="Наименование"/>
                            </form:label>
                        </td>
                        <td>
                            <form:input path="partName"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <form:label path="necessity">
                                <spring:message text="Необходимость"/>
                            </form:label>
                        </td>
                        <td>
                            <form:input path="necessity"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <form:label path="amount">
                                <spring:message text="Количество"/>
                            </form:label>
                        </td>
                        <td>
                            <form:input path="amount"/>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center">
                            <c:if test="${!empty part.partName}">
                                <input type="submit"
                                       value="<spring:message text="Изменить"/>"/>
                            </c:if>
                            <c:if test="${empty part.partName}">
                                <input type="submit"
                                       value="<spring:message text="Добавить"/>"/>
                            </c:if>
                        </td>
                    </tr>
                </table>
            </form:form>
        </div>

        <a href="../../index.jsp">Back to main menu</a>

    </body>
</html>
