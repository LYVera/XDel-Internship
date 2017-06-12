<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowMap.aspx.cs" Inherits="Try.ShowMap" %>

<!DOCTYPE html>

<html>
<head>

    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-blue-grey.css">
    <link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Open+Sans'>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <link rel="stylesheet" type="text/css" href="Scripts/Leaflet/leaflet.css" />
    <link rel="stylesheet" href="Scripts/routing machine/leaflet-routing-machine-3.2.5/dist/leaflet-routing-machine.css" />


    <script type='text/javascript' src="Scripts/Leaflet/leaflet.js"></script>
    <script src="Scripts/routing machine/leaflet-routing-machine-3.2.5/dist/leaflet-routing-machine.js"></script>
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
    <script src="~/Scripts/jquery-1.10.2.js" type="text/javascript"></script>


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
                <a href="http://localhost:57238/ShowMap/ViewMap" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white" title="Show"><i class="fa fa-info-circle"></i></a>
                <a href="#" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white" title="Validate"><i class="fa fa-check"></i></a>
                <a href="#" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white" title="Prompt"><i class="fa fa-bell"></i></a>
                <div class="w3-dropdown-hover w3-hide-small">
                    <button class="w3-button w3-padding-large" title="Notifications"><i class="fa fa-battery-1"></i><span class="w3-badge w3-right w3-small w3-green">3</span></button>
                    <div class="w3-dropdown-content w3-card-4 w3-bar-block" style="width: 300px">
                        <a href="#" class="w3-bar-item w3-button">Tan Battery Low</a>
                        <a href="#" class="w3-bar-item w3-button">Low Battery Low</a>
                        <a href="#" class="w3-bar-item w3-button">High Battery Low</a>
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
        <div class="w3-container w3-content" style="max-width: 1400px; margin-top: 80px">
            <!-- The Grid -->
            <div class="w3-row">
                <!-- Left Column -->
                <div class="w3-col m2">
                    <!-- Profile -->
                    <div class="w3-card-2 w3-round w3-white">
                        <div class="w3-container">
                            <h4 class="w3-center">Show</h4>

                            <hr>
                            <p>
                                <i class="fa fa-pencil fa-fw w3-margin-right w3-text-theme"></i>
                            </p>
                            <p>
                                <i class="fa fa-home fa-fw w3-margin-right w3-text-theme"></i>
                            </p>
                            <p>
                                <i class="fa fa-birthday-cake fa-fw w3-margin-right w3-text-theme"></i>
                            </p>
                        </div>
                    </div>
                    <br>

                    <!-- Accordion -->
                    <div class="w3-card-2 w3-round">
                        <div class="w3-white">
                            <button onclick="myFunction('Demo1');return false" class="w3-button w3-block w3-theme-orange w3-left-align"><i class="fa fa-circle-o-notch fa-fw w3-margin-right"></i>Courier Type</button>
                            <div id="Demo1" class="w3-hide w3-container">
                                
                                    <input type="checkbox" name="vehicle" value="network">Network<br>
                                    <input type="checkbox" name="vehicle" value="express">Express<br>
                             

                            </div>
                            <button onclick="myFunction('Demo2');return false" class="w3-button w3-block w3-theme-orange w3-left-align"><i class="fa fa-calendar-check-o fa-fw w3-margin-right"></i>Postal Code</button>
                            <div id="Demo2" class="w3-hide w3-container">
                                <p>Some other text..</p>
                            </div>

                            <button onclick="myFunction('3');return false" class="w3-button w3-block w3-theme-orange w3-left-align"><i class="fa fa-calendar-check-o fa-fw w3-margin-right"></i>Route</button>
                            <div id="3" class="w3-hide w3-container">                                                                  
                                    <asp:CheckBox ID="courRoute" runat="server"/>Courier Route<br>
                                    
                               
                            </div>


                        </div>
                    </div>
                    <br>

                    <!-- Others -->
                    <div class="w3-card-2 w3-round w3-white w3-hide-small">
                        <div class="w3-container">
                            <p>Submit</p>
                            <%--<input type="button" value="submit" id="testCheck">--%>
                            <asp:Button ID="Submit" runat="server" onclick="Submit_Click" Text="Button" />  
                            <p>
                            </p>

                        </div>
                    </div>
                    <br>

                    <!-- Alert Box -->
                    <div class="w3-container w3-display-container w3-round w3-theme-l4 w3-border w3-theme-border w3-margin-bottom w3-hide-small">
                        <span onclick="this.parentElement.style.display='none'" class="w3-button w3-theme-l3 w3-display-topright">
                            <i class="fa fa-remove"></i>
                        </span>
                        <p>
                            <strong>Hey!</strong>
                        </p>
                        <p>Tan's Battery is Low.</p>
                    </div>

                    <!-- End Left Column -->
                </div>

                <!-- Middle Column -->
                <div class="w3-col m8">
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

                                    <!-- MAP -->
                                    <h6 class="w3-opacity">Map</h6>

                                    <!--<p contenteditable="true" class="w3-border w3-padding">-->
                                    <div id="map" style="height: 440px; border: 1px solid #AAA;">

                                        <script>
                                                //marker 
                                            


                                                var osmLink = '<a href="http://openstreetmap.org">OpenStreetMap</a>',
                                                    thunLink = '<a href="http://thunderforest.com/">Thunderforest</a>';

                                                var osmUrl = 'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                                                    osmAttrib = '&copy; ' + osmLink + ' Contributors',
                                                    landUrl = 'http://{s}.tile.thunderforest.com/landscape/{z}/{x}/{y}.png',
                                                    thunAttrib = '&copy; ' + osmLink + ' Contributors & ' + thunLink;

                                                var osmMap = L.tileLayer(osmUrl, { attribution: osmAttrib }),
                                                    landMap = L.tileLayer(landUrl, { attribution: thunAttrib });

                                                var map = L.map('map', {
                                                    layers: [osmMap] // only add one!
                                                })
                                                    .setView([1.3521, 103.8198], 11);

                                                var baseLayers = {
                                                    "Colour Map": osmMap,
                                                    "GrayScale Map": landMap
                                                };

                                                var trafficLayer = new L.LayerGroup();   
                                                var postalCodeBoundaryLayer = new L.LayerGroup();
                                                var overlays = {
                                                    "Traffic Condition": trafficLayer,
                                                    "Postal Code Boundary": postalCodeBoundaryLayer
                                                };


                                                // Layers 
                                                L.control.layers(baseLayers, overlays).addTo(map);

                                            ////Map
                                            //var map = L.map('map', { center: [1.3521, 103.8198], minZoom: 2, zoom: 12 });
                                            //L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                                            //    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>',
                                            //    subdomains: ['a', 'b', 'c']
                                            //}).addTo(map);
                                                

                                               <%Try.Models.PolygonO[] polygons1 = getPolygon(); %>                         
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
                                                <%}%>


                                                // driver current location marker 
                                                    var allDriverLoc = document.getElementById("HiddenField1").value.split("@");
                                                    if (allDriverLoc[0] != "") {
                                                        var oneDriverLoc = allDriverLoc[0].split(",");
                                                        
                                                        for (i = 0; i < allDriverLoc.length; i++) {
                                                            var oneDriverLoc = allDriverLoc[i].split(",");
                                                            marker = new L.marker([parseFloat(oneDriverLoc[1]), parseFloat(oneDriverLoc[2])])
                                                                .bindPopup(oneDriverLoc[0]).openPopup()
                                                                //layers code beneath
                                                                //.addTo(driverLocationLayer)
                                                                .addTo(map)   
                                                        }                                                       
                                                    }

                                                    // //LTA incidents
                                                    var allLTAIncidents = document.getElementById("HiddenField2").value.split("@");

                                                    if (allLTAIncidents[0] != "") {
                                                        for (i = 0; i < allLTAIncidents.length; i++) {
                                                            var oneLTAIncidents = allLTAIncidents[i].split(",");
                                                            marker = new L.marker([parseFloat(oneLTAIncidents[1]), parseFloat(oneLTAIncidents[2])])
                                                                .bindPopup(oneLTAIncidents[0]).openPopup();
                                                            trafficLayer.addLayer(marker);

                                                        }
                                                    }


                                                    // Route 
                                                var allDriverRoute = document.getElementById("HiddenField3").value.split("@");
                                               
                                                //alert(allDriverRoute);
                                                if (allDriverRoute[0] != "") {
                                                    for (i = 0; i < allDriverRoute.length; i++) {

                                                        var oneLocation = allDriverRoute[i].split(",");
                                                        var oneNextLocation = allDriverRoute[i+1].split(",");

                                                        marker = new L.Marker([parseFloat(oneLocation[3]), parseFloat(oneLocation[4])])
                                                            .bindPopup("<b>" + oneLocation[1] + "<br>" + oneLocation[2] + "<br>" + oneLocation[0] + "<br>" + oneLocation[5]).openPopup()
                                                            .addTo(map)

                                                        ////routing machine
                                                        //if (i == 0) {
                                                        //    L.Routing.control({
                                                        //        waypoints: [
                                                        //            L.latLng(parseFloat(oneLocation[3]), parseFloat(oneLocation[4])),
                                                        //            L.latLng(parseFloat(oneNextLocation[3]), parseFloat(oneNextLocation[4]))
                                                        //        ]
                                                        //    }).addTo(map);
                                                        //}
                                                            
                                                        
                                                    }
                                                }

                                        </script>
                                        `
                                        
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
                                <p />
                                <!--filter table for searching drivers-->
                                <table id="UserGridView" class="tableC">

                                    <tr>
                                        <td style="text-align: left;  padding-left:5px;">
                                             <asp:CheckBoxList 
                                             ID="CheckBoxList1"
                                             AutoPostBack="True"
                                             OnSelectedIndexChanged="CheckBoxList_Click"
                                             runat="server">
                                             </asp:CheckBoxList>
                                        </td>
                                    </tr>

                                </table>
                               

                                

                                <!-- Clear and Clear All button-->
                                <div class="w3-row w3-opacity">
                                    <div class="w3-half">
                                        <button class="w3-button w3-block w3-green w3-section" title="Clear">Clear</button>
                                    </div>
                                    <div class="w3-half">
                                        <button class="w3-button w3-block w3-red w3-section" title="ClearAll">Clear All</button>
                                    </div>
                                </div>

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
