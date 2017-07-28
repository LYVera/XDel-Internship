<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Show.aspx.cs" Inherits="Try.Show" %>

<!DOCTYPE html>

<html>
<head>
    <% Server.Execute("Include.aspx"); %>
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-blue-grey.css">
    <link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Open+Sans'>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

     <!-- Css for ShowMap -->
    <link rel="stylesheet" type="text/css" href="Scripts/ShowMap.css" />


    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/leaflet.markercluster/1.0.5/MarkerCluster.css" />
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/leaflet.markercluster/1.0.5/MarkerCluster.Default.css" />
    <link rel="stylesheet" href="Scripts/leaflet.extra-markers.min.css" />

    <link rel="stylesheet" type="text/css" href="Scripts/Leaflet/leaflet.css" />
    <link rel="stylesheet" href="Scripts/routing machine/leaflet-routing-machine-3.2.5/dist/leaflet-routing-machine.css" />

    
    
    <style>
            div.scroll {
            height: 500px;
            width: 180px; 
            overflow: scroll;
        }

    </style>

    <script type='text/javascript' src="Scripts/Leaflet/leaflet.js"></script>
    <script src="Scripts/routing machine/leaflet-routing-machine-3.2.5/dist/leaflet-routing-machine.js"></script>
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
    <script src="~/Scripts/jquery-1.10.2.js" type="text/javascript"></script>
    <script src="Scripts/Leaflet/GreyScale.js" type="text/javascript"></script>
    <script type='text/javascript' src='https://cdnjs.cloudflare.com/ajax/libs/leaflet.markercluster/1.0.5/leaflet.markercluster.js'></script>
    <script src="Scripts/leaflet.extra-markers.min.js"></script>
    <!--The search bar script here-->
    <script type="text/javascript" src="Scripts/SearchBar.js"></script>
    <script type="text/javascript" src="~/Scripts/Toggle.js"></script>


   

    <title>View Map</title>
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
                <a href="DashBoard" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white" title="DashBoard"><i class="fa fa-area-chart"></i></a>
                <a href="Show" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white" title="Show"><i class="fa fa-info-circle"></i></a>
                <a href="Validate" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white" title="Validate"><i class="fa fa-check"></i></a>
                <a href="Prompt" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white" title="Prompt"><i class="fa fa-bell"></i></a>
                <a href="ManageUser" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white" title="ManageUser"><i class="fa fa-user-o"></i></a>
                <a href="ManageCluster" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white" title="ManageCluster"><i class ="fa fa-hand-lizard-o"></i></a>
                <a href="ManageDrivers" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white" title="ManageDrivers"><i class="fa fa-bus"></i></a>
                <div class="w3-right">

                    <div class="w3-dropdown-hover w3-hide-small">
                        <button class="w3-button w3-padding-large" title="Notifications">
                            <i class="fa fa-battery-1"></i><span class="w3-badge w3-small w3-green">
                                <%
                                    ArrayList lowBatts = new ArrayList();
                                    lowBatts = (ArrayList)Session["lowBatt"];
                                %>
                                <%=lowBatts.Count %>

                            </span>
                        </button>
                        <div class="w3-dropdown-content w3-card-4 w3-bar-block" style="width: 300px; font-size: 0.60em">
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
                    <a href="#" class="w3-bar-item w3-button w3-padding-large"></a>

                    <asp:Button runat="server" OnClick="logout" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white w3-right w3-right-align" Text="Logout" />

                </div>

                <!--Top Right Hand Corner-->
            </div>
        </div>

                


        <!-- Navbar on small screens -->
        <div id="navDemo" class="w3-bar-block w3-theme-orange w3-hide w3-hide-large w3-hide-medium w3-large">
            <a href="DashBoard" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white" title="DashBoard"><i class="fa fa-area-chart"></i></a>
                <a href="Show" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white" title="Show"><i class="fa fa-info-circle"></i></a>
                <a href="Validate" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white" title="Validate"><i class="fa fa-check"></i></a>
                <a href="Prompt" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white" title="Prompt"><i class="fa fa-bell"></i></a>
                <a href="ManageUser" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white" title="ManageUser"><i class="fa fa-user-o"></i></a>
                <a href="ManageCluster" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white" title="ManageCluster"><i class ="fa fa-hand-lizard-o"></i></a>
                <a href="ManageDrivers" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white" title="ManageDrivers"><i class="fa fa-bus"></i></a>
        </div>

        <!-- Page Container -->
        <div class="w3-container w3-content" style="max-width: 1400px; margin-top: 70px">
            <!-- The Grid -->
            <div class="w3-row">
                <!-- Left Column -->
                <%--<div class="w3-col m2">
                    <!-- Profile -->
                    <div class="w3-card-2 w3-round w3-white">
                        
                    </div>
                    <br>

                    <!-- Accordion -->
                    <div class="w3-card-2 w3-round">
                        
                    </div>
                    <br>

                    <!-- Others -->
                    <div class="w3-card-2 w3-round w3-white w3-hide-small">
                       
                    </div>--%>
                <%--<br>--%>

                <!-- Alert Box -->
                <%--<div class="w3-container w3-display-container w3-round w3-theme-l4 w3-border w3-theme-border w3-margin-bottom w3-hide-small">
                        <span onclick="this.parentElement.style.display='none'" class="w3-button w3-theme-l3 w3-display-topright">
                            <i class="fa fa-remove"></i>
                        </span>
                        <p>
                            <strong>Hey!</strong>
                        </p>
                        <p>Tan's Battery is Low.</p>
                    </div>--%>

                <!-- End Left Column -->
            </div>

            <!-- Middle Column -->
            <div class="w3-col m10">
                <div class="w3-row-padding">
                    <div class="w3-col m12">
                        <div class="w3-card-2 w3-round w3-white">
                            <div class="w3-container w3-padding">

                                <!-- hidden field-->
                                <!-- Driver Location Hidden Field -->
                                <asp:HiddenField ID="HiddenField1" runat="server" />
                                <!-- Traffic Incident Hidden Field -->
                                <asp:HiddenField ID="HiddenField2" runat="server" />
                                <!-- Route Hidden Field -->
                                <asp:HiddenField ID="HiddenField3" runat="server" />
                                <!-- Route Hidden Field -->
                                <asp:HiddenField ID="HiddenField4" runat="server" />
                                <!-- Route Hidden Field -->
                                <asp:HiddenField ID="HiddenPostalCode" runat="server" />
                                <!-- Route Hidden Field -->
                                <asp:HiddenField ID="HiddenTrafficLayer" runat="server" />
                                <!-- Hidden Status for Postal Code Boundary -->
                                <asp:HiddenField ID="hiddenStatus" runat="server" />

                                <!-- MAP -->



                                <div class="row">
                                    <div class="divToggleButton">
                                        <asp:CheckBox ID="chkTraffic" runat="server"
                                            AutoPostBack="true" />
                                        <asp:Label ID="lblToggleTraffic"
                                            AssociatedControlID="chkTraffic" runat="server"
                                            ToolTip="Toggle between Traffic Condition" />
                                    </div>

                                    <div class="divToggleRoute">
                                        <asp:CheckBox ID="toggleRoute" runat="server"
                                            AutoPostBack="true" />
                                        <asp:Label ID="lblToggleRoute"
                                            AssociatedControlID="toggleRoute" runat="server"
                                            ToolTip="Toggle between Traffic Condition" />
                                    </div>     
                                    
                                    

                                    

                                    <!--<p contenteditable="true" class="w3-border w3-padding">-->
                                  
                                </div>

                                <br />

                                <p />

                                <div id="map" style="height: 500px; border: 1px solid #AAA;">

                                    <script>
                                        //markers
                                        var trafficMarker = L.ExtraMarkers.icon({
                                            icon: 'fa-warning',
                                            markerColor: 'red',
                                            shape: 'star',
                                            prefix: 'fa'
                                        });

                                        var humanMarker = L.ExtraMarkers.icon({
                                            icon: 'fa-user-circle',
                                            markerColor: 'blue',
                                            shape: 'circle',
                                            prefix: 'fa',
                                        });

                                        //map
                                        var osmLink = '<a href="http://openstreetmap.org">OpenStreetMap</a>',
                                            thunLink = '<a href="http://thunderforest.com/">Thunderforest</a>';

                                        var osmUrl = 'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                                            osmAttrib = '&copy; ' + osmLink + ' Contributors',
                                            landUrl = 'http://{s}.tile.thunderforest.com/landscape/{z}/{x}/{y}.png',
                                            thunAttrib = '&copy; ' + osmLink + ' Contributors & ' + thunLink;

                                        var osmMap = L.tileLayer(osmUrl, { attribution: osmAttrib }),
                                            landMap = L.tileLayer.grayscale(landUrl, { attribution: thunAttrib });

                                        var map = L.map('map', {
                                            layers: [osmMap] // only add one!
                                        })
                                            .setView([1.3521, 103.8198], 11);

                                        var baseLayers = {
                                            "Colour Map": osmMap,
                                            "GrayScale Map": landMap
                                        };
 
                                        var postalCodeBoundaryLayer = new L.LayerGroup();
                                        var popUpDetailsLayer = new L.LayerGroup();
                                        var overlays = {
                                            "Postal Code Boundary": postalCodeBoundaryLayer,
                                            "pop up details": popUpDetailsLayer
                                        };

                                        
                                        <%
                                            if (checkPostalCodeBoundaryStatus())
                                            {
                                        %>
                                            postalCodeBoundaryLayer.addTo(map);
                                            document.getElementById("hiddenStatus").Value = "false";
                                        <%
                                            }
                                        %>

                                        

                                        // Layers 
                                        L.control.layers(baseLayers, overlays).addTo(map);
                                            
                                        <%ArrayList polygons = GetPolygons(); %>
                                            <%ArrayList polygonClicked = new ArrayList();%>
                                        var polygonList = [];
                                            <%foreach (Try.Models.PolygonO polygon in polygons)
                                        {
                                            if (polygon != null)
                                            {
                                                %>

                                            <%
                                            %>
                                            var poly = L.polygon([<%=polygon.getCoordinates()%>]).addTo(postalCodeBoundaryLayer);
                                                    <%
                                                    int id = polygon.id;
                                                    String color = getColor(id);
                                                    String cluster = getClusterId(id);
                                                    
                                                    
                                                    %>
                                                    poly.setStyle({ fillColor: '<%=color%>', color: '<%=color%>' });


                                                    polygonList[<%=id%>] = poly;
                                                    $(document).ready(function () {
                                                        polygonList[<%=id%>].on('click', function (e) {
                                                            document.getElementById("HiddenId").value = "<%=id%>";
                                                            document.getElementById("polygonclick").click();
                                                            e.preventDefault();
                                                        });
                                                    });
                                              <%}
                                            }%>

                                                    <%ArrayList clusterDetails = getClusterDetails();%>
                                                    <%
                                                        for(int i=0; i < clusterDetails.Count; i++)
                                                        {
                                                            Try.Models.ClusterDetails clusterDetail = (Try.Models.ClusterDetails)clusterDetails[i];
                                                            int value = clusterDetail.newJob + clusterDetail.delJob + clusterDetail.puJob;
                                                        %>
                                                            var popup = L.popup()
                                                                .setLatLng([<%=clusterDetail.lat%>, <%=clusterDetail.lng%>])
                                                                    .setContent("<%=clusterDetail.id%>:<%=value%>", { className: 'polygonToolTip', permanent: true, direction: "center", opacity: 6 })
                                                                .addTo(popUpDetailsLayer);
                                                        <%
                                                        }
                                                        %>

                                                    <% ArrayList posterCodeDetails = getPostalJobs();%>
                                                    // driver current location marker 
                                                    var allDriverLoc = document.getElementById("HiddenField1").value.split("^");
                                                    if (allDriverLoc[0] != "") {
                                                        var oneDriverLoc = allDriverLoc[0].split("*");

                                                        for (i = 0; i < allDriverLoc.length; i++) {
                                                            if (allDriverLoc[i].length > 0) {
                                                                var oneDriverLoc = allDriverLoc[i].split("*");
                                                                marker = new L.marker([parseFloat(oneDriverLoc[1]), parseFloat(oneDriverLoc[2])], { icon: humanMarker })
                                                            .bindPopup(oneDriverLoc[0]).openPopup()
                                                            //layers code beneath
                                                            //.addTo(driverLocationLayer)
                                                            .addTo(map)
                                                            }

                                                }
                                            }

                                            //LTA incidents
                                            var allLTAIncidents = document.getElementById("HiddenField2").value.split("^");

                                            if (allLTAIncidents[0] != "") {
                                                for (i = 0; i < allLTAIncidents.length; i++) {
                                                    if (allLTAIncidents[i].length > 0) {
                                                        var oneLTAIncidents = allLTAIncidents[i].split("*");
                                            marker = new L.marker([parseFloat(oneLTAIncidents[1]), parseFloat(oneLTAIncidents[2])], { icon: trafficMarker })
                                                            .bindPopup(oneLTAIncidents[0]).openPopup()
                                                            .addTo(map)
                                                    //trafficLayer.addLayer(marker);
                                                    }
                                                    

                                                }
                                            }




                                            // Route 
                                            var allDriver = document.getElementById("HiddenField3").value.split("$");
                                            for (j = 0; j < allDriver.length; j++) {
                                                var test = []

                                                if (allDriver[j].length > 0) {
                                                    var allDriverRoute = allDriver[j].split("^");
                                                    for (i = 0; i < allDriverRoute.length; i++) {
                                                        if (allDriverRoute[i].length > 0) {
                                                            var oneLocation = allDriverRoute[i].split("*");
                                                            //var oneNextLocation = allDriverRoute[i + 1].split("*");
                                                            if (oneLocation.length > 0) {
                                                                test[i] = L.latLng(parseFloat(oneLocation[3]), parseFloat(oneLocation[4]))
                                                            }
                                                        }
                                                    }
                                                    route = L.Routing.control({
                                                        createMarker: function () { return null; },
                                                        draggableWaypoints: false,
                                                        waypoints: test
                                                    }).addTo(map).hide();
                                                }
                                            }

                                            var allDriver = document.getElementById("HiddenField3").value.split("$");

                                            for (j = 0; j < allDriver.length; j++) {
                                                if (allDriver[j].length > 0) {
                                                    var allDriverRoute = allDriver[j].split("^");
                                        var count = 1;
                                                    for (i = 0; i < allDriverRoute.length; i++) {

                                                        var pickUpMarker = L.ExtraMarkers.icon({
                                                            icon: 'fa-number',
                                                            number: count,
                                                            markerColor: 'orange',
                                                            iconColor: 'black'
                                                        });
                                                        var deliveryMarker = L.ExtraMarkers.icon({
                                                            icon: 'fa-number',
                                                            number: count,
                                                            markerColor: 'green',
                                                            iconColor: 'black'
                                                        });


                                                        if (allDriverRoute[i].length > 0) {
                                                            var oneLocation = allDriverRoute[i].split("*");
                                                            if (oneLocation.length > 0) {
                                                                if (oneLocation[7] == "DL") {
                                                                    marker = new L.Marker([parseFloat(oneLocation[3]), parseFloat(oneLocation[4])], { icon: deliveryMarker })
                                                                        .bindPopup(oneLocation[8] + "<br>" + oneLocation[1] + "<br>" + oneLocation[2] + "<br>" + oneLocation[0] + "<br>" + oneLocation[7]).openPopup()
                                                                        .addTo(map)
                                                                } else {
                                                                    marker = new L.Marker([parseFloat(oneLocation[3]), parseFloat(oneLocation[4])], { icon: pickUpMarker })
                                                                        .bindPopup(oneLocation[8] + "<br>" + oneLocation[1] + "<br>" + oneLocation[2] + "<br>" + oneLocation[0] + "<br>" + oneLocation[7]).openPopup()
                                                                        .addTo(map)
                                                                }

                                                            }
                                                        }
                                                        count++;
                                                    }
                                                }
                                            }
                                            
                                    </script>

                                    <asp:Button runat="server" ID="polygonclick" Text="" Style="display: none;" OnClick="polygon_Click" />
                                    <asp:HiddenField ID="HiddenId" runat="server" />

                                </div>


                                <p />

                            </div>
                        </div>
                    </div>
                </div>

                <!--Container-->
                <div class="w3-container w3-card-2 w3-white w3-round w3-margin">
                </div>

                <!-- End Middle Column -->
            </div>
            <!-- Right Column -->


            <script>
                                            function openTabs(tabName) {
                                            var i;
                                            var x = document.getElementsByClassName("tab");
                                            for (i = 0; i < x.length; i++) {
                                                x[i].style.display = "none";
                                            }
                                            document.getElementById(tabName).style.display = "block";
                                        }
            </script>




            <div class="w3-col m2">
                <div class="w3-card-2 w3-round w3-white w3-center">
                    <div class="w3-container">

                        <button class="w3-bar-item w3-button w3-orange w3-section w3-third btnFont" style="font-size:small" onclick="openTabs('SearchTab');return false">Search</button>
                        <button class="w3-bar-item w3-button w3-orange w3-section w3-third btnFont" style="font-size:small" onclick="openTabs('routeDetails');return false">Route</button>
                        <button class="w3-bar-item w3-button w3-orange w3-section w3-third btnFont" style="font-size:small" onclick="openTabs('postalDetails');return false">Zone</button>


                        <div id="SearchTab" class="w3-container tab">
                            <div class="scroll">
                            <div id="search">
                                <strong>Driver List</strong>
                                <input type="text" name="" id="filter" placeholder="Search driver" size="15">
                                    <asp:Button ID="selectAll" OnClick="selectAll_Click" runat="server" class="w3-button w2-block w3-green w2-section" title="SelectAll" style="width:40%; font-size:small" Text="All"></asp:Button>
                                    <asp:Button ID="uncheckAll" OnClick="uncheckAll_Click" runat="server" class="w3-button w2-block w3-red w2-section" title="ClearAll" style="width:40%; font-size:small" Text="Clear"></asp:Button>
                                <p />
                                <!--filter table for searching drivers-->
                                

                                    <table id="UserGridView" class="tableC">

                                        <tr>
                                            <td style="text-align: left; padding-left: 5px;">
                                                <asp:CheckBoxList
                                                    ID="CheckBoxList1"
                                                    AutoPostBack="True"
                                                    OnSelectedIndexChanged="CheckBoxList_Click"
                                                    runat="server">
                                                </asp:CheckBoxList>
                                            </td>
                                        </tr>

                                    </table>
                                </div>
                            </div>
                        </div>
                        
                        <div id="postalDetails" class="w3-container tab" style="display: none">
                            <div class="scroll">
                            <!— Button —>
                                    <asp:DropDownList ID="Grouping" runat="server" Width="75px"></asp:DropDownList>
                                    <asp:HiddenField ID="hiddenArray" runat="server" />
                                    <asp:Button ID="Button1" runat="server" OnClick="Color_Click" Text="Submit" />
                            <h3>Zone Details</h3>
                                <table class="tableC">
                                    <thead>
                                        <th>ID</th>
                                        <th>NJ</th>
                                        <th>PIP</th>
                                        <th>DIP</th>
                                    </thead>
                                    <tbody>
                                            <%
                                                for (int i = 0; i < clusterDetails.Count; i++)
                                                {
                                                    Try.Models.ClusterDetails clusterDetail = (Try.Models.ClusterDetails)clusterDetails[i];


                                            %>
                                        <tr>

                                            <td><%=clusterDetail.id%></td>
                                            <td><%=clusterDetail.newJob%></td>
                                            <td><%=clusterDetail.puJob%></td>
                                            <td><%=clusterDetail.delJob%></td>
                                        </tr>
                                        <%}%>
                                    </tbody>
                                </table>

                                <%ArrayList postaljobs = getPostalJobs();%>
                                <br /><br />
                                <table class="tableC">
                                    <thead>
                                        <tr>
                                        <th>Zone</th>
                                        <th>Dis</th>
                                        <th>NJ</th>
                                        <th>PIP</th>
                                        <th>DIP</th>
                                        </tr>
                                    </thead>
                                    <% foreach(Try.Models.PostalJob postaljob in postaljobs) { %>
                                        <tr>
                                            <td><%=postaljob.getZone() %></td>
                                            <td><%=postaljob.getDistrict()%></td>
                                            <td><%=postaljob.getNewJob() %></td>
                                            <td><%=postaljob.getPIP() %></td>
                                            <td><%=postaljob.getDIP() %></td>
                                        </tr>
                                    <%} %>
                                </table>
                            </div>
                        </div>

                        <div id="routeDetails" class="w3-container tab" style="display: none">
                            

                            <div class="scroll">
                                <table class="tableC">

                                    <%

                                        var allDriver = HiddenField3.Value.Split('$');
                                        for (int j = 0; j < allDriver.Length; j++)
                                        {


                                            if (allDriver[j].Length > 0)
                                            {
                                                var allDriverRoute = allDriver[j].Split('^');
                                                var count = 1;
                                    %>

                                    <tr>
                                        <td class="align-center">
                                            <%
                                                var forName = allDriverRoute[0].Split('*');

                                            %>
                                            <b />
                                            <span style="background-color: yellow;"><%=forName[8].ToUpper() %></span>

                                        </td>


                                    </tr>
                                    <%

                                        for (int i = 0; i < allDriverRoute.Length; i++)
                                        {



                                            if (allDriverRoute[i].Length > 0)
                                            {
                                                var oneLocation = allDriverRoute[i].Split('*');
                                    %>


                                    <tr>
                                        <td>
                                            <b><%= i+1 + ". "%></b>



                                            <%=oneLocation[2] + " " + oneLocation[0] %>

                                            <br />
                                            <b />
                                            <%=oneLocation[5] + " - " + oneLocation[6] %>
                                        </td>

                                    </tr>

                                    <%--<tr>
                                                                <td>
                                                                     
                                                                </td>
                                                               
                                                            </tr>--%>

                                    <% 

                                                    }

                                                }

                                            }
                                        }



                                    %>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>




            <!-- End Right Column -->




            <!-- End Grid -->


            <!-- End Page Container -->
        </div>
        <br>

        <!-- Footer -->
        <footer class="w3-container w3-theme-orange w3-padding-16">
            <h5>Xdel RSVP</h5>
        </footer>

        <script>
                                                // Accordion
                                                function myFunction(id) {
                                                    var x = document.getElementById(id);
                                                    if (x.className.indexOf("w3-show") == -1) {
                                                        x.className += " w3-show";
                                                        x.previousElementSibling.className += " w3-theme-d1";
                                                    } else {
                                                        x.className = x.className.replace("w3-show", "");
                                                        x.previousElementSibling.className =
                                                            x.previousElementSibling.className.replace(" w3-theme-d1", "");
                                                    }
                                                }

                                                // Used to toggle the menu on smaller screens when clicking on the menu button
                                                function openNav() {
                                                    var x = document.getElementById("navDemo");
                                                    if (x.className.indexOf("w3-show") == -1) {
                                                        x.className += " w3-show";
                                                    } else {
                                                        x.className = x.className.replace(" w3-show", "");
                                                    }
                                                }
        </script>
    </form>
</body>
</html>
