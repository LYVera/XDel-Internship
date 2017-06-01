﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShowMap.aspx.cs" Inherits="Try.ShowMap" %>

<!DOCTYPE html>

<html>
<head>

    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-blue-grey.css">
    <link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Open+Sans'>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <link rel="stylesheet" type="text/css" href="Scripts/Leaflet/leaflet.css" />
    <link rel="stylesheet" href="~/Scripts/routing machine/leaflet-routing-machine-3.2.5/dist/leaflet-routing-machine.css" />


    <script type='text/javascript' src="Scripts/Leaflet/leaflet.js"></script>
    <script src="~/Scripts/routing machine/leaflet-routing-machine-3.2.5/dist/leaflet-routing-machine.js"></script>
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
        <!-- Navbar -->
        <div class="w3-top">
            <div class="w3-bar w3-theme-orange w3-left-align w3-large">
                <a class="w3-bar-item w3-button w3-hide-medium w3-hide-large w3-right w3-padding-large w3-hover-white w3-large w3-theme-orange" href="javascript:void(0);" onclick="openNav()"><i class="fa fa-bars"></i></a>
                <a href="#" class="w3-bar-item w3-button w3-padding-large w3-theme-orange">
                    <img src="~/XDel Logo.gif" alt="Xdel Logo" style="height: 36px; width: 36px" /></a>
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
        <div id="navDemo" class="w3-bar-block w3-theme-d2 w3-hide w3-hide-large w3-hide-medium w3-large">
            <a href="#" class="w3-bar-item w3-button w3-padding-large">Link 1</a>
            <a href="#" class="w3-bar-item w3-button w3-padding-large">Link 2</a>
            <a href="#" class="w3-bar-item w3-button w3-padding-large">Link 3</a>
            <a href="#" class="w3-bar-item w3-button w3-padding-large">My Profile</a>
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
                            <button onclick="myFunction('Demo1')" class="w3-button w3-block w3-theme-orange w3-left-align"><i class="fa fa-circle-o-notch fa-fw w3-margin-right"></i>Courier Type</button>
                            <div id="Demo1" class="w3-hide w3-container">
                                <form action="#" method="post" id="retrieveChecks">
                                    <input type="checkbox" name="vehicle" value="network">Network<br>
                                    <input type="checkbox" name="vehicle" value="express">Express<br>
                                </form>

                            </div>
                            <button onclick="myFunction('Demo2')" class="w3-button w3-block w3-theme-orange w3-left-align"><i class="fa fa-calendar-check-o fa-fw w3-margin-right"></i>Postal Code</button>
                            <div id="Demo2" class="w3-hide w3-container">
                                <p>Some other text..</p>
                            </div>

                            <button onclick="myFunction('3')" class="w3-button w3-block w3-theme-orange w3-left-align"><i class="fa fa-calendar-check-o fa-fw w3-margin-right"></i>Route</button>
                            <div id="3" class="w3-hide w3-container">
                                
                                    <input type="checkbox" name="route" value="courierLocation" class="chkitem">Courier Location<br>
                                    <input type="checkbox" name="route" value="courierRoute" class="chkitem">Courier Route<br>
                                    <input type="checkbox" name="route" value="trafficCondition" class="chkitem">Traffic Conditions<br>
                                
                            </div>


                        </div>
                    </div>
                    <br>

                    <!-- Others -->
                    <div class="w3-card-2 w3-round w3-white w3-hide-small">
                        <div class="w3-container">
                            <p>Submit</p>
                            <input type="button" value="submit" id="testCheck">
                            <%--<asp:Button id="submit" OnClick="Submit_Click" runat="server"/>--%>
                            <p>
                            </p>
                            <script>
                                $("#testCheck").on('click', function () {
                                    var checkbox_value = "";
                                    $(":checkbox").each(function () {
                                        var ischecked = $(this).is(":checked");
                                        if (ischecked) {
                                            checkbox_value += $(this).val() + "|";
                                        }
                                    });
                                        alert(checkbox_value);
                            </script>
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


                                    <!-- MAP -->
                                    <h6 class="w3-opacity">Map</h6>

                                    <!--<p contenteditable="true" class="w3-border w3-padding">-->
                                    <div id="map" style="height: 440px; border: 1px solid #AAA;">


                                        <script>

                                            var map = L.map('map', { center: [1.3521, 103.8198], minZoom: 2, zoom: 12 });
                                            L.tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                                                attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>',
                                                subdomains: ['a', 'b', 'c']
                                            }).addTo(map);

                                            // try 2


                                            /*L.Routing.control({
                                                waypoints: [
                                                    L.latLng(1.280695300, 103.817823900),
                                                    L.latLng(1.4017990359049928, 103.90718500596159)
                                                ]
                                            }).addTo(map).hide();*/


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
                                <p />
                                <!--filter table for searching drivers-->

                               
                                <table id="UserGridView" class="tableC">
                                <thead>
                                    <tr>
                                    <tr>
                                        <th>Name</th>
                                        <th>Check</th>
                                    </tr>
                                </thead>
                                <tbody>
                                   
                                        <%  
                                            var driverArray = getDriverArray();
                                            for (int i = 0; i < driverArray.Length; i++)
                                            {
                                        %>

                                        <tr>
                                            <td>
                                               <%= driverArray[i].Name.ToUpper()%>
                                            </td>
                                            <td>
                                                    <input type="checkbox" name="name" value="#driverArray[i].driverIDX">
                                            </td>
                                        </tr>
                                    <%} %>
                                </tbody>
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