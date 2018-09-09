<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
    <head>
        <title>Main menu</title>
        <style type="text/css">
            .mainMenu {
                width: 200px;
                margin: 10px;
                background: white;
            }
            #top {
                color: white;
                background-color:#786455
            }

        </style>
    </head>

    <body style="background-color:whitesmoke">
        <div class="mainMenu">
            <h1 id=top align="center">Parts List</h1>
            <h1 align="center"><a href="<c:url value="/parts"/>">Начать</a></h1>
            <br/>
        </div>
    </body>
</html>