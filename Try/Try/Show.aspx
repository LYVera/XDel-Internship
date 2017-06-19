<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Show.aspx.cs" Inherits="Try.Show" %>

<!DOCTYPE html>

<html>
<head>

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



    <title>View Map</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        html, body, h1, h2, h3, h4, h5 {
            font-family: "Open Sans", sans-serif
        }

        .w3-theme-orange {
            color: #f1f1f1 !important;
            background-color: #ff9800 !important;
        }

        .tableC {
            font-family: Arial,Verdana,sans-serif;
            font-size: 0.75em;
        }

        table {
            border-collapse: collapse;
            width: 100%;
        }

        th, td {
            text-align: left;
            padding: 8px;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2
        }

        th {
            background-color: #FFA500;
            color: white;
        }


    </style>


</head>



<body class="w3-theme-l5">
    <form id="form1" runat="server">

        <!--TRYYYYY function-->




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
                    <div class="w3-dropdown-content w3-card-4 w3-bar-block" style="width: 300px;  font-size: 0.45em">
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

                <button onclick="myToggle()" class="w3-bar-item w3-button w3-hide-small w3-right w3-padding-large w3-hover-white">Toggle Search</button>

                <!--Top Right Hand Corner-->
            </div>
        </div>

        <!-- Navbar on small screens -->
        <div id="navDemo" class="w3-bar-block w3-theme-orange w3-hide w3-hide-large w3-hide-medium w3-large">
            <a href="#" class="w3-bar-item w3-button w3-padding-large">Show Map</a>
            <a href="#" class="w3-bar-item w3-button w3-padding-large">View Map</a>
            <a href="#" class="w3-bar-item w3-button w3-padding-large">Prompt</a>
            <a href="#" class="w3-bar-item w3-button w3-padding-large">Recommend Map</a>
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
                                    <asp:HiddenField ID="HiddenPostalCode" runat="server" />
                                    <!-- Route Hidden Field -->
                                    <asp:HiddenField ID="HiddenTrafficLayer" runat="server" />

                                    <!-- MAP -->
                                    
                                    <div class="btn-group">
                                      <asp:Button ID="submitRoute" runat="server" OnClick="Submit_Click" Text="Courier Route" />
                                      <asp:Button ID="trafficCondi" runat="server" OnClick="getTrafficConditions" Text="Traffic Conditions" />
                                      
                                    </div>
                                    <p />

                                    <%--<asp:Button ID="test" OnClick="getTrafficConditions" runat="server" class="w3-button w3-block w3-red w3-section" title="Test" Text="Test"></asp:Button>--%>
                                    <!--<p contenteditable="true" class="w3-border w3-padding">-->
                                    <div id="map" style="height: 500px; border: 1px solid #AAA;">

                                        <script>
                                            //marker 


                                            //var osmLink = '<a href="http://openstreetmap.org">OpenStreetMap</a>',
                                            //    thunLink = '<a href="http://thunderforest.com/">Thunderforest</a>';

                                            //var osmUrl = 'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                                            //    osmAttrib = '&copy; ' + osmLink + ' Contributors',
                                            //    landUrl = 'http://{s}.tile.thunderforest.com/landscape/{z}/{x}/{y}.png',
                                            //    thunAttrib = '&copy; ' + osmLink + ' Contributors & ' + thunLink;

                                            //var osmMap = L.tileLayer(osmUrl, { attribution: osmAttrib }),
                                            //    landMap = L.tileLayer.grayscale(landUrl, { attribution: thunAttrib });

                                            //var map = L.map('map', {
                                            //    layers: [osmMap] // only add one!
                                            //})
                                            //    .setView([1.3521, 103.8198], 11);

                                            //var baseLayers = {
                                            //    "Colour Map": osmMap,
                                            //    "GrayScale Map": landMap
                                            //};

                                            //var trafficLayer = new L.LayerGroup();   
                                            //var postalCodeBoundaryLayer = new L.LayerGroup();
                                            //var driverRoute = new L.LayerGroup();
                                            //var overlays = {
                                            //    "Traffic Condition": trafficLayer,
                                            //    "Postal Code Boundary": postalCodeBoundaryLayer,
                                            //    "Driver Route": driverRoute
                                            //};


                                            //// Layers 
                                            //L.control.layers(baseLayers, overlays).addTo(map);
                                            //if (document.getElementById("HiddenPostalCode").value == "1") {
                                            //    postalCodeBoundaryLayer.addTo(map);
                                            //}
                                            //if (document.getElementById("HiddenTrafficLayer").value == "1") {
                                            //    trafficLayer.addTo(map);
                                            //}
                                            //if (document.getElementById("HiddenTrafficLayer").value == "1") {
                                            //    driverRoute.addTo(map);
                                            //}


                                            //Map
                                            var map = L.map('map', { center: [1.3521, 103.8198], minZoom: 2, zoom: 12 });
                                            L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                                                attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>',
                                                subdomains: ['a', 'b', 'c']
                                            }).addTo(map);


                                                <%--<%Try.Models.PolygonO[] polygons1 = getPolygon(); %>                         
                                                var polygonList = [];
                                                <%for (int i = 1; i < 84; i++) {%>
                                                var poly = L.polygon([<%=polygons1[i].Coordinates%>]).addTo(postalCodeBoundaryLayer);
                                                
                                                poly.setStyle({ fillColor: '<%=polygons1[i].Color%>', color: '<%=polygons1[i].Color%>' });
                                                polygonList[<%=i%>] = poly;
                                                
                                                $(document).ready(function () {
                                                    polygonList[<%=i%>].on('click', function (e) {                                                      
                                                    <%if (polygons1[i].Color == "#FFFFFF") {%>
                                                    polygonList[<%=i%>].setStyle({ fillColor: '#1d6005', color: '#34db63' });
                                                        <%polygons1[i].Color = "#1d6005"; %>
                                                    <%} else {%>
                                                    alert("<%=polygons1[i].Color%>" + "polygonList[<%=i%>].color");
                                                    polygonList[<%=i%>].setStyle({ fillColor: '#FFFFFF', color: '#FFFFFF' });
                                                        <%polygons1[i].Color = "#FFFFFF"; %>
                                                         
                                                    <%}%>
                                                    alert("<%=polygons1[i].Color%>" + "polygonList[<%=i%>].color");
                                                         e.preventDefault();
                                                    });
                                                });
                                                <%}%>--%>

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
                                                        waypoints: test
                                                    }).addTo(map).hide();
                                                }
                                            }

                                            var allDriver = document.getElementById("HiddenField3").value.split("$");
                                            for (j = 0; j < allDriver.length; j++) {
                                                var test = []
                                                var test2 = []
                                                if (allDriver[j].length > 0) {
                                                    var allDriverRoute = allDriver[j].split("^");
                                                    for (i = 0; i < allDriverRoute.length; i++) {
                                                        if (allDriverRoute[i].length > 0) {
                                                            var oneLocation = allDriverRoute[i].split("*");
                                                            if (oneLocation.length > 0) {                                                                
                                                                marker = new L.Marker([parseFloat(oneLocation[3]), parseFloat(oneLocation[4])])
                                                                .bindPopup( (i+1) + "<br>" + oneLocation[1] + "<br>" + oneLocation[2] + "<br>" + oneLocation[0] + "<br>" + oneLocation[5]).openPopup()
                                                                .addTo(map)
                                                            }
                                                        }
                                                    }                                                 
                                                }
                                            }

                                                // driver current location marker 
                                                    var allDriverLoc = document.getElementById("HiddenField1").value.split("^");
                                                    if (allDriverLoc[0] != "") {
                                                        var oneDriverLoc = allDriverLoc[0].split("*");

                                                        for (i = 0; i < allDriverLoc.length; i++) {
                                                            var oneDriverLoc = allDriverLoc[i].split("*");
                                                            marker = new L.marker([parseFloat(oneDriverLoc[1]), parseFloat(oneDriverLoc[2])])
                                                                .bindPopup(oneDriverLoc[0]).openPopup()
                                                                //layers code beneath
                                                                //.addTo(driverLocationLayer)
                                                                .addTo(map)   
                                                        }                                                       
                                                    }

                                                //    //LTA incidents
                                                    var allLTAIncidents = document.getElementById("HiddenField2").value.split("^");

                                                    if (allLTAIncidents[0] != "") {
                                                        for (i = 0; i < allLTAIncidents.length; i++) {
                                                            var oneLTAIncidents = allLTAIncidents[i].split("*");
                                                            marker = new L.marker([parseFloat(oneLTAIncidents[1]), parseFloat(oneLTAIncidents[2])])
                                                                .bindPopup(oneLTAIncidents[0]).openPopup()
                                                                .addTo(map)
                                                                //trafficLayer.addLayer(marker);

                                                        }
                                                    }

                                            ////cluster
                                            //var cluster = L.markerClusterGroup();
                                            //var allDriver = document.getElementById("HiddenField3").value.split("$");
                                            
                                            //for (j = 0; j < allDriver.length; j++) {
                                            //    var test = []
                                            //    var test2 = []
                                            //    if (allDriver[j].length > 0) {
                                            //        var allDriverRoute = allDriver[j].split("^");
                                            //        for (i = 0; i < allDriverRoute.length; i++) {
                                            //            if (allDriverRoute[i].length > 0) {
                                            //                var oneLocation = allDriverRoute[i].split("*");
                                            //                if (oneLocation.length > 0) {
                                            //                    //alert(oneLocation)
                                            //                    marker = new L.Marker([parseFloat(oneLocation[3]), parseFloat(oneLocation[4])])
                                            //                        .bindPopup((i + 1) + "<br>" + oneLocation[1] + "<br>" + oneLocation[2] + "<br>" + oneLocation[0] + "<br>" + oneLocation[5]).openPopup();
                                            //                        //.addTo(map)
                                            //                    cluster.addLayer(marker);
                                            //                }
                                            //            }
                                            //        }
                                            //        map.addLayer(cluster);

                                            //    }
                                            //}

    
                                        </script>


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
                <div id="search">

                    <div class="w3-col m2">
                        <div class="w3-card-2 w3-round w3-white w3-center">
                            <div class="w3-container">

                                <p>Search Drivers:</p>

                                <p />
                                <input type="text" name="" id="filter">

                                <p />
                                <strong>Driver List</strong>
                                <asp:Button ID="selectAll" OnClick="selectAll_Click" runat="server" class="w3-button w3-block w3-green w3-section" title="SelectAll" Text="Select All"></asp:Button>
                                <!-- Clear and Clear All button-->
                                <asp:Button ID="uncheckAll" OnClick="uncheckAll_Click" runat="server" class="w3-button w3-block w3-red w3-section" title="ClearAll" Text="Clear All"></asp:Button>


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
                        <br>

                        <div class="w3-card-2 w3-round w3-white w3-center">
                            <div class="w3-container">
                            </div>
                        </div>
                        <br>
                        <br>



                        <!-- End Right Column -->
                    </div>
                </div>


                <!-- End Grid -->
            </div>

            <!-- End Page Container -->
        <%--</div>--%>
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
