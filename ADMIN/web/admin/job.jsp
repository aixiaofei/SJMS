<%@ page import="org.ahu.edu.bigdatalab.scm.model.Admin" %>
<%@ page import="org.ahu.edu.bigdatalab.scm.helper.SparkHelper" %>
<%@ page import="java.util.List" %>
<%@ page import="org.ahu.edu.bigdatalab.scm.bean.Job" %>
<%@ page import="org.ahu.edu.bigdatalab.scm.model.Note" %><%--
  Created by IntelliJ IDEA.
  User: WangJiang
  Date: 2016/7/11
  Time: 13:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>AdminSJMS | 任务管理</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.6 -->
    <link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="../cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
    <!-- DataTables -->
    <link rel="stylesheet" href="../plugins/datatables/dataTables.bootstrap.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="../dist/css/AdminLTE.min.css">
    <!-- AdminLTE Skins. Choose a skin from the css/skins
         folder instead of downloading all of them to reduce the load. -->
    <link rel="stylesheet" href="../dist/css/skins/_all-skins.min.css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body class="hold-transition skin-blue sidebar-mini">

<%
    Admin admin = (Admin)request.getSession().getAttribute("admin");
    SparkHelper sparkHelper = new SparkHelper();
    List<Job> listRunning = sparkHelper.getRunningJobs();
    List<Job> listFinished = sparkHelper.getFinishedJobs();

    List<Note> notesList = Note.DAO.getTop5Notes();
%>

<div class="wrapper">

    <header class="main-header">
        <!-- Logo -->
        <a href="" class="logo">
            <!-- mini logo for sidebar mini 50x50 pixels -->
            <span class="logo-mini">SJMS</span>
            <!-- logo for regular state and mobile devices -->
            <span class="logo-lg"><b>Admin</b>SJMS</span>
        </a>
        <!-- Header Navbar: style can be found in header.less -->
        <nav class="navbar navbar-static-top">
            <!-- Sidebar toggle button-->
            <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </a>

            <div class="navbar-custom-menu">
                <ul class="nav navbar-nav">
                    <!-- Messages: style can be found in dropdown.less-->
                    <li class="dropdown notifications-menu">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <i class="fa fa-bell-o"></i>
                        </a>
                        <ul class="dropdown-menu">
                            <li class="header">共<%=Note.DAO.getCountOfNotes()%>条通告通知</li>
                            <li>
                                <!-- inner menu: contains the actual data -->
                                <ul class="menu">
                                    <%
                                        for (Note note : notesList) {
                                            String iconClass = "fa fa-bell text-aqua";
                                            String content = note.get(Note.content);
                                            if (Note.LOGIN_ENABLE.equals(content)) {
                                                iconClass = "fa fa-user text-green";
                                            } else if (Note.LOGIN_DISABLE.equals(content)) {
                                                iconClass = "fa fa-user-times text-red";
                                            } else if (Note.JOB_ENABLE.equals(content)) {
                                                iconClass = "fa fa-unlock text-green";
                                            } else if (Note.JOB_DISABLE.equals(content)) {
                                                iconClass = "fa fa-lock text-red";
                                            }
                                    %>
                                    <li>
                                        <a href="sys-note-view.jsp?id=<%=note.get(Note.id)%>">
                                            <i class="<%=iconClass%>"></i> <%=note.get(Note.title)%>
                                        </a>
                                    </li>
                                    <% } %>
                                </ul>
                            </li>
                            <li class="footer"><a href="sys-note.jsp">查看所有</a></li>
                        </ul>
                    </li>

                    <!-- User Account: style can be found in dropdown.less -->
                    <li class="dropdown user user-menu">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <img src="/upload/photo/<%=admin.get(Admin.photo)%>" class="user-image" alt="User Image">
                            <span class="hidden-xs"><%=admin.get(Admin.name)%></span>
                        </a>
                        <ul class="dropdown-menu">
                            <!-- User image -->
                            <li class="user-header">
                                <img src="/upload/photo/<%=admin.get(Admin.photo)%>" class="img-circle" alt="User Image"/>
                                <p><font size="5"><%=admin.get(Admin.name)%></font></p>
                            </li>
                            <!-- Menu Body -->

                            <!-- Menu Footer-->
                            <li class="user-footer">
                                <div class="pull-left">
                                    <a href="javascript:selfInfo()" class="btn btn-default btn-flat">资料</a>
                                </div>
                                <div class="pull-right">
                                    <a href="../logout" class="btn btn-default btn-flat">注销</a>
                                </div>
                            </li>
                        </ul>
                    </li>
                    <!-- Control Sidebar Toggle Button -->
                    <li>
                        <a href="#" data-toggle="control-sidebar"><i class="fa fa-gears"></i></a>
                    </li>
                </ul>
            </div>
        </nav>
    </header>

    <!-- Left side column. contains the logo and sidebar -->
    <aside class="main-sidebar">
        <!-- sidebar: style can be found in sidebar.less -->
        <section class="sidebar">
            <!-- Sidebar user panel -->
            <div class="user-panel">
                <div class="pull-left image">
                    <img src="../img/photo/<%=admin.get(Admin.photo)%>" class="img-circle" alt="User Image"/>
                </div>
                <div class="pull-left info">
                    <h4><%=admin.get(Admin.name)%></h4>
                </div>
            </div>

            <!-- sidebar menu: : style can be found in sidebar.less -->
            <ul class="sidebar-menu">
                <li class="header">集群管理</li>
                <li>
                    <a href="index">
                        <i class="fa fa-dashboard"></i> <span>集群概览</span>
                    </a>
                </li>
                <li>
                    <a href="cluster">
                        <i class="fa fa-list-ul"></i> <span>节点列表</span>
                    </a>
                </li>
                <li class="header">用户</li>
                <li>
                    <a href="user">
                        <i class="fa fa-user"></i> <span>用户管理</span>
                    </a>
                </li>
                <li class="active">
                    <a href="job">
                        <i class="fa fa-table"></i> <span>任务管理</span>
                    </a>
                </li>
                <li>
                    <a href="hdfs">
                        <i class="fa fa-folder"></i> <span>HDFS管理</span>
                    </a>
                </li>
                <li class="header">系统管理</li>
                <li>
                    <a href="sys">
                        <i class="fa fa-cog"></i> <span>系统设置</span>
                    </a>
                </li>
                <li>
                    <a href="admin">
                        <i class="fa fa-user-secret"></i> <span>管理员设置</span>
                    </a>
                </li>
                <li>
                    <a href="info">
                        <i class="fa fa-info-circle"></i> <span>系统信息</span>
                    </a>
                </li>
            </ul>
        </section>
        <!-- /.sidebar -->
    </aside>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                任务管理
                <small>显示所有任务状态信息</small>
            </h1>
            <ol class="breadcrumb">
                <li><i class="fa fa-dashboard"></i> 用户</li>
                <li class="active">任务管理</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content">

            <div class="row">
                <div class="col-xs-12">
                    <div class="box">
                        <div class="box-header">
                            <h3 class="box-title">正在运行的任务</h3>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            <table id="running_list" class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>任务ID</th>
                                        <th>名称</th>
                                        <th>CPU核数</th>
                                        <th>每个节点的内存数</th>
                                        <th>提交时间</th>
                                        <th>用户</th>
                                        <th>状态</th>
                                        <th>运行时间</th>
                                        <th>操作</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <%
                                    for (Job job : listRunning) {
                                %>
                                    <tr>
                                        <td><a href="#"><%=job.getId()%> </a></td>
                                        <td><a href="#"><%=job.getName()%></a></td>
                                        <td><%=job.getCores()%></td>
                                        <td><%=job.getMemoryPerNode()%></td>
                                        <td><%=job.getSubmittedTime()%></td>
                                        <td><a href="javascript:userInfo(0)"><%=job.getUser()%></a></td>
                                        <td>运行中</td>
                                        <td><%=job.getDuration()%></td>
                                        <td><div class="btn-group">
                                            <button type="button" class="btn btn-default" onclick="jobStop('<%=job.getId()%>')"><i class="fa  fa-close"></i> 结束任务</button>
                                        </div>
                                        </td>
                                    </tr>
                                <% } %>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <th>任务ID</th>
                                        <th>名称</th>
                                        <th>CPU核数</th>
                                        <th>每个节点的内存数</th>
                                        <th>提交时间</th>
                                        <th>用户</th>
                                        <th>状态</th>
                                        <th>运行时间</th>
                                        <th>操作</th>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                        <!-- /.box-body -->
                    </div>
                    <!-- /.box -->
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->

            <div class="row">
                <div class="col-xs-12">
                    <div class="box">
                        <div class="box-header">
                            <h3 class="box-title">结束的任务</h3>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            <table id="finished_list" class="table table-bordered table-hover">
                                <thead>
                                    <tr>
                                        <th>任务ID</th>
                                        <th>名称</th>
                                        <th>CPU核数</th>
                                        <th>每个节点的内存数</th>
                                        <th>提交时间</th>
                                        <th>用户</th>
                                        <th>状态</th>
                                        <th>运行时间</th>
                                        <th>操作</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <%
                                    for (Job job : listFinished) {
                                %>
                                    <tr>
                                        <td><a href="#"><%=job.getId()%> </a></td>
                                        <td><a href="#"><%=job.getName()%></a></td>
                                        <td><%=job.getCores()%></td>
                                        <td><%=job.getMemoryPerNode()%></td>
                                        <td><%=job.getSubmittedTime()%></td>
                                        <td><a href="javascript:userInfo(0)"><%=job.getUser()%></a></td>
                                        <td>结束</td>
                                        <td><%=job.getDuration()%></td>
                                        <td>
                                            <div class="btn-group">
                                                <button type="button" class="btn btn-default disabled"><i class="fa  fa-close"></i> 结束任务</button>
                                            </div>
                                        </td>
                                    </tr>
                                <% } %>
                                </tbody>
                                <tfoot>
                                    <tr>
                                        <th>任务ID</th>
                                        <th>名称</th>
                                        <th>CPU核数</th>
                                        <th>每个节点的内存数</th>
                                        <th>提交时间</th>
                                        <th>用户</th>
                                        <th>状态</th>
                                        <th>运行时间</th>
                                        <th>操作</th>
                                    </tr>
                                </tfoot>
                            </table>
                        </div>
                        <!-- /.box-body -->
                    </div>
                    <!-- /.box -->
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->

        </section>
        <!-- /.content -->
    </div>
    <!-- /.content-wrapper -->
    <footer class="main-footer">
        <div class="pull-right hidden-xs">
            <b>版本：</b> 0.0.1
        </div>
        <strong>Copyright &copy; 2016 <a href="http://bigdata.ahu.edu.cn/" target="_blank">安徽大学云计算与大数据实验室</a>.</strong> All rights reserved.
    </footer>

    <!-- Control Sidebar -->
    <aside class="control-sidebar control-sidebar-dark">
        <!-- Create the tabs -->
        <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
            <li><a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-question"></i></a></li>
        </ul>
        <!-- Tab panes -->
        <div class="tab-content">
            <!-- Home tab content -->
            <div class="tab-pane" id="control-sidebar-home-tab">
                <h3 class="control-sidebar-heading">简单的帮助</h3>
                <ul class="control-sidebar-menu">
                    <li>
                        <a href="javascript:void(0)">
                            <i class="menu-icon fa fa-book bg-blue"></i>
                            <div class="menu-info">
                                <h4 class="control-sidebar-subheading">关于页面设置</h4>
                                <p>如果页面设置出现异常，可以尝试刷新页面或者删除浏览器的cookie数据</p>
                            </div>
                        </a>
                    </li>
                </ul>
                <!-- /.control-sidebar-menu -->
            </div>
            <!-- /.tab-pane -->

        </div>
    </aside>
    <!-- /.control-sidebar -->
    <!-- Add the sidebar's background. This div must be placed
         immediately after the control sidebar -->
    <div class="control-sidebar-bg"></div>
</div>
<!-- ./wrapper -->

<!-- jQuery 2.2.3 -->
<script src="../plugins/jQuery/jquery-2.2.3.min.js"></script>
<!-- Bootstrap 3.3.6 -->
<script src="../bootstrap/js/bootstrap.min.js"></script>
<!-- DataTables -->
<script src="../plugins/datatables/jquery.dataTables.min.js"></script>
<script src="../plugins/datatables/dataTables.bootstrap.min.js"></script>
<!-- SlimScroll -->
<script src="../plugins/slimScroll/jquery.slimscroll.min.js"></script>
<!-- FastClick -->
<script src="../plugins/fastclick/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="../dist/js/app.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../dist/js/demo.js"></script>
<!-- page script -->
<script>
    $(function () {
        //初始化表格属性
        var option = {
            "paging": true,	//是否分页
            "lengthChange": true,
            "searching": false,
            "ordering": true,
            "info": true,	//是否显示分页的信息
            "autoWidth": false,
            "oLanguage": {
                "sLengthMenu": "每页显示 _MENU_ 条记录",
                "sZeroRecords": "抱歉，没有找到",
                "sInfo": "从 _START_ 到 _END_ 共 _TOTAL_ 条数据",
                "sInfoEmpty": "没有数据",
                "sInfoFiltered": "(从 _MAX_ 条数据中检索)",
                "oPaginate": {
                    "sFirst": "首页",
                    "sPrevious": "前一页",
                    "sNext": "后一页",
                    "sLast": "尾页"
                },
                "sZeroRecords": "没有检索到数据",
                "sProcessing": "<img src='./loading.gif' />"
            }
        }

        $('#running_list').DataTable(option);
        $('#finished_list').DataTable(option);
    });

    var sparkURL = "<%=SparkHelper.SPARK_URL%>";    //sparkURL的位置，在结束任务的时候需要该值

    /**
     * js动态生成表单
     * 后台提交表单
     * @param id
     */
    function funPostBack(jobId){
        if(document.getElementById("SMAL") != null) {
            document.getElementById("SMAL").remove();//首先删除
        }
        var form ="<form action='<%=SparkHelper.SPARK_URL%>app/kill/' method='post'>" +
                "<input type='hidden' name='id' value=''/> " +
                "<input type='hidden' name='terminate' value='true'>"+
                "</form> ";
        $("body").append("<iframe id='SMAL' name='SMAL' style='display: none'></iframe>");//载入iframe
        $( "#SMAL" ).contents().find('body').html(form);//将form表单塞入iframe;
        $( "#SMAL" ).contents().find("form input[name='id']").val(jobId);
        $( "#SMAL" ).contents().find('form').submit();

        location.reload(true);	//刷新页面
    }

</script>

<!--对话框-->
<script type="text/javascript" src="../layer/layer.js" ></script>
<script type="text/javascript" src="../js/dialog.js" ></script>
</body>
</html>
