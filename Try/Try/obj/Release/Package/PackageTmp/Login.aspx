<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Try.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title></title>
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css"/>
    <link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-blue-grey.css"/>
    <link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Open+Sans'/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/leaflet.markercluster/1.0.5/MarkerCluster.css" />
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/leaflet.markercluster/1.0.5/MarkerCluster.Default.css" />
    <link rel="stylesheet" type="text/css" href="Scripts/ShowMap.css" />


</head>
<body>
    <div class="w3-bar w3-theme-orange w3-left-align w3-large" style="width:100%; height:100%">
    <form id="form1" runat="server">
        <div>
            <br />
            <div class="container" style="display:flex; flex-direction:column; align-items: center; height:750px">
            <img src="XDel Logo.gif" alt="Xdel Logo" style="height: 150px; width: 150px ; padding-top:4em; text-align:center" />
            <br /><br />
            <div class="box" style="margin-right: auto; margin-left: auto; vertical-align:central; border:groove; border-width:medium;max-width:500px">
            <table style="background-color:moccasin; color:black">
                <tr>
                    <td></td>
                    <td>Username</td>
                    <td><asp:TextBox runat="server" ID="Username" Text=""></asp:TextBox></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td>Password</td>
                    <td><asp:TextBox runat="server" ID="Password" Text=""></asp:TextBox></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td><a href = "http://localhost:62482/ForgetPassword" title="forgetpassword">forget password</a></td>
                    <td><asp:Button runat="server" ID="Login" OnClick="Authenticate" Text="Submit" /></td>
                    <td></td>
                </tr>
            </table>
            </div>
            <asp:HiddenField ID="HiddenError" runat="server" />   
            <div style="color: darkred">
            <script>
                var errorMessage = document.getElementById("HiddenError").value;
                document.write(errorMessage);
            </script>
                </div>
            </div>    
        </div>
    </form>
    </div>
</body>
</html>
