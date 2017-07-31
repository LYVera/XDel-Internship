<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Prompt.aspx.cs" Inherits="Try.Prompt" %>

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
            width: 540px; 
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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/OverlappingMarkerSpiderfier-Leaflet/0.2.6/oms.min.js"></script>


   

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
            <div class="w3-col m7">
                <div class="w3-row-padding">
                    <div class="w3-col m12">
                        <div class="w3-card-2 w3-round w3-white">
                            <div class="w3-container w3-padding">

                                <!-- hidden field-->
                                <!-- Delay field -->
                                <asp:HiddenField ID="Delays" runat="server" />
                                <!-- red delays -->
                                <asp:HiddenField ID="RedDelays" runat="server" />
                                <asp:HiddenField ID="RedDelaysLatLong" runat="server" />
                                <!-- amber delays -->
                                <asp:HiddenField ID="AmberDelays" runat="server" />
                                <asp:HiddenField ID="AmberDelaysLatLong" runat="server" />
                                <!-- green delays -->
                                <asp:HiddenField ID="GreenDelays" runat="server" />
                                <asp:HiddenField ID="GreenDelaysLatLong" runat="server" />

                                <!-- MAP -->



                                <br />

                                <p />

                                <div id="map" style="height: 500px; border: 1px solid #AAA;">

                                    <script>
                                        //markers
                                        var redMarker = L.ExtraMarkers.icon({
                                            icon: 'fa-envelope',
                                            markerColor: 'red',
                                            shape: 'circle',
                                            prefix: 'fa'
                                        });
                                        var greenMarker = L.ExtraMarkers.icon({
                                            icon: 'fa-envelope',
                                            markerColor: 'green',
                                            shape: 'circle',
                                            prefix: 'fa'
                                        });

                                        var orangeMarker = L.ExtraMarkers.icon({
                                            icon: 'fa-envelope',
                                            markerColor: 'orange',
                                            shape: 'circle',
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
                                        var oms = new OverlappingMarkerSpiderfier(map);
                                        var popup = new L.Popup();
                                        //oms.addListener('click', function (marker) {
                                        //    popup.setContent(marker.desc);
                                        //    popup.setLatLng(marker.getLatLng());
                                        //    map.openPopup(popup);
                                        //});
                                        //oms.addListener('spiderfy', function (markers) {
                                        //    map.closePopup();
                                        //});


                                        var allRedDelays = document.getElementById("RedDelaysLatLong").value.split("^");
                                        //alert(allRedDelays);
                                        for (i = 0; i < allRedDelays.length; i++) {
                                            //alert(allRedDelays[i]);
                                            if (allRedDelays[i].length > 0) {
                                                var oneRedDelay = allRedDelays[i].split("*");
                                                for (j = 0; j < oneRedDelay.length; j++) {
                                                    if (oneRedDelay[j].length > 0) {
                                                        //alert(oneRedDelay[0]);
                                                        marker = new L.marker([parseFloat(oneRedDelay[0]), parseFloat(oneRedDelay[1])], { icon: redMarker })
                                                            .bindPopup(oneRedDelay[5] + "<br>" + "JobID:" + oneRedDelay[4] + "<br>" + oneRedDelay[2] + "<br>" + oneRedDelay[3]).openPopup()
                                                            .addTo(map);
                                                        //oms.addMarker(marker);  // <-- here
                                                    }
                                                }
                                            }

                                        }

                                        var allAmberDelays = document.getElementById("AmberDelaysLatLong").value.split("^");

                                        for (i = 0; i < allAmberDelays.length; i++) {

                                            if (allAmberDelays[i].length > 0) {
                                                var oneAmberDelay = allAmberDelays[i].split("*");
                                                for (j = 0; j < oneAmberDelay.length; j++) {
                                                    if (oneAmberDelay[j].length > 0) {

                                                        marker = new L.marker([parseFloat(oneAmberDelay[0]), parseFloat(oneAmberDelay[1])], { icon: orangeMarker })
                                                            .bindPopup(oneAmberDelay[5] + "<br>" + "JobID:" + oneAmberDelay[4] + "<br>" + oneAmberDelay[2] + "<br>" + oneAmberDelay[3]).openPopup()
                                                            .addTo(map);
                                                        //oms.addMarker(marker);  // <-- here
                                                    }
                                                }
                                            }

                                        }


                                        var allGreenDelays = document.getElementById("GreenDelaysLatLong").value.split("^");

                                        for (i = 0; i < allGreenDelays.length; i++) {

                                            if (allGreenDelays[i].length > 0) {
                                                var oneGreenDelay = allGreenDelays[i].split("*");
                                                for (j = 0; j < oneGreenDelay.length; j++) {
                                                    if (oneGreenDelay[j].length > 0) {

                                                        marker = new L.marker([parseFloat(oneGreenDelay[0]), parseFloat(oneGreenDelay[1])], { icon: greenMarker })
                                                            .bindPopup(oneGreenDelay[5] + "<br>" + "JobID:" + oneGreenDelay[4] + "<br>" + oneGreenDelay[2] + "<br>" + oneGreenDelay[3]).openPopup()
                                                            .addTo(map);
                                                        //oms.addMarker(marker);  // <-- here
                                                    }
                                                }
                                            }

                                        }


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




            <div class="w3-col m5" style="padding-right">
                <div class="w3-card-2 w3-round w3-white w3-center">
                    <div class="w3-container">

                        <button class="w3-bar-item w3-button w3-orange w3-section w3-fourth btnFont" onclick="openTabs('Red');return false">Red <%= RedDelays.Value.Split('^').Length -1 %></button>
                        <button class="w3-bar-item w3-button w3-orange w3-section w3-fourth btnFont" onclick="openTabs('Amber');return false">Amber <%= AmberDelays.Value.Split('^').Length -1 %></button>
                        <button class="w3-bar-item w3-button w3-orange w3-section w3-fourth btnFont" onclick="openTabs('Green');return false">Green <%= GreenDelays.Value.Split('^').Length -1 %></button>
                        <button class="w3-bar-item w3-button w3-orange w3-section w3-fourth btnFont" onclick="openTabs('lowBattery');return false">BattPCT</button>

                        <div id="Red" class="w3-container tab">
                            <div class="scroll">
                                <table class="tableC">
                                    <tr>
                                        <th>JobID</th><th>Driver Name</th><th>Job Address</th><th>Delay (H:MM)</th><th>Arrival Time</th><th>End Time</th><th>PU/DL</th>
                                    </tr>
                                    <%
                                        var redJobs = RedDelays.Value.Split('^');
                                        for (int i = 0; i < redJobs.Length; i++)
                                        {

                                    %>
                                    <tr>
                                        <%
                                            var oneJob = redJobs[i].Split('*');
                                            for (int j = 0; j < oneJob.Length; j++)
                                            {
                                        %>
                                                <td>
                                                    <%=oneJob[j] %>
                                                </td>

                                        <%}%>
                                    </tr>
                                    <%} %>
                                </table>

                            </div>
                        </div>



                        <div id="Amber" class="w3-container tab" style="display: none">
                            

                            <div class="scroll">
                                <table class="tableC">
                                    <tr>
                                        <th>JobID</th><th>Driver Name</th><th>Job Address</th><th>Delay (H:MM)</th><th>Arrival Time</th><th>End Time</th><th>PU/DL</th>
                                    </tr>
                                    <%
                                        var amberJobs = AmberDelays.Value.Split('^');
                                        for (int i = 0; i < amberJobs.Length; i++)
                                        {

                                    %>
                                    <tr>
                                        <%
                                            var oneJob = amberJobs[i].Split('*');
                                            for (int j = 0; j < oneJob.Length; j++)
                                            {
                                        %>
                                                <td>
                                                    <%=oneJob[j] %>
                                                </td>

                                        <%}%>
                                    </tr>
                                    <%} %>

                                </table>
                            </div>
                        </div>


                        
                        <div id="Green" class="w3-container tab" style="display: none">
                            <div class="scroll">
                                <table class="tableC">
                                    <tr>
                                        <th>JobID</th><th>Driver Name</th><th>Job Address</th><th>Delay (H:MM)</th><th>Arrival Time</th><th>End Time</th><th>PU/DL</th>
                                    </tr>
                                    <%
                                        var greenJobs = GreenDelays.Value.Split('^');
                                        for (int i = 0; i < greenJobs.Length; i++)
                                        {

                                    %>
                                    <tr>
                                        <%
                                            var oneJob = greenJobs[i].Split('*');
                                            for (int j = 0; j < oneJob.Length; j++)
                                            {
                                        %>
                                        <td>
                                            <%=oneJob[j] %>
                                        </td>

                                        <%}%>
                                    </tr>
                                    <%} %>
                                </table>

                            </div>
                        </div>


                        <div id="lowBattery" class="w3-container tab" style="display: none">
                            <div class="scroll">
                                <table class="tableC">
                                    <tr>
                                        <th>Name</th><th>Mobile</th><th>BattPCT</th>
                                    </tr>
                                    <% 

                                        for (int i = 0; i < lowBatts.Count; i++)
                                        { %>
                                    
                                    <tr>

                                        <%Try.LukeRefL2.DriverObject lowBattDriver = (Try.LukeRefL2.DriverObject)lowBatts[i];%>
                                        <td><%= lowBattDriver.Name%></td>
                                        <td><%= lowBattDriver.Mobile %></td>
                                        <td><%= lowBattDriver.BattPCT %></td>
                                    </tr>


                                    <%}%>
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