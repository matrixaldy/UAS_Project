<%-- 
    Document   : katalog
    Created on : May 23, 2020, 6:48:14 PM
    Author     : matri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="jdbc.Koneksi" %>
<%@page import="java.sql.*" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="cart" scope="session" class="beans.ShoppingCart" />
<!DOCTYPE html>

<html>
<head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
    <style>
		


/*
* @subsection Shop
*/
.product {
  padding-top: 5px;
  padding-bottom: 5px;
  margin-left: auto;
  margin-right: auto;
}

.product .caption {
  margin-top: 15px;
}

.product .caption h6 {
  color: #455a64;
}

.product .caption .price + .price {
  margin-left: 15px;
}

.product.tumbnail {
  box-shadow: 0 5px 25px 0 transparent;
  transition: 0.3s linear;
  padding-top: 0;
}

.product.tumbnail img:hover {
  box-shadow: 0 5px 25px 0 rgba(0, 0, 0, 0.2);
}

.single-product span {
  display: inline-block;
}

.single-product .rating .fa-star, .single-product .rating .fa-star-o {
  font-size: 16px;
  color: #f7d4a0;
  margin-left: 2px;
}

.single-product .rating + * {
  margin-left: 15px;
}

.single-product h1.h1-variant-2 {
  margin-bottom: 20px;
}

.single-product .caption:before {
  content: '';
  height: 100%;
  display: inline-block;
  vertical-align: middle;
}

.single-product .caption span {
  display: inline-block;
  vertical-align: middle;
}

.single-product .caption .price {
  font-weight: 400;
}

.single-product .caption .price.sale {
  color: #e75854;
  font-size: 33px;
}

.single-product .caption * + .price {
  margin-left: 10.8%;
}

@media (max-width: 1199px) {
  .single-product .caption * + .price {
    margin-left: 7.8%;
  }
}

.single-product .caption * + .quantity {
  margin-left: 26px;
}

.single-product .caption .info-list {
  border-bottom: 1px solid #f3f3ed;
  border-top: 1px solid #f3f3ed;
  font-family: Montserrat, sans-serif;
  padding-top: 26px;
  padding-bottom: 26px;
  text-align: left;
}

.single-product .caption .info-list dt, .single-product .caption .info-list dd {
  display: inline-block;
  line-height: 25px;
  padding-top: 10px;
  padding-bottom: 10px;
}

.single-product .caption .info-list dt {
  letter-spacing: 0.08em;
  font-size: 12px;
  color: #a7b0b4;
  width: 35%;
  text-transform: uppercase;
}

.single-product .caption .info-list dd {
  font-size: 15px;
  color: #565452;
  width: 62.5%;
}

.single-product .caption .share span.small {
  margin-top: 9px;
}

@media (max-width: 991px) {
  .single-product .caption .share span.small {
    display: block;
    margin-bottom: 15px;
  }
}

@media (max-width: 767px) {
  .single-product .table-mobile tr {
    padding-top: 0;
  }
  .single-product .table-mobile tr:before {
    display: none;
  }
}

.price {
  display: inline-block;
  font-size: 15px;
  font-family: Montserrat, sans-serif;
  font-weight: 700;
  letter-spacing: 0.02em;
  color: #2b2f3e;
}

.price.sale {
  color: #e75854;
}

.price del {
  color: #b0bec5;
}

.quantity {
  text-align: center;
  font-family: Montserrat, sans-serif;
  font-size: 12px;
  background: #eceff1;
  padding-top: 5px;
  padding-bottom: 5px;
  width: 82px;
  height: auto;
  display: inline-block;
}

.quantity span {
  display: inline-block;
}

.quantity .num {
  width: 26px;
}

.quantity [class*='fa-'] {
  padding-top: 4px;
  width: 22px;
  padding-bottom: 4px;
  color: #b0bec5;
  cursor: pointer;
}

.quantity [class*='fa-']:hover {
  color: #455a64;
}

.float{
    position:fixed;
    width:60px;
    height:60px;
    bottom:40px;
    right:40px;
    background-color:red;
    color:#FFF;
    border-radius:50px;
    text-align:center;
    box-shadow: 2px 2px 3px #999;
    font-size: 1.2em;
}

.my-float{
    margin-top:22px;
}
	</style>
	<title></title>
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
      <%
          String ses = (String)session.getAttribute("status");
          if(ses != null && ses.equals("pegawai")) {
      %>
      <li class="nav-item">
        <a class="nav-link" href="suplier.jsp">Data Supplier</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="buyer.jsp">Data Buyer</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="barang.jsp">Data Barang</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="logout.jsp">Logout</a>
      </li>
      <%
          } else {
      %>
      <li class="nav-item">
        <a class="nav-link" href="login.jsp">Login</a>
      </li>
      <%
          }
      %>
      <li class="nav-item active">
        <a class="nav-link" href="katalog.jsp">Katalog</a>
      </li>
    </ul>
  </div>
</nav>


<div class="blank" style="padding: 10px"></div>

<main role="main" class="container-fluid">
            
<a href="cart.jsp" class="float">
    <%
            String id = request.getParameter("id");
            if(id!= null) {
                String desc = request.getParameter("desc");
                Float price = new Float(request.getParameter("price"));
                String img = request.getParameter("img");
                cart.addItem(id, desc, price.floatValue(),1,img);
            }
        %>
    <i class="fa fa-cart-plus my-float"> 
        <%=
            cart.getNumOfItems()
        %></i>
</a>
 <div class="container bootstrap snipets">
   <h1 class="text-center text-muted">Product catalog</h1>
   
   <div class="row flow-offset-1">
       
       <%
           try {
                Koneksi konek= new Koneksi();
                Connection conn = konek.bukaKoneksi();
                Statement st=conn.createStatement();
                String sql = " SELECT * FROM barang ORDER BY 'id' DESC";
                ResultSet res  = st.executeQuery(sql);
                while(res.next()) {
        %>
        <div class="col-xs-6 col-md-4">
            <form method="post">
                <input type="hidden" name="id" value="<%=res.getString("id") %>">
                <input type="hidden" name="desc" value="<%=res.getString("nama") %>">
                <input type="hidden" name="price" value="<%=res.getString("harga_jual") %>">
                <input type="hidden" name="img" value="<%=res.getString("imgUrl") %>">
                
                <div class="product tumbnail thumbnail-3"><a href="#"><img src="<%=res.getString("imgUrl") %>" alt=""></a>
                    <div class="caption">
                        <h6><a href="#"><%=res.getString("nama") %></a></h6><span class="price">Rp <fmt:formatNumber value = "<%=res.getString("harga_jual") %>" maxFractionDigits = "3"/></span>
                        <input type="submit" name="submit" value="Add">
                    </div>
                </div>
            </form>
        </div>
       <%
                }
           } catch (Exception e) {
               out.print(e);
           }
        %>
       
<!--     <div class="col-xs-6 col-md-4">
       <div class="product tumbnail thumbnail-3"><a href="#"><img src="http://static.livedemo00.template-help.com/wt_58434/images/shop-1.jpg" alt=""></a>
         <div class="caption">
           <h6><a href="#">Short Sleeve T-Shirt</a></h6><span class="price">
             <del>$24.99</del></span><span class="price sale">$12.49</span>
         </div>
       </div>
     </div>
     <div class="col-xs-6 col-md-4">
       <div class="product tumbnail thumbnail-3"><a href="#"><img src="http://static.livedemo00.template-help.com/wt_58434/images/shop-2.jpg" alt=""></a>
         <div class="caption">
           <h6><a href="#">Short Sleeve T-Shirt</a></h6><span class="price">
             <del>$24.99</del></span><span class="price sale">$12.49</span>
         </div>
       </div>
     </div>
     <div class="col-xs-6 col-md-4">
       <div class="product tumbnail thumbnail-3"><a href="#"><img src="http://static.livedemo00.template-help.com/wt_58434/images/shop-3.jpg" alt=""></a>
         <div class="caption">
           <h6><a href="#">Short Sleeve T-Shirt</a></h6><span class="price">$12.49</span>
         </div>
       </div>
     </div>
     <div class="col-xs-6 col-md-4">
       <div class="product tumbnail thumbnail-3"><a href="#"><img src="http://static.livedemo00.template-help.com/wt_58434/images/shop-4.jpg" alt=""></a>
         <div class="caption">
           <h6><a href="#">Short Sleeve T-Shirt</a></h6><span class="price">
             <del>$24.99</del></span><span class="price sale">$12.49</span>
         </div>
       </div>
     </div>
     <div class="col-xs-6 col-md-4">
       <div class="product tumbnail thumbnail-3"><a href="#"><img src="http://static.livedemo00.template-help.com/wt_58434/images/shop-5.jpg" alt=""></a>
         <div class="caption">
           <h6><a href="#">Short Sleeve T-Shirt</a></h6><span class="price">
             <del>$24.99</del></span><span class="price sale">$12.49</span>
         </div>
       </div>
     </div>
     <div class="col-xs-6 col-md-4">
       <div class="product tumbnail thumbnail-3"><a href="#"><img src="http://static.livedemo00.template-help.com/wt_58434/images/shop-6.jpg" alt=""></a>
         <div class="caption">
           <h6><a href="#">Short Sleeve T-Shirt</a></h6><span class="price">
             <del>$24.99</del></span><span class="price sale">$12.49</span>
         </div>
       </div>
     </div>
     <div class="col-xs-6 col-md-4">
       <div class="product tumbnail thumbnail-3"><a href="#"><img src="http://static.livedemo00.template-help.com/wt_58434/images/shop-7.jpg" alt=""></a>
         <div class="caption">
           <h6><a href="#">Short Sleeve T-Shirt</a></h6><span class="price">$12.49</span>
         </div>
       </div>
     </div>
     <div class="col-xs-6 col-md-4">
       <div class="product tumbnail thumbnail-3"><a href="#"><img src="http://static.livedemo00.template-help.com/wt_58434/images/shop-8.jpg" alt=""></a>
         <div class="caption">
           <h6><a href="#">Short Sleeve T-Shirt</a></h6><span class="price">
             <del>$24.99</del></span><span class="price sale">$12.49</span>
         </div>
       </div>
     </div>
     <div class="col-xs-6 col-md-4">
       <div class="product tumbnail thumbnail-3"><a href="#"><img src="http://static.livedemo00.template-help.com/wt_58434/images/shop-9.jpg" alt=""></a>
         <div class="caption">
           <h6><a href="#">Short Sleeve T-Shirt</a></h6><span class="price">
             <del>$24.99</del></span><span class="price sale">$12.49</span>
         </div>
       </div>
     </div>-->
   </div>
 </div>                    
                                
 </main>

    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script>
            
        function angka(evt){
            var charCode = (evt.which) ? evt.which : event.keyCode;
            if(charCode > 31 && (charCode < 48 || charCode > 57))
            return false;
            return true;
        }


    </script>
</body>
</html>
