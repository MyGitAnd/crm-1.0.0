<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" +
            request.getServerPort() + request.getContextPath();
%>
<html>
<head>
    <title>客户和联系人统计报表</title>
    <!-- 引入 echarts.js -->
    <script type="text/javascript" src="<%=basePath%>/jquery/jquery-1.11.1-min.js"></script>
    <script src="<%=basePath%>/jquery/ECharts/echarts.min.js"></script>
</head>
<body>
<!-- 为ECharts准备一个具备大小（宽高）的Dom -->
<div id="bar" style="width: 1200px;height:400px;"></div>
<div id="pie" style="width: 800px;height:400px;"></div>
<script>

    $.ajax({
        url:"<%=basePath%>/workbench/chartTran/pieCustomer",
        type:"get",
        dataType:"json",
        success:function (data) {
            var chartDom = document.getElementById('pie');
            var myChart = echarts.init(chartDom);
            var option;

            option = {

                title: {
                    text: '客户和联系人统计图表',
                    subtext: '统计图表',
                    left: 'center'
                },
                tooltip: {
                    trigger: 'item'
                },
                legend: {
                    orient: 'vertical',
                    left: 'left',
                },
                series: [
                    {
                        name: '业务阶段',
                        type: 'pie',
                        radius: '80%',
                        data: data,
                        emphasis: {
                            itemStyle: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        }
                    }
                ]
            };

            option && myChart.setOption(option);
        }
    });


    $.ajax({
        url:"<%=basePath%>/workbench/chartTran/barCustomer",
        type:"get",
        dataType:"json",
        success:function (data) {


            var chartDom = document.getElementById('bar');
            var myChart = echarts.init(chartDom);
            var option;

            option = {
                xAxis: {
                    type: 'category',
                    data: data.titles
                },
                yAxis: {
                    type: 'value'
                },
                series: [{
                    data: data.data,
                    type: 'bar',
                    showBackground: true,
                    backgroundStyle: {
                        color: 'rgba(180, 180, 180, 0.2)'
                    }
                }]
            };

            option && myChart.setOption(option);

        }
    });



</script>
</body>
</html>
