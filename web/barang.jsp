<%-- 
    Document   : index
    Created on : May 17, 2020, 11:47:23 AM
    Author     : matri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="jdbc.Koneksi" %>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<%
    try{
        Koneksi konek= new Koneksi();
        Connection conn = konek.bukaKoneksi();
        Statement st=conn.createStatement();
        String sql = " SELECT MAX(RIGHT(kode, 4)) FROM barang";
        ResultSet res  = st.executeQuery(sql);
        if(res.next()) {
            if(res.getString(1) != null) {
                res.last();
                int auto_id = res.getInt(1) + 1;
                String no = String.valueOf(auto_id);
                int NomorJual = no.length();
                for (int j = 0; j < 4 - NomorJual; j++) {
                    no = "0" + no;
                }
                request.setAttribute("KODE", "R"+no);
            } else {
                request.setAttribute("KODE", "R0001");
            }
        }
        res.close();
        st.close();
    } catch (Exception e) {
        out.print(e);
    }
    
    if(request.getParameterMap().containsKey("cmdCari") == true) {
        String nama = request.getParameter("nama");
        String dapat = request.getParameter("cmdCari");
        if(dapat.toString().equals("Cari")) {
            try{

                Koneksi konek= new Koneksi();
                Connection conn = konek.bukaKoneksi();
                Statement st=conn.createStatement();
                String sql = "SELECT * FROM barang WHERE nama='"+nama+"'";
                ResultSet res  = st.executeQuery(sql);
                if(res.next()) {
                    request.setAttribute("id", res.getString(1));
                    request.setAttribute("KODE", res.getString(2));
                    request.setAttribute("NAMA", res.getString(3));
                    request.setAttribute("DESKR", res.getString(4));
                    request.setAttribute("KAT", res.getString(5));
                    request.setAttribute("JUM", res.getString(6));
                    request.setAttribute("SAT", res.getString(7));
                    request.setAttribute("BELI", res.getString(8));
                    request.setAttribute("JUAL", res.getString(9));
                    request.setAttribute("UNT", res.getString(10));
                }
            } catch (Exception e) {
                out.print(e);
            }
        }
    }
%>
<html>
<head>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
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
      <li class="nav-item">
        <a class="nav-link" href="index.jsp">Data Supplier</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="buyer.jsp">Data Buyer</a>
      </li>
      <li class="nav-item active">
        <a class="nav-link" href="barang.jsp">Data Barang</a>
      </li>
    </ul>
  </div>
</nav>


<div class="blank" style="padding: 10px"></div>

<main role="main" class="container-fluid">
            <div class="row">
                <div class="col-lg-8">
                    <form name="formBarang" class="col-md-12" action="" method="POST">
                        <input type="hidden" name="id" value="<%=request.getAttribute("id") != null ? request.getAttribute("id") : "" %>">
                        <div class="form-group row ">
                            <label class="col-sm-2 col-form-label">Kode Barang</label>
                            <div class="col-sm-5">
                                <input readonly type="text" value="<%=request.getAttribute("KODE") != null ? request.getAttribute("KODE") : "" %>" class="form-control"  name="kode" placeholder="First">
                            </div>
                        </div>

                        <div class="form-group row ">
                            <label class="col-sm-2 col-form-label">Nama Barang</label>
                            <div class="col-sm-5">
                                <input type="text" value="<%=request.getAttribute("NAMA") != null ? request.getAttribute("NAMA") : "" %>" class="form-control"  name="nama" placeholder="Nama">
                            </div>
                            <div class="col-sm-2">
                                <input type="submit" name="cmdCari" class="btn btn-block btn-sm btn-info cari" value="Cari">
                            </div>
                        </div>

                        <div class="form-group row ">
                            <label class="col-sm-2 col-form-label">Deskripsi</label>
                            <div class="col-sm-5">
                                <textarea name="deskripsi" class="form-control"><%=request.getAttribute("DESKR") != null ? request.getAttribute("DESKR") : "" %></textarea>
                            </div>
                        </div>

                        <div class="form-group row ">
                            <label class="col-sm-2 col-form-label">Kategori</label>
                            <div class="col-sm-5">
                                <select name="kategori" class="form-control">
                                    <option selected>- Kategori -</option>
                                    <option <%=request.getAttribute("KAT") != null && request.getAttribute("KAT").equals("Minyak Goreng") ? "selected" : "" %> value="Minyak Goreng">Minyak Goreng</option>
                                    <option <%=request.getAttribute("KAT") != null && request.getAttribute("KAT").equals("Sabun Pembersih") ? "selected" : "" %> value="Sabun Pembersih">Sabun Pembersih</option>
                                    <option <%=request.getAttribute("KAT") != null && request.getAttribute("KAT").equals("Kecap") ? "selected" : "" %> value="Kecap">Kecap</option>
                                    <option <%=request.getAttribute("KAT") != null && request.getAttribute("KAT").equals("Saus") ? "selected" : "" %> value="Saus">Saus</option>
                                    <option <%=request.getAttribute("KAT") != null && request.getAttribute("KAT").equals("Cemilan") ? "selected" : "" %> value="Cemilan">Cemilan</option>
                                    <option <%=request.getAttribute("KAT") != null && request.getAttribute("KAT").equals("Teh") ? "selected" : "" %> value="Teh">Teh</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group row ">
                            <label class="col-sm-2 col-form-label">Jumlah</label>
                            <div class="col-sm-5">
                                <input onkeypress="return angka(event)" type="text" class="form-control" value="<%=request.getAttribute("JUM") != null ? request.getAttribute("JUM") : "" %>" name="jumlah" placeholder="Jumlah">
                            </div>
                        </div>

                        <div class="form-group row ">
                            <label class="col-sm-2 col-form-label">Satuan</label>
                            <div class="col-sm-5">
                                <select name="satuan" class="form-control">
                                    <option selected>- Satuan -</option>
                                    <option <%=request.getAttribute("SAT") != null && request.getAttribute("SAT").equals("KILOGRAM") ? "selected" : "" %> value="KILOGRAM">KILOGRAM</option>
                                    <option <%=request.getAttribute("SAT") != null && request.getAttribute("SAT").equals("LITER") ? "selected" : "" %> value="LITER">LITER</option>
                                    <option <%=request.getAttribute("SAT") != null && request.getAttribute("SAT").equals("MILILITER") ? "selected" : "" %> value="MILILITER">MILILITER</option>
                                    <option <%=request.getAttribute("SAT") != null && request.getAttribute("SAT").equals("GRAM") ? "selected" : "" %> value="GRAM">GRAM</option>
                                    <option <%=request.getAttribute("SAT") != null && request.getAttribute("SAT").equals("PCS") ? "selected" : "" %> value="PCS">PCS</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group row ">
                            <label class="col-sm-2 col-form-label">Harga Beli</label>
                            <div class="col-sm-5">
                                <input autocomplete="off" value="<%=request.getAttribute("BELI") != null ? request.getAttribute("BELI") : "" %>" placeholder="Harga Beli" name="harga_beli" onkeypress="return angka(event)" type="number" min="0" class="form-control" id="txt1"  onkeyup="sum();" />
                            </div>
                        </div>

                        <div class="form-group row ">
                            <label class="col-sm-2 col-form-label">Harga Jual</label>
                            <div class="col-sm-5">
                                <input autocomplete="off" value="<%=request.getAttribute("JUAL") != null ? request.getAttribute("JUAL") : "" %>" placeholder="Harga Jual" name="harga_jual" onkeypress="return angka(event)" type="number" min="0" id="txt2" class="form-control" onkeyup="sum();" />
                            </div>
                        </div>

                        <div class="form-group row ">
                            <label class="col-sm-2 col-form-label">Untung</label>
                            <div class="col-sm-5">
                                <input name="untung" value="<%=request.getAttribute("UNT") != null ? request.getAttribute("UNT") : "" %>" onkeypress="return angka(event)" type="number" min="0" placeholder="Untung" class="form-control" id="txt3" />
                            </div>
                        </div>
                            <script>
                                function sum() {
                                      var txtFirstNumberValue = document.getElementById('txt1').value;
                                      var txtSecondNumberValue = document.getElementById('txt2').value;
                                      var result = parseInt(txtSecondNumberValue) - parseInt(txtFirstNumberValue);
                                      if (!isNaN(result)) {
                                         document.getElementById('txt3').value = result;
                                      }
                                }
                            </script>
                        <div class="form-group row ">
                            <div class="col-md-9">
                                <input type="submit" class="btn btn-primary btn-md col-sm-2" value="Simpan" name="cmdSimpan">
                                &nbsp;
                                <input type="submit" class="btn btn-primary btn-md col-sm-2" value="Ubah" name="cmdSimpan">
                                &nbsp;
                                <input type="submit" class="btn btn-primary btn-md col-sm-2" value="Hapus" name="cmdSimpan">
                                &nbsp;
                                <input type="submit" class="btn btn-danger btn-md col-sm-2 reset" name="cmdReset" value="Batal">
                            </div>
                        </div>

                    </form>
                </div>
                <div class="col-lg-4">
                    UAS Matakuliah Java Web Programming
                    <br>Kelompok &nbsp;&nbsp;AB
                    <div class="row">
                        <div class="col-sm-3">
                            Dosen
                        </div>
                        <div class="col-sm-7">
                            : Ratna Kusumawardani
                        </div>
                    </div>
                    <br>Dibuat Oleh:
                    <div class="row">
                        <div class="col-sm-7">
                            1711502847 - Aldy Curniawan
                        </div>
                        <div class="col-sm-5">
                            : M & C
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-7">
                            1711502854 - M. Irving Johan R.
                        </div>
                        <div class="col-sm-5">
                            : V & C
                        </div>
                    </div>
                    <br>*Keterangan:
                    <div class="row">
                        <div class="col-sm-12">
                            M : Model<br>
                            V : View<br>
                            C : Controller
                        </div>
                    </div>
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
<%
    if(request.getParameterMap().containsKey("cmdReset") == true) {
        out.print("<meta http-equiv='refresh' content='0'>");
    }
    if(request.getParameterMap().containsKey("cmdSimpan") == true) {
        String kode = request.getParameter("kode");
        String nama = request.getParameter("nama");
        String deskripsi = request.getParameter("deskripsi");
        String kategori = request.getParameter("kategori");
        String jumlah = request.getParameter("jumlah");
        String satuan = request.getParameter("satuan");
        String beli = request.getParameter("harga_beli");
        String jual = request.getParameter("harga_jual");
        String untung = request.getParameter("untung");
        String id = request.getParameter("id");

        String dapat = request.getParameter("cmdSimpan");
        if(dapat.toString().equals("Simpan")) {
            try{
                Koneksi konek= new Koneksi();
                Connection conn = konek.bukaKoneksi();
                Statement st=conn.createStatement();
                String sql = "INSERT INTO barang(kode, nama, deskripsi, kategori, jumlah, satuan, harga_beli, harga_jual, untung)"
                        + " VALUES('"+kode+"', '"+nama+"', '"+deskripsi+"', '"+kategori+"', '"+jumlah+"', '"+satuan+"', '"+beli+"', '"+jual+"', '"+untung+"')";
//                String sql = "INSERT INTO barang(kode, nama, deskripsi, kategori, jumlah, satuan, harga_beli, harga_jual, untung)"
//                        + " VALUES('B0001', 'SHF S.H.Figuarts Kamen Rider Genm Zombie Action Gamer Level X-0', 'dsadasd', 'PVC Figure', '10', 'Box', '1320000', '1420000', '100000')";
                System.out.println(sql);
                st.executeUpdate(sql);
                out.print("<script>alert('Berhasil disimpan')</script>"
                        + "<meta http-equiv='refresh' content='0'>");
                //out.print("<a href='index.jsp'>Back</a>");
            } catch (Exception e) {
                out.print(e);
            }
        }

        if(dapat.toString().equals("Ubah")) {
            try{
                Koneksi konek= new Koneksi();
                Connection conn = konek.bukaKoneksi();
                Statement st=conn.createStatement();
                String sql = "UPDATE barang SET kode = '"+kode+"', nama = '"+nama+"', deskripsi = '"+deskripsi+"', "
                        + "kategori = '"+kategori+"', jumlah = '"+jumlah+"', satuan = '"+satuan+"', "
                        + "harga_beli = '"+beli+"', harga_jual = '"+jual+"', untung = '"+untung+"' WHERE id = '"+id+"'";
                st.executeUpdate(sql);
                out.print("<script>alert('Berhasil diubah')</script>"
                        + "<meta http-equiv='refresh' content='0'>");
            } catch (Exception e) {
                out.print(e);
            }
        }

        if(dapat.toString().equals("Hapus")) {
            try{
                Koneksi konek= new Koneksi();
                Connection conn = konek.bukaKoneksi();
                Statement st=conn.createStatement();
                String sql = "DELETE FROM barang WHERE id='"+id+"'";
                st.executeUpdate(sql);
                out.print("<script>alert('Berhasil dihapus')</script>"
                        + "<meta http-equiv='refresh' content='0'>");
            } catch (Exception e) {
                out.print(e);
            }
        }
    }

%>