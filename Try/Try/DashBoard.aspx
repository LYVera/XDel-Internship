<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DashBoard.aspx.cs" Inherits="Try.DashBoard" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<!DOCTYPE HTML>
<html>
<head>
    <% Server.Execute("Include.aspx"); %>
    <title>RSVP Dashboard</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="Novus Admin Panel Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, 
SmartPhone Compatible web template, free WebDesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
    <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
    <!-- Bootstrap Core CSS -->
    <link href="Scripts/dashboard/css/bootstrap.css" rel='stylesheet' type='text/css' />
    <!-- Custom CSS -->
    <link href="Scripts/dashboard/css/style.css" rel='stylesheet' type='text/css' />
    <!-- font CSS -->
    <!-- font-awesome icons -->
    <link href="Scripts/dashboard/css/font-awesome.css" rel="stylesheet">
    <!-- //font-awesome icons -->
    <!-- js-->
    <script src="Scripts/dashboard/js/jquery-1.11.1.min.js"></script>
    <script src="Scripts/dashboard/js/modernizr.custom.js"></script>
    <!--webfonts-->
    <link href='//fonts.googleapis.com/css?family=Roboto+Condensed:400,300,300italic,400italic,700,700italic' rel='stylesheet' type='text/css'>
    <!--//webfonts-->
    <!--animate-->
    <link href="Scripts/dashboard/css/animate.css" rel="stylesheet" type="text/css" media="all">
    <script src="Scripts/dashboard/js/wow.min.js"></script>
    <script>
        new WOW().init();
    </script>
    <!--//end-animate-->
    <!-- chart -->
    <script src="Scripts/dashboard/js/Chart.js"></script>
    <!-- //chart -->
    <!--Calender-->
    <link rel="Scripts/dashboard/stylesheet" href="css/clndr.css" type="text/css" />
    <script src="Scripts/dashboard/js/underscore-min.js" type="text/javascript"></script>
    <script src="Scripts/dashboard/js/moment-2.2.1.js" type="text/javascript"></script>
    <script src="Scripts/dashboard/js/clndr.js" type="text/javascript"></script>
    <script src="Scripts/dashboard/js/site.js" type="text/javascript"></script>
    <!--End Calender-->
    <!-- Metis Menu -->
    <script src="Scripts/dashboard/js/metisMenu.min.js"></script>
    <script src="Scripts/dashboard/js/custom.js"></script>
    <link href="Scripts/dashboard/css/custom.css" rel="stylesheet">
    <!--//Metis Menu -->
</head>
<body class="cbp-spmenu-push">
    <form id="form1" runat="server">
    <div class="main-content">
        <!--left-fixed -navigation-->
        <div class=" sidebar" role="navigation">
            <div class="navbar-collapse">
                <nav class="cbp-spmenu cbp-spmenu-vertical cbp-spmenu-left" id="cbp-spmenu-s1">
                    <ul class="nav" id="side-menu">
                        <li>
                            <a href="http://localhost:62482/DashBoard" class="active"><i class="fa fa-home nav_icon"></i>Dashboard</a>
                        </li>
                        <li>
                            <a href="http://localhost:62482/Show"><i class="fa fa-cogs nav_icon"></i>SHOW</a>


                        </li>
                        <li class="">
                            <a href="http://localhost:62482/Validate"><i class="fa fa-book nav_icon"></i>VALIDATE </a>


                        </li>
                        <li>
                            <a href="widgets.html"><i class="fa fa-th-large nav_icon"></i>Prompt </a>
                        </li>

                    </ul>
                    <!-- //sidebar-collapse -->
                </nav>
            </div>
        </div>
        <!--left-fixed -navigation-->
        <!-- header-starts -->
        <div class="sticky-header header-section ">
            <div class="header-left">
                <!--toggle button start-->
                <button id="showLeftPush"><i class="fa fa-bars"></i></button>
                <!--toggle button end-->
                <!--logo -->
                <div class="logo">
                    <a href="index.html">
                        <h1>RSVP</h1>
                        <span>dsvp dsvp dsvp</span>
                    </a>
                </div>
                <!--//logo-->

                <div class="clearfix"></div>
            </div>
            <div class="header-right">
                <div class="profile_details_left">
                    <!--notifications of menu start -->
                    <ul class="nofitications-dropdown">
                        <li class="dropdown head-dpdn">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><i class="fa fa-bell"></i>
                                <span class="badge blue">

                                    <%
                                        ArrayList lowBatts = new ArrayList();
                                        lowBatts = (ArrayList)Session["lowBatt"];
                                    %>
                                    <%=lowBatts.Count %>

                                </span></a>
                            <ul class="dropdown-menu">
                                <li>
                                    <div class="notification_header">
                                        <h3>You have <%=lowBatts.Count %> new notification</h3>
                                    </div>
                                </li>

                                <%
                                    for (int i = 0;  i < lowBatts.Count; i++)
                                    {
                                        Try.LukeRefL2.DriverObject lowBattDriver = (Try.LukeRefL2.DriverObject)lowBatts[i];

                                %>
                                <li>
                                    <a href="#">
                                        <div class="notification_desc">
                                            <p><%=lowBattDriver.Name + " " + lowBattDriver.BattPCT + "% Battery "%></p>
                                        </div>
                                        <div class="clearfix"></div>
                                    </a>
                                </li>
                                <%} %>
                            </ul>
                        </li>

                    </ul>
                    <div class="clearfix"></div>
                </div>
                <!--notification menu end -->
                <div class="profile_details">
                    <ul>
                        <li class="dropdown profile_details_drop">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                                <div class="profile_img">
                                    <span class="prfil-img">
                                        <img src="Peter.jpg" alt=""  style="width:40px;height:40px;">
                                    </span>
                                    <div class="user-name">
                                        <p>Peter</p>
                                        <span>Administrator</span>
                                    </div>
                                    <i class="fa fa-angle-down lnr"></i>
                                    <i class="fa fa-angle-up lnr"></i>
                                    <div class="clearfix"></div>
                                </div>
                            </a>
                            <ul class="dropdown-menu drp-mnu">
                                <li><a href="#"><i class="fa fa-sign-out"></i>Logout</a> </li>
                            </ul>
                        </li>
                    </ul>
                </div>
                <div class="clearfix"></div>
            </div>
            <div class="clearfix"></div>
        </div>
        <!-- //header-ends -->
        <!-- main content start-->
        <div id="page-wrapper">
            <div class="main-page">
                <div class="col-md-12 widget-shadow">
                    <br>
                    Customer
                    <asp:DropDownList runat="server">
                        <asp:ListItem Text="All" Value="all"></asp:ListItem>
                        <asp:ListItem Text="Customer classification" Value="custClass"></asp:ListItem>
                        <asp:ListItem Text="Account" Value="acc"></asp:ListItem>
                    </asp:DropDownList>
                    Period
                    <asp:TextBox runat="server" Text="mm/dd/yy"></asp:TextBox>
                    Zone
                    <asp:DropDownList runat="server">
                        <asp:ListItem Text="All" Value="all"></asp:ListItem>
                        <asp:ListItem Text="Group Zone" Value="grpZone"></asp:ListItem>
                        <asp:ListItem Text="Sub group zone" Value="subGrpZone"></asp:ListItem>
                        <asp:ListItem Text="Postal Code" Value="postalCode"></asp:ListItem>
                    </asp:DropDownList>
                    Express Category
                    <asp:DropDownList runat="server">
                        <asp:ListItem Text="All" Value="all"></asp:ListItem>
                        <asp:ListItem Text="Express" Value="express"></asp:ListItem>
                        <asp:ListItem Text="Night" Value="night"></asp:ListItem>
                        <asp:ListItem Text="Same Day" Value="sameDay"></asp:ListItem>
                    </asp:DropDownList>
                    <br>
                </div>
                <div class="clearfix"></div>

                <!--Chart-->
                <div class="charts">
                    <!--Completed Jobs, Ontime/Late-->
                    <asp:HiddenField ID="completedJobsPassFail" runat="server"/>

                    <div class="col-md-4 charts-grids widget">
                         <h4 class="title">Completed Jobs, Ontime/Late</h4>
						<div class="doughnut-grid">
							<canvas id="CompletedJobs" style="width:500px; height: 406px;"></canvas>
						</div>
                    </div>
                    <div class="col-md-4 charts-grids widget states-mdl">
                         <h4 class="title">DIP Jobs, LATE/CLEAR/IN DANGER</h4>
                        <canvas id="pie" height="300" width="400"></canvas>
                    </div>
                    <div class="col-md-4 charts-grids widget">
                       <h4 class="title">Failed Jobs, CustRelated/OpsRelated</h4>
                        <canvas id="FailedJobs" height="300" width="400"></canvas>
                    </div>
                    <div class="clearfix"></div>
                    <script>

                        var CompletedOnTimeLate = [
                            {
                                value: 30,
                                color: "#4F52BA"
                            },
                            {
                                value: 50,
                                color: "#F2B33F"
                            },
                            {
                                value: 100,
                                color: "#585858"
                            }


                        ];


                        var pieData = [
                            {
                                value: 90,
                                color: "rgba(233, 78, 2, 1)",
                                label: "Product 1"
                            },
                            {
                                value: 50,
                                color: "rgba(242, 179, 63, 1)",
                                label: "Product 2"
                            },
                            {
                                value: 60,
                                color: "rgba(88, 88, 88,1)",
                                label: "Product 3"
                            },
                            {
                                value: 40,
                                color: "rgba(79, 82, 186, 1)",
                                label: "Product 4"
                            }

                        ];

                        var FailedData = [
                            {
                                value: 90,
                                color: "rgba(233, 78, 2, 1)",
                                label: "Bad"
                            },
                            {
                                value: 50,
                                color: "rgba(242, 179, 63, 1)",
                                label: "Ops Related"
                            },
                            {
                                value: 60,
                                color: "rgba(88, 88, 88,1)",
                                label: "Failed Attemps"
                            }

                        ];

                        new Chart(document.getElementById("CompletedJobs").getContext("2d")).Doughnut(CompletedOnTimeLate);
                        new Chart(document.getElementById("FailedJobs").getContext("2d")).Pie(FailedData);
                        new Chart(document.getElementById("pie").getContext("2d")).Pie(pieData);

                    </script>

                </div>
                <div class="row">
                     <div class="charts">
                        <div class="col-md-4 stats-info widget">                        
                            <h4 class="title">Time Ext Jobs</h4>
                            <canvas id="TimeExtJobs" height="300" width="400"></canvas>
                        </div>

                         <div class="col-md-4 charts-grids widget states-mdl">
                             <h4 class="title">Type of Service</h4>
                            <canvas id="typeOfSvc" height="300" width="400"></canvas>
                        </div>

                         <div class="col-md-4 stats-info widget">                        
                            <h4 class="title">Time Ext Jobs</h4>
                            <canvas id="TypeOfProduct" height="300" width="400"></canvas>
                        </div>
                    <script>



                        var timeExtData = [
                            {
                                value: 90,
                                color: "rgba(233, 78, 2, 1)",
                                label: "Product 1"
                            },
                            {
                                value: 50,
                                color: "rgba(242, 179, 63, 1)",
                                label: "Product 2"
                            },
                            {
                                value: 60,
                                color: "rgba(88, 88, 88,1)",
                                label: "Product 3"
                            },
                            {
                                value: 40,
                                color: "rgba(79, 82, 186, 1)",
                                label: "Product 4"
                            }

                        ];


                        var svcTypeData = [
                            {
                                value: 90,
                                color: "rgba(233, 78, 2, 1)",
                                label: "Product 1"
                            },
                            {
                                value: 50,
                                color: "rgba(242, 179, 63, 1)",
                                label: "Product 2"
                            },
                            {
                                value: 60,
                                color: "rgba(88, 88, 88,1)",
                                label: "Product 3"
                            },
                            {
                                value: 40,
                                color: "rgba(79, 82, 186, 1)",
                                label: "Product 4"
                            }

                        ];


                        var prodTypeData = [
                            {
                                value: 90,
                                color: "rgba(233, 78, 2, 1)",
                                label: "Product 1"
                            },
                            {
                                value: 50,
                                color: "rgba(242, 179, 63, 1)",
                                label: "Product 2"
                            },
                            {
                                value: 60,
                                color: "rgba(88, 88, 88,1)",
                                label: "Product 3"
                            },
                            {
                                value: 40,
                                color: "rgba(79, 82, 186, 1)",
                                label: "Product 4"
                            }

                        ];



                        new Chart(document.getElementById("TimeExtJobs").getContext("2d")).Pie(timeExtData);
                        new Chart(document.getElementById("typeOfSvc").getContext("2d")).Pie(svcTypeData);
                        new Chart(document.getElementById("TypeOfProduct").getContext("2d")).Pie(prodTypeData);

                    </script>
</div>
    </div>
    <!-- end of box -->

                    <div class="clearfix"></div>
                </div>
                <div class="row">
                    
                <div class="clearfix"></div>
            </div>
           
                
                <div class="charts">
                    <div class="col-md-4 charts-grids barWidth">
                        <h4 class="title">Bar Chart Example</h4>
                        <canvas id="bar" height="10" width="30"></canvas>
                    </div>
                    <script>
                        var barChartData = {
                            labels: ["January", "February", "March", "April", "May", "June", "July"],
                            datasets: [
                                {
                                    fillColor: "rgba(233, 78, 2, 0.83)",
                                    strokeColor: "#ef553a",
                                    highlightFill: "#ef553a",
                                    data: [65, 59, 90, 81, 56, 55, 40]
                                },
                                {
                                    fillColor: "rgba(79, 82, 186, 0.83)",
                                    strokeColor: "#4F52BA",
                                    highlightFill: "#4F52BA",
                                    data: [50, 65, 60, 50, 70, 70, 80]
                                },
                                {
                                    fillColor: "rgba(88, 88, 88, 0.83)",
                                    strokeColor: "#585858",
                                    highlightFill: "#585858",
                                    data: [28, 48, 40, 19, 96, 27, 100]
                                }
                            ]

                        };

                        new Chart(document.getElementById("bar").getContext("2d")).Bar(barChartData);
                      </script>
                    </div>
            <div class="clearfix"></div>
            </div>
        </div>
        <!--footer-->
        <div class="footer">
            <p>&copy; 2016 Novus Admin Panel. All Rights Reserved | Design by <a href="https://w3layouts.com/" target="_blank">w3layouts</a></p>
        </div>
        <!--//footer-->
    </div>
    <!-- Classie -->
    <script src="Scripts/dashboard/js/classie.js"></script>
    <script>
                        var menuLeft = document.getElementById('cbp-spmenu-s1'),
                            showLeftPush = document.getElementById('showLeftPush'),
                            body = document.body;

                        showLeftPush.onclick = function () {
                            classie.toggle(this, 'active');
                            classie.toggle(body, 'cbp-spmenu-push-toright');
                            classie.toggle(menuLeft, 'cbp-spmenu-open');
                            disableOther('showLeftPush');
                        };


                        function disableOther(button) {
                            if (button !== 'showLeftPush') {
                                classie.toggle(showLeftPush, 'disabled');
                            }
                        }
    </script>
    <!--scrolling js-->
    <script src="Scripts/dashboard/js/jquery.nicescroll.js"></script>
    <script src="Scripts/dashboard/js/scripts.js"></script>
    <!--//scrolling js-->
    <!-- Bootstrap Core JavaScript -->
    <script src="Scripts/dashboard/js/bootstrap.js"> </script>
        </form>
</body>
</html>
