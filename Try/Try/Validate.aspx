<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Validate.aspx.cs" Inherits="Try.Validate" %>



<!DOCTYPE html>

<html>
<head>


    <% Server.Execute("Include.aspx"); %>
        
    <%--<% Server.Execute("Include.aspx"); %>--%>
    <link rel="stylesheet" href="Scripts/W3.css">
    <link rel="stylesheet" href="Scripts/w3-theme.css">
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
                                <!-- Route Hidden Field -->
                                <asp:HiddenField ID="HiddenField3" runat="server" />                            
                                 <!-- Driver Hidden Field -->
                                <asp:HiddenField ID="Driver1" runat="server" />
                                <!-- Driver Hidden Field -->
                                <asp:HiddenField ID="Driver2" runat="server" />
                                <!-- Driver Hidden Field -->
                                <asp:HiddenField ID="Driver3" runat="server" />
                                <!-- Driver Hidden Field -->
                                <asp:HiddenField ID="Driver4" runat="server" />
                                <!-- Driver Hidden Field -->
                                <asp:HiddenField ID="Driver5" runat="server" />
                                <!-- DriverIDX Hidden Field -->
                                <asp:HiddenField ID="IDX2" runat="server" />
                                <!-- DriverIDX Hidden Field -->
                                <asp:HiddenField ID="IDX3" runat="server" />
                                <!-- DriverIDX Hidden Field -->
                                <asp:HiddenField ID="IDX4" runat="server" />
                                <!-- DriverIDX Hidden Field -->
                                <asp:HiddenField ID="IDX5" runat="server" />
                                <!-- New Job IDX Hidden Field -->
                                <asp:HiddenField ID="NewJobsIDX" runat="server" />


                                <!-- MAP -->



                                <div class="row">
                                    <div class="divToggleButton">
                                        <asp:CheckBox ID="chkTraffic" runat="server"
                                            AutoPostBack="true" />
                                        <asp:Label ID="lblToggleTraffic"
                                            AssociatedControlID="chkTraffic" runat="server"
                                            ToolTip="Toggle between Traffic Condition" />
                                    </div>

                                </div>

                                <br />

                                <p />

                                <div id="map" style="height: 500px; border: 1px solid #AAA;">

                                    <script>
                                        
                                        //markers
                                        var trafficMarker = L.ExtraMarkers.icon({
                                            icon: 'fa-envelope',
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

                                        var chosenMarker = L.ExtraMarkers.icon({
                                            icon: 'fa-user-circle',
                                            markerColor: 'green',
                                            shape: 'circle',
                                            prefix: 'fa',
                                        })

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

                                        // Layers 
                                        //L.control.layers(baseLayers, overlays).addTo(map);

                                        // driver current location marker                
                                        var allDriverLoc = document.getElementById("HiddenField1").value.split("^");
                                        if (allDriverLoc[0] != "") {
                                            for (i = 0; i < allDriverLoc.length; i++) {
                                                if (allDriverLoc[i].length > 0) {
                                                    var oneDriverLoc = allDriverLoc[i].split("*");
                                                    if (i == 0 || i % 5 == 0) {
                                                        marker = new L.marker([parseFloat(oneDriverLoc[0]), parseFloat(oneDriverLoc[1])], { icon: chosenMarker })
                                                            .bindPopup(oneDriverLoc[2]).openPopup()
                                                            .addTo(map)
                                                    } else {
                                                        marker = new L.marker([parseFloat(oneDriverLoc[0]), parseFloat(oneDriverLoc[1])], { icon: humanMarker })
                                                            .bindPopup(oneDriverLoc[2]).openPopup()
                                                            .addTo(map)
                                                    }
                                                }

                                            }
                                        }

                                        //Job Locations
                                        var allJobLocations = document.getElementById("HiddenField3").value.split("^");
                                        if (allJobLocations[0] != "") {
                                            for (i = 0; i < allJobLocations.length; i++) {
                                                if (allJobLocations[i].length > 0) {
                                                    var oneJobLoc = allJobLocations[i].split("*");
                                                    marker = new L.marker([parseFloat(oneJobLoc[0]), parseFloat(oneJobLoc[1])], { icon: trafficMarker })
                                                        .bindPopup(oneJobLoc[2]).openPopup()
                                                        //layers code beneath
                                                        //.addTo(driverLocationLayer)
                                                        .addTo(map)
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




            <div class="w3-col m2">
                <div class="w3-card-2 w3-round w3-white w3-center">
                    <div class="w3-container">
                        

                        <button class="w3-bar-item w3-button w3-orange w3-section w3-half" onclick="openTabs('SearchJobTab');return false">Search</button>
                        <button class="w3-bar-item w3-button w3-orange w3-section w3-half" onclick="openTabs('JobDetails');return false">Details</button>
                        
                        <div id="SearchJobTab" class="w3-container tab" >

                                <!--filter table for searching jobs-->
                                <div class="scroll">
                                    
                            <p>Search Job:</p>
                            <div id="search">
                                <p />

                                <input type="text" name="" id="filter" size="15">

                                <p />
                                <strong>JobList</strong>                             
                                <p />
                                    <table id="UserGridView" class="tableC">

                                        <tr>
                                            <td style="text-align: left; padding-left: 5px;">
                                                <asp:RadioButtonList
                                                    
                                                    enabled="true"
                                                    ID="radioList"
                                                    AutoPostBack="True"
                                                    OnSelectedIndexChanged="RadioList_Click"
                                                    runat="server">
                                                </asp:RadioButtonList>
                                            </td>
                                        </tr>

                                    </table>
                                </div>
                            </div>
                            </div>

                        <div id="JobDetails" class="w3-container tab" style="display: none; max-width:180px">
                            <div class="scroll">
                                <%-- Start Of First Driver --%>
                                <% var driver1 = Driver1.Value.Split('^');
                                    if (radioList.SelectedIndex != -1)
                                    {
                                        string driverNameDistNum1 = "";
                                        for (int i = 0; i < driver1.Length; i++)
                                        {
                                            if (driver1[i].Length > 0 && !driver1[i].Contains("*"))
                                            {
                                                driverNameDistNum1 = driver1[i];
                                %>          
                                            <button onclick="myFunction('FirstDriver');return false" class="w3-button w3-block w3-theme-l1 w3-left-align" style="font-size:8px"><%=driverNameDistNum1 %></button>
                                            <div id="FirstDriver" class="w3-hide w3-animate-zoom">
                                            <table class="tableC">
                                <%
                                    }
                                    else
                                    {
                                        if (i != driver1.Length - 1)
                                        {
                                            var driver1jobDetails = driver1[i].Split('*');
                                            string finalOutput1 = "";
                                            for (int j = 0; j < driver1jobDetails.Length; j++)
                                            {
                                                if (driver1jobDetails[j].Length > 0)
                                                {
                                                    finalOutput1 += driver1jobDetails[j] + " ";
                                                }
                                            }
                                            string newJobIDX = NewJobsIDX.Value;
                                            if (finalOutput1.Contains(newJobIDX))
                                            {
                                            %>                  
                                                <tr>
                                                    <td class="align-center">
                                                        <span style="background-color: yellow;"><%= i + ". " + finalOutput1%></span>                    
                                                    </td>
                                                </tr>
                                            <%
                                            }
                                            else
                                            {
                                            %>                  
                                                <tr>
                                                    <td class="align-center">
                                                        <%= i + ". " + finalOutput1%>
                                                    </td>
                                                </tr>
                                             <%
                                            }
                                             

                                        }
                                    }
                                }
                                             %>
                                                </table>
                                </div>
                                                <%
                                                    }%>
                                
                                <%-- End Of First Driver --%>
                                <%-- Start Of Second Driver --%>
                                <% var driver2 = Driver2.Value.Split('^');
                                    if (radioList.SelectedIndex != -1)
                                    {
                                        string driverNameDistNum2 = "";
                                        for (int i = 0; i < driver2.Length; i++)
                                        {
                                            if (driver2[i].Length > 0 && !driver2[i].Contains("*"))
                                            {
                                                driverNameDistNum2 = driver2[i];
                                %>    
                                            <button onclick="myFunction('SecondDriver');return false" class="w3-button w3-block w3-theme-l1 w3-left-align" style="font-size:8px""><%=driverNameDistNum2 %></button>
                                            <div id="SecondDriver" class="w3-hide w3-animate-zoom">
                                            <table class="tableC">
                                <%
                                    }
                                    else
                                    {
                                        if (i != driver2.Length-1)
                                        {
                                            var driver2jobDetails = driver2[i].Split('*');
                                            string finalOutput2 = "";
                                            for (int j = 0; j < driver2jobDetails.Length; j++)
                                            {
                                                if (driver2jobDetails[j].Length > 0)
                                                {
                                                    finalOutput2 += driver2jobDetails[j] + " ";
                                                }
                                            }
                                            string newJobIDX = NewJobsIDX.Value;
                                            if (finalOutput2.Contains(newJobIDX))
                                            {
                                             %>                  
                                                <tr>
                                                    <td class="align-center">
                                                         <span style="background-color: yellow;"><%= i + ". " + finalOutput2%></span>
                                                    </td>
                                                </tr>
                                             <%
                                            }else
                                            {
                                            %>                  
                                                <tr>
                                                    <td class="align-center">
                                                        <%= i + ". " + finalOutput2%>
                                                    </td>
                                                </tr>
                                             <%
                                            }
                                                         }
                                                     }
                                                 }
                                                     %>
                                                 <tr>
                                    <td>
                                        <asp:Button ID="validate2" OnClick="ValidateSecond" runat="server" class="w3-button w3-block w3-green w3-section" title="validate2" Text="Validate"></asp:Button>
                                    </td>
                                </tr> 
                                                </table>
                                </div>
                                                <%
                                                    }%>   
                                                       
                                
                                 <%-- End Of Second Driver --%>
                                <%-- Start Of Third Driver --%>
                                <% var driver3 = Driver3.Value.Split('^');
                                    if (radioList.SelectedIndex != -1)
                                    {
                                        string driverNameDistNum3 = "";
                                        for (int i = 0; i < driver3.Length; i++)
                                        {
                                            if (driver3[i].Length > 0 && !driver3[i].Contains("*"))
                                            {
                                                driverNameDistNum3 = driver3[i];
                                %>    
                                            <button onclick="myFunction('ThirdDriver');return false" class="w3-button w3-block w3-theme-l1 w3-left-align" style="font-size:8px"><%=driverNameDistNum3 %></button>
                                            <div id="ThirdDriver" class="w3-hide w3-animate-zoom">
                                            <table class="tableC">
                                <%
                                    }
                                    else
                                    {
                                        if (i != driver3.Length-1)
                                        {
                                            var driver3jobDetails = driver3[i].Split('*');
                                            string finalOutput3 = "";
                                            for (int j = 0; j < driver3jobDetails.Length; j++)
                                            {
                                                if (driver3jobDetails[j].Length > 0)
                                                {
                                                    finalOutput3 += driver3jobDetails[j] + " ";
                                                }
                                            }
                                           string newJobIDX = NewJobsIDX.Value;
                                            if (finalOutput3.Contains(newJobIDX))
                                            {
                                             %>                  
                                                <tr>
                                                    <td class="align-center">
                                                         <span style="background-color: yellow;"><%= i + ". " + finalOutput3%></span>
                                                    </td>
                                                </tr>
                                             <%
                                            }else
                                            {
                                            %>                  
                                                <tr>
                                                    <td class="align-center">
                                                        <%= i + ". " + finalOutput3%>
                                                    </td>
                                                </tr>
                                             <%
                                            }
                                                         }
                                                     }
                                                 }
                                                     %>
                                                 <tr>
                                    <td>
                                        <asp:Button ID="validate3" OnClick="ValidateThird" runat="server" class="w3-button w3-block w3-green w3-section" title="validate3" Text="Validate"></asp:Button>
                                    </td>
                                </tr> 
                                                </table>
                                </div>
                                                <%
                                                    }%>   
                                
                                
                                <%-- End Of Third Driver --%>
                                <%-- Start Of Fourth Driver --%>
                                <% var driver4 = Driver4.Value.Split('^');
                                    if (radioList.SelectedIndex != -1)
                                    {
                                        string driverNameDistNum4 = "";
                                        for (int i = 0; i < driver4.Length; i++)
                                        {
                                            if (driver4[i].Length > 0 && !driver4[i].Contains("*"))
                                            {
                                                driverNameDistNum4 = driver4[i];
                                %>    
                                            <button onclick="myFunction('FourthDriver');return false" class="w3-button w3-block w3-theme-l1 w3-left-align" style="font-size:8px"><%=driverNameDistNum4 %></button>
                                            <div id="FourthDriver" class="w3-hide w3-animate-zoom">
                                            <table class="tableC">
                                <%
                                    }
                                    else
                                    {
                                        if (i != driver4.Length-1)
                                        {
                                            var driver4jobDetails = driver4[i].Split('*');
                                            string finalOutput4 = "";
                                            for (int j = 0; j < driver4jobDetails.Length; j++)
                                            {
                                                if (driver4jobDetails[j].Length > 0)
                                                {
                                                    finalOutput4 += driver4jobDetails[j] + " ";
                                                }
                                            }
                                            string newJobIDX = NewJobsIDX.Value;
                                            if (finalOutput4.Contains(newJobIDX))
                                            {
                                             %>                  
                                                <tr>
                                                    <td class="align-center">
                                                         <span style="background-color: yellow;"><%= i + ". " + finalOutput4%></span>
                                                    </td>
                                                </tr>
                                             <%
                                            }else
                                            {
                                            %>                  
                                                <tr>
                                                    <td class="align-center">
                                                        <%= i + ". " + finalOutput4%>
                                                    </td>
                                                </tr>
                                             <%
                                            }
                                                         }
                                                     }
                                                 }
                                                     %>
                                                 <tr>
                                    <td>
                                        <asp:Button ID="validate4" OnClick="ValidateFourth" runat="server" class="w3-button w3-block w3-green w3-section" title="validate4" Text="Validate"></asp:Button>
                                    </td>
                                </tr> 
                                                </table>
                                </div>
                                                <%
                                                    }%>   
                                                               
                                <%-- End Of Fourth Driver --%>
                                <%-- Start Of Fifth Driver --%>
                                <% var driver5 = Driver5.Value.Split('^');
                                    if (radioList.SelectedIndex != -1)
                                    {
                                        string driverNameDistNum5 = "";
                                        for (int i = 0; i < driver5.Length; i++)
                                        {
                                            if (driver5[i].Length > 0 && !driver5[i].Contains("*"))
                                            {
                                                driverNameDistNum5 = driver5[i];
                                %>    
                                            <button onclick="myFunction('FifthDriver');return false" class="w3-button w3-block w3-theme-l1 w3-left-align" style="font-size:8px"><%=driverNameDistNum5 %></button>
                                            <div id="FifthDriver" class="w3-hide w3-animate-zoom">
                                            <table class="tableC">
                                <%
                                    }
                                    else
                                    {
                                        if (i != driver5.Length-1)
                                        {
                                            var driver5jobDetails = driver5[i].Split('*');
                                            string finalOutput5 = "";
                                            for (int j = 0; j < driver5jobDetails.Length; j++)
                                            {
                                                if (driver5jobDetails[j].Length > 0)
                                                {
                                                    finalOutput5 += driver5jobDetails[j] + " ";
                                                }
                                            }
                                              string newJobIDX = NewJobsIDX.Value;
                                            if (finalOutput5.Contains(newJobIDX))
                                            {
                                             %>                  
                                                <tr>
                                                    <td class="align-center">
                                                         <span style="background-color: yellow;"><%= i + ". " + finalOutput5%></span>
                                                    </td>
                                                </tr>
                                             <%
                                            }else
                                            {
                                            %>                  
                                                <tr>
                                                    <td class="align-center">
                                                        <%= i + ". " + finalOutput5%>
                                                    </td>
                                                </tr>
                                             <%
                                            }
                                                         }
                                                     }
                                                 }
                                                     %>
                                                 <tr>
                                    <td>
                                        <asp:Button ID="validate5" OnClick="ValidateFifth" runat="server" class="w3-button w3-block w3-green w3-section" title="validate5" Text="Validate"></asp:Button>
                                    </td>
                                </tr> 
                                                </table>
                                </div>
                                                <%
                                                    }%> 
                                                       
                                <%-- End Of Fifth Driver --%>                   
                            </div>
                            </div>
                        </div>
                    </div>
                </div>
           </div>




            <!-- End Right Column -->




            <!-- End Grid -->


            <!-- End Page Container -->
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




