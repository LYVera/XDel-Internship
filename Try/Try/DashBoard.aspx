<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DashBoard.aspx.cs" Inherits="Try.DashBoard" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <link rel="icon" type="image/png" href="assets/img/favicon.ico">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />

    <title>RSVP DashBoard</title>

    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0' name='viewport' />
    <meta name="viewport" content="width=device-width" />


    <!-- Bootstrap core CSS     -->
    <link href="Scripts/assets/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Animation library for notifications   -->
    <link href="Scripts/assets/css/animate.min.css" rel="stylesheet" />

    <!--  Light Bootstrap Table core CSS    -->
    <link href="Scripts/assets/css/light-bootstrap-dashboard.css" rel="stylesheet" />


    <!--  CSS for Demo Purpose, don't include it in your project     -->
    <%--<link href="Scripts/assets/css/demo.css" rel="stylesheet" />--%>


    <!--     Fonts and icons     -->
    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Roboto:400,700,300' rel='stylesheet' type='text/css'>
    <link href="Scripts/assets/css/pe-icon-7-stroke.css" rel="stylesheet" />

</head>
<body>

    <div class="wrapper">
        <div class="sidebar" data-color="orange" data-image="assets/img/sidebar-5.jpg">

            <!--

        Tip 1: you can change the color of the sidebar using: data-color="blue | azure | green | orange | red | purple"
        Tip 2: you can also add an image using data-image tag

    -->

            <div class="sidebar-wrapper">
                <div class="logo">
                    <a href="#" class="simple-text">RSVP
                    </a>
                </div>

                <ul class="nav">
                    <li class="active">
                        <a href="dashboard.html">
                            <i class="pe-7s-graph"></i>
                            <p>Dashboard</p>
                        </a>
                    </li>
                    <li>
                        <a href="http://localhost:62482/Show">
                            <i class="pe-7s-user"></i>
                            <p>Show Map</p>
                        </a>
                    </li>
                    <li>
                        <a href="http://localhost:62482/Validate">
                            <i class="pe-7s-note2"></i>
                            <p>Validate</p>
                        </a>
                    </li>
                    <li>
                        <a href="http://localhost:62482/Prompt">
                            <i class="pe-7s-news-paper"></i>
                            <p>Prompt</p>
                        </a>
                    </li>
                    <li>
                        <a href="maps.html">
                            <i class="pe-7s-map-marker"></i>
                            <p>Maps</p>
                        </a>
                    </li>
                </ul>
            </div>
        </div>

        <div class="main-panel">
            <nav class="navbar navbar-default navbar-fixed">
                <div class="container-fluid">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navigation-example-2">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a class="navbar-brand" href="#">Dashboard</a>
                    </div>
                    <div class="collapse navbar-collapse">
                        <ul class="nav navbar-nav navbar-left">
                            <li>
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                    <i class="fa fa-dashboard"></i>
                                    <p class="hidden-lg hidden-md">Dashboard</p>
                                </a>
                            </li>
                            <li class="dropdown">
                                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                    <i class="pe-7s-battery"></i>
                                    <!-- to do battery icon -->
                                    <b class="caret hidden-sm hidden-xs"></b>
                                    <span class="notification hidden-sm hidden-xs">
                                        <%
                                            ArrayList lowBatts = new ArrayList();
                                            lowBatts = (ArrayList)Session["lowBatt"];
                                        %>
                                        <%=lowBatts.Count %>

                                    </span>
                                    <p class="hidden-lg hidden-md">


                                        <b class="caret"></b>
                                    </p>
                                </a>
                                <ul class="dropdown-menu">

                                    <%
                                        for (int i = 0; i < lowBatts.Count; i++)
                                        {
                                            Try.LukeRefL2.DriverObject lowBattDriver = (Try.LukeRefL2.DriverObject)lowBatts[i];
                                    %>
                                    <li><a href="#"><%=lowBattDriver.Name + " " + lowBattDriver.BattPCT + "% Battery "%></a></li>
                                    <%} %>
                                </ul>
                            </li>

                        </ul>

                        <ul class="nav navbar-nav navbar-right">
                            <li>
                                <a href="#">
                                    <p>Account</p>
                                </a>
                            </li>

                            <li>
                                <a href="#">
                                    <p>Log out</p>
                                </a>
                            </li>
                            <li class="separator hidden-lg hidden-md"></li>
                        </ul>
                    </div>
                </div>
            </nav>


            <div class="content">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="card">
                                <div class="header">
                                    <h4 class="title">Jobs</h4>
                                    <p class="category">OK/DIP/Outstanding</p>
                                </div>
                                <div class="content">
                                    <div id="chartPreferences" class="ct-chart ct-perfect-fourth"></div>

                                    <div class="footer">
                                        <div class="legend">
                                            <i class="fa fa-circle text-info"></i>OK
                                       
                                            <i class="fa fa-circle text-danger"></i>Outstanding
                                       
                                            <i class="fa fa-circle text-warning"></i>DIP
                                   
                                        </div>
                                        <hr>
                                        <div class="stats">
                                            <i class="fa fa-clock-o"></i>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-8">
                            <div class="card">
                                <div class="header">
                                    <h4 class="title">Delivery Performance</h4>
                                    <p class="category">24 Hours performance</p>
                                </div>
                                <div class="content">
                                    <div id="chartHours" class="ct-chart"></div>
                                    <div class="footer">
                                        <div class="legend">
                                            <i class="fa fa-circle text-info"></i>OK
                                       
                                            <i class="fa fa-circle text-danger"></i>Outstanding
                                       
                                            <i class="fa fa-circle text-warning"></i>DIP
                                   
                                        </div>
                                        <hr>
                                        <div class="stats">
                                            <i class="fa fa-history"></i>Updated 3 minutes ago
                                   
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
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
                    

                    <div class="row">
                        <div class="col-md-12">
                            <div class="card ">
                                <div class="header">
                                    <button class="btn btn-info btn-fill pull-right" onclick="openTabs('Best10Tab');return false">Top 10 Best Driver</button>
                                    <button class="btn btn-info btn-fill pull-right" onclick="openTabs('Worst10Tab');return false">Top 10 Worst Driver</button>
                                    <h4 class="title">Driver Points</h4>
                                    <p class="category">Driver rankings</p>
                                </div>

                                <div class="content">
                                    <div id="Best10Tab" class="tab">
                                        <div id="chartActivity" class="ct-chart"></div>
                                    </div>
                                    <div id="Worst10Tab" class="tab">                                      
                                            <div id="chartWorst" class="ct-chart"></div>
                                    </div>

                                    <div class="footer">
                                        <div class="legend">
                                            <i class="fa fa-circle text-info"></i>Points
                                        </div>
                                        <hr>
                                        <div class="stats">
                                            <i class="fa fa-check"></i>Points points points 
                                        </div>
                                    </div>
                                </div>





                            </div>
                        </div>




                    </div>
                </div>
            </div>
        </div>
    </div>
  


            <footer class="footer">
                <div class="container-fluid">
                </div>
            </footer>

   

</body>

<!--   Core JS Files   -->
<script src="Scripts/assets/js/jquery-1.10.2.js" type="text/javascript"></script>
<script src="Scripts/assets/js/bootstrap.min.js" type="text/javascript"></script>

<!--  Checkbox, Radio & Switch Plugins -->
<script src="Scripts/assets/js/bootstrap-checkbox-radio-switch.js"></script>

<!--  Charts Plugin -->
<script src="Scripts/assets/js/chartist.min.js"></script>

<!--  Notifications Plugin    -->
<script src="Scripts/assets/js/bootstrap-notify.js"></script>

<!--  Google Maps Plugin    -->
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>

<!-- Light Bootstrap Table Core javascript and methods for Demo purpose -->
<script src="Scripts/assets/js/light-bootstrap-dashboard.js"></script>

<!-- Light Bootstrap Table DEMO methods, don't include it in your project! -->
<script src="Scripts/assets/js/chart.js"></script>



<script type="text/javascript">


    $(document).ready(function () {

        demo.initChartist();

        $.notify({
            icon: 'pe-7s-gift',
            message: "Welcome to <b>RSVP Dashboard</b>"

        }, {
                type: 'info',
                timer: 4000
            });

    });
</script>

</html>

