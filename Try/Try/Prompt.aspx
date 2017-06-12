﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Prompt.aspx.cs" Inherits="Try.Prompt" %>

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



    <title>Prompt</title>
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

        tr:nth-child(even){background-color: #f2f2f2}

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
                    <button class="w3-button w3-padding-large" title="Notifications"><i class="fa fa-battery-1"></i><span class="w3-badge w3-right w3-small w3-green">3</span></button>
                    <div class="w3-dropdown-content w3-card-4 w3-bar-block" style="width: 300px">
                            <%

                                ArrayList lowBatts = new ArrayList();
                                lowBatts = (ArrayList)Session["lowBatt"];
                                for (int i = 0; i < lowBatts.Count; i++) {
                                    Try.LukeRefL2.DriverObject lowBattDriver = (Try.LukeRefL2.DriverObject)lowBatts[i];
                                    
                            %>
                                <%=lowBattDriver.Name%> Battery Low <br/>
                             <%--<a href="#" class="w3-bar-item w3-button">test</a>--%>
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
        <div class="w3-container w3-content" style="max-width: 1400px; margin-top: 80px">
            <!-- The Grid -->
            <div class="w3-row">
                <!-- Left Column -->
                <div class="w3-col m2">
                    <!-- Profile -->
                    <div class="w3-card-2 w3-round w3-white">
                        <div class="w3-container">
                            <h4 class="w3-center">Prompt</h4>

                            <hr>
                            <p>
                                <i class="fa fa-pencil fa-fw w3-margin-right w3-text-theme"></i> Prompts Low Battery & Delays
                            </p>
                           
                        </div>
                    </div>
                    <br>

                    <!-- Accordion -->
                    <div class="w3-card-2 w3-round">
                        <div class="w3-white">
                            <button onclick="myFunction('Demo1');return false" class="w3-button w3-block w3-theme-orange w3-left-align"><i class="fa fa-circle-o-notch fa-fw w3-margin-right"></i>Courier Type</button>
                            <div id="Demo1" class="w3-hide w3-container">
                                
                                    <input type="checkbox" name="promptNotif" value="delay">Delay<br>
                                    <input type="checkbox" name="promptNotif" value="lowBatt">Low Battery<br>
                             

                            </div>
                            


                        </div>
                    </div>
                    <br>

                    <!-- Others -->
                    <div class="w3-card-2 w3-round w3-white w3-hide-small">
                        <div class="w3-container">
                            <p>Submit</p>
                            
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
                                    <table>

                                        <tr>
                                            <th>
                                                Job ID
                                            </th>

                                            <th>
                                                Courier
                                            </th>

                                            <th>
                                                Location
                                            </th>

                                            <th>
                                                Expected Time Of Arrival
                                            </th>

                                            <th>
                                                Delay
                                            </th>
                                        </tr>


                                    </table>
                                    
                                        
                                    



                                   

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