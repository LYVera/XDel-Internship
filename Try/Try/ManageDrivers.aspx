<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageDrivers.aspx.cs" Inherits="Try.ManageDrivers" %>

<!DOCTYPE html>

<html>
<head>
    <% Server.Execute("Include.aspx"); %>
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-blue-grey.css">
    <link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Open+Sans'>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/leaflet.markercluster/1.0.5/MarkerCluster.css" />
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/leaflet.markercluster/1.0.5/MarkerCluster.Default.css" />


    <link rel="stylesheet" type="text/css" href="Scripts/Leaflet/leaflet.css" />
    <link rel="stylesheet" href="Scripts/routing machine/leaflet-routing-machine-3.2.5/dist/leaflet-routing-machine.css" />


    <script type='text/javascript' src="Scripts/Leaflet/leaflet.js"></script>
    <script src="Scripts/routing machine/leaflet-routing-machine-3.2.5/dist/leaflet-routing-machine.js"></script>
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
    <script src="~/Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="Scripts/Leaflet/GreyScale.js" type="text/javascript"></script>
    <script type='text/javascript' src='https://cdnjs.cloudflare.com/ajax/libs/leaflet.markercluster/1.0.5/leaflet.markercluster.js'></script>


    <!--The search bar script here-->
    <script type="text/javascript" src="Scripts/SearchBar.js"></script>
    <script type="text/javascript" src="~/Scripts/Toggle.js"></script>


    <!-- Css for ShowMap -->
    <link rel="stylesheet" type="text/css" href="Scripts/ShowMap.css" />

    <title>Manage Drivers</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
</head>



<body class="w3-theme-l5">
    <form id="form1" runat="server">

        <!-- Navbar -->
        <div class="w3-top">
            <div class="w3-bar w3-theme-orange w3-left-align w3-large">
                <a class="w3-bar-item w3-button w3-hide-medium w3-hide-large w3-right w3-padding-large w3-hover-white w3-large w3-theme-orange" href="javascript:void(0);" onclick="openNav()"><i class="fa fa-bars"></i></a>
                <a href="#" class="w3-bar-item w3-button w3-padding-large w3-theme-orange">
                    <img src="XDel Logo.gif" alt="Xdel Logo" style="height: 36px; width: 36px" /></a>
                <a href="http://localhost:57238/RecommendMap/RecommendView" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white" title="Recommend"><i class="fa fa-area-chart"></i></a>
                <a href="http://localhost:62482/Show" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white" title="Show"><i class="fa fa-info-circle"></i></a>
                <a href="http://localhost:62482/Validate" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white" title="Validate"><i class="fa fa-check"></i></a>
                <a href="http://localhost:62482/Prompt" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white" title="Prompt"><i class="fa fa-bell"></i></a>
                <a href="http://localhost:62482/ManageUser" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white" title="ManageUser"><i class="fa fa-info-circle"></i></a>
                <a href="http://localhost:62482/ManageCluster" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white" title="ManageCluster"><i class="fa fa-check"></i></a>
                <a href="http://localhost:62482/ManageDrivers" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white" title="ManageDrivers"><i class="fa fa-bell"></i></a>
                <div class="w3-dropdown-hover w3-hide-small">
                    <button class="w3-button w3-padding-large" title="Notifications">
                        <i class="fa fa-battery-1"></i><span class="w3-badge w3-right w3-small w3-green">
                            <%
                                ArrayList lowBatts = new ArrayList();
                                lowBatts = (ArrayList)Session["lowBatt"];
                            %>
                            <%=lowBatts.Count %>

                        </span>
                    </button>
                    <div class="w3-dropdown-content w3-card-4 w3-bar-block" style="width: 300px; font-size: 0.45em">
                        <%
                            for (int i = 0; i < lowBatts.Count; i++)
                            {
                                Try.LukeRefL2.DriverObject lowBattDriver = (Try.LukeRefL2.DriverObject)lowBatts[i];

                        %>

                        <a href="#" class="w3-bar-item w3-button"><%=lowBattDriver.Name + " " + lowBattDriver.BattPCT + "% Battery "%>
                            <br />
                        </a>
                        <%} %>
                    </div>
                </div>

                <asp:Button runat="server" OnClick="logout" class="w3-bar-item w3-button w3-hide-small w3-right w3-padding-large w3-hover-white" Text="Logout" />

                <!--Top Right Hand Corner-->
            </div>
        </div>


        <!-- Page Container -->
        <div class="w3-container w3-content" style="max-width: 1400px; margin-top: 70px">
            <div class="w3-col m12">

                <div class="w3-row-padding">
                    <div class="w3-col m12">
                        <div class="w3-card-2 w3-round w3-white">
                            <div class="w3-container w3-padding">
                                <h3>Manage Drivers</h3>
                                <% ArrayList drivers = getDriverList();%>
                                <table>
                                    <thead>
                                        <th>Name</th>
                                        <th>Cluster</th>
                                        <th>Edit Cluster</th>
                                    </thead>
                                    <%for(int i=0; i<drivers.Count;i++)
                                        {
                                            Try.Models.Driver driver = (Try.Models.Driver)drivers[i];
                                            %>
                                    <tbody>
                                        <td><%=driver.getName()%></td>
                                        <td><%=driver.getCluster()%></td>
                                        <td><button type="button" id="driverBtn" onclick="printElement('content');return false" value="Edit">Edit Cluster</button></td>
                                    </tbody>
                                    <%} %>
                                </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
               

    </div>
    <!-- The RIGHTS Modal -->
    <div id="driverModal" class="user-modal">

      <!-- Modal content -->
      <div class="user-modal-content">
        <div class="modal-header">
          <span class="close">&times;</span>
          <h2>Edit Driver's Cluster Zone</h2>
        </div>
        <div class="modal-body">
            <asp:DropDownList ID="dropDownPostalCode" runat="server">
                <asp:ListItem Text=" Central 1" Value="C1"></asp:ListItem>
                <asp:ListItem Text=" Central 2" Value="C2"></asp:ListItem>
                <asp:ListItem Text=" Central 3" Value="C3"></asp:ListItem>
                <asp:ListItem Text=" Central 4" Value="C4"></asp:ListItem>
                <asp:ListItem Text=" Central 5" Value="C5"></asp:ListItem>
                <asp:ListItem Text=" West 1" Value="W1"></asp:ListItem>
                <asp:ListItem Text=" West 2" Value="W2"></asp:ListItem>
                <asp:ListItem Text=" West 3" Value="W3"></asp:ListItem>
                <asp:ListItem Text=" West 4" Value="W4"></asp:ListItem>
                <asp:ListItem Text=" Northwest 1" Value="NW1"></asp:ListItem>
                <asp:ListItem Text=" Northwest 2" Value="NW2"></asp:ListItem>
                <asp:ListItem Text=" Northwest 3" Value="NW3"></asp:ListItem>
                <asp:ListItem Text=" North 1" Value="N1"></asp:ListItem>
                <asp:ListItem Text=" North 2" Value="N2"></asp:ListItem>
                <asp:ListItem Text=" North 3" Value="N3"></asp:ListItem>
                <asp:ListItem Text=" Northeast 1" Value="NE1"></asp:ListItem>
                <asp:ListItem Text=" Northeast 2" Value="NE2"></asp:ListItem>
                <asp:ListItem Text=" Northeast 3" Value="NE3"></asp:ListItem>
                <asp:ListItem Text=" East 1" Value="E1"></asp:ListItem>
                <asp:ListItem Text=" East 2" Value="E2"></asp:ListItem>
                <asp:ListItem Text=" East 3" Value="E3"></asp:ListItem>
            </asp:DropDownList>
          <p></p>
        </div>
        <div class="modal-footer">
          <asp:Button ID="driverButton" OnClick="editCluster" runat="server" Text="Submit"  />
        </div>
      </div>
    </div>
     

    <script>
        // Get the modal
        var drivermodal = document.getElementById('driverModal');
        // Get the button that opens the modal
        var driverbtn = document.getElementById("driverBtn");
        // Get the <span> element that closes the modal
        var span = document.getElementsByClassName("close")[0];
        
        // When the user clicks on the button, open the modal 
        driverbtn.onclick = function () {
            drivermodal.style.display = "block";
        }
        // When the user clicks on <span> (x), close the modal
        span.onclick = function () {
            drivermodal.style.display = "none";
        }
        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function (event) {
            if (event.target == drivermodal) {
                drivermodal.style.display = "none";
            }
        }

    </script>
    </form>
</body>
</html>

