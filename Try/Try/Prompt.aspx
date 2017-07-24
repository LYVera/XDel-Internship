<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Prompt.aspx.cs" Inherits="Try.Prompt" %>

<!DOCTYPE html>

<html>
<head>
    <% Server.Execute("Include.aspx"); %>
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

    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>



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
     
    <style>
            div.scroll {
            height: 500px;
            width: 180px; 
            overflow: scroll;
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
                    <img src="XDel Logo.gif" alt="Xdel Logo" style="height: 36px; width: 36px" /></a>
                <a href="http://localhost:62482/DashBoard" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white" title="DashBoard"><i class="fa fa-area-chart"></i></a>
                <a href="http://localhost:62482/Show" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white" title="Show"><i class="fa fa-info-circle"></i></a>
                <a href="http://localhost:62482/Validate" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white" title="Validate"><i class="fa fa-check"></i></a>
                <a href="http://localhost:62482/Prompt" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white" title="Prompt"><i class="fa fa-bell"></i></a>
                <a href="http://localhost:62482/ManageUser" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white" title="ManageUser"><img src="img\\man-user.png" style="height:20px" alt="user"/></a>
                <a href="http://localhost:62482/ManageCluster" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white" title="ManageCluster"><img src="img\\ukraine.png" style="height:25px" alt="ukraine"/></a>
                <a href="http://localhost:62482/ManageDrivers" class="w3-bar-item w3-button w3-hide-small w3-padding-large w3-hover-white" title="ManageDrivers"><img src="img\\bus-front-with-driver.png" style="height:21px" alt="drivers"/></a>


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

                    

                    <!-- End Left Column -->
                </div>


                <!--Hidden Field for delay table -->
                <asp:HiddenField ID="Delays" runat="server" />


                <!-- Middle Column -->
                <div class="w3-col m10">
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
                                                Driver Name
                                            </th>

                                            <th>
                                                Driver ID
                                            </th>

                                            <th>
                                                Delay ( Hrs,Mins )
                                            </th>

                                            <th>
                                                Arrival Time
                                            </th>

                                            <th>
                                                End Time
                                            </th>

                                            <th>
                                                PU/DL
                                            </th>
                                        </tr>


                                        <% string[] eachDelay = Delays.Value.Split('^');

                                            for (int i = 0; i < eachDelay.Length; i++) { %>

                                        <tr>
                                            <%

                                                if (eachDelay[i].Length != 0)
                                                {
                                                    string[] delaySet = eachDelay[i].Split('*');
                                                    for(int j =0; j< delaySet.Length; j++)
                                                    {%>
                                                        
                                                        <td>
                                                            <%= delaySet[j]%>
                                                        </td>

                                                    <%}
                                                }
                                            %>
                                        </tr>
                                        <%}%>
                                    </table>
                                    
                                </div>
                            </div>
                        </div>
                    </div>

                    <!--Container-->
                    <div class="w3-container w3-card-2 w3-white w3-round w3-margin">

                        <table>

                                        <tr>
                                            <th>
                                                Driver Name
                                            </th>

                                            <th>
                                                Battery Percentage 
                                            </th>
                                            
                                            <th>
                                                Mobile Number 
                                            </th>

                                        </tr>
                            
                            <%   
                                for (int i = 0; i < lowBatts.Count; i++)
                                {
                            %>
                            <tr>

                                <% Try.LukeRefL2.DriverObject lowBattDriver = (Try.LukeRefL2.DriverObject)lowBatts[i]; %>

                                <td>
                                    <%= lowBattDriver.Name %>
                                </td>
                                 <td>
                                    <%= lowBattDriver.BattPCT %>
                                </td>
                                <td>
                                    <%= lowBattDriver.Mobile %>
                                </td>

                            </tr>
                                   

                                
                                <%}%>

                                    </table>


                    </div>

                    <!-- End Middle Column -->
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