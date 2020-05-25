<%-- 
    Document   : login
    Created on : May 25, 2020, 12:32:25 AM
    Author     : matri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

        <title>Login</title>
    </head>
    <body>
        <nav class="navbar navbar-expand-md navbar-dark bg-primary">
            <a class="navbar-brand" href="#">UAS | </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
              <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
              <ul class="navbar-nav">
                <li class="nav-item active">
                  <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="katalog.jsp">Katalog</a>
                </li>
              </ul>
            </div>
          </nav>
        
            <div class="blank" style="padding: 10px"></div>

            <main role="main" class="container-fluid">
                <div class="row">
                    <div class="col-lg-8">
                        <form class="col-md-12" action="validate" method="POST">
                            <div class="form-group row ">
                                <label class="col-sm-2 col-form-label">Username</label>
                                <div class="col-sm-5">
                                    <input type="text" class="form-control" name="user" placeholder="Username">
                                </div>
                            </div>
                            <div class="form-group row ">
                                <label class="col-sm-2 col-form-label">Password</label>
                                <div class="col-sm-5">
                                    <input type="password" class="form-control"  name="pass" placeholder="Password">
                                </div>
                            </div>
                            <div class="form-group row ">
                                <div class="col-md-9">
                                    <input type="submit" class="btn btn-primary btn-md col-sm-2" value="Login" name="btnLogin">
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </main>
    </body>
</html>
