<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>修改博客页面</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/wangEditor/iplugins/wangEditor_fullscreen_plugin.css">

    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>

<%--    wangEditor--%>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/wangEditor/wangEditor-2.1.23.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/wangEditor/iplugins/wangEditor_fullscreen_plugin.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/xss/xss.js"></script>



    <script type="text/javascript">

        /**发布博客*/
        function submitData(){
            var title=$("#title").val();
            var blogTypeId=$("#blogTypeId").combobox("getValue");
            var content = editor.txt.html();
            content = filterXSS(content)  // 此处进行 xss 攻击过滤
            var keyWord=$("#keyWord").val();

            if(title==null || title==''){
                $.messager.alert("系统提示","请输入标题！");
            }else if(blogTypeId==null || blogTypeId==''){
                $.messager.alert("系统提示","请输入博客类别！");
            }else if(content==null || content==''){
                $.messager.alert("系统提示","请输入内容！");
            }else{
                $.post("${pageContext.request.contextPath}/admin/blog/save.do",
                    {'id':'${param.id}','title':title,'blogType.id':blogTypeId,'content':content,
                        'contentNoTag':editor.txt.text(),
                        'summary':editor.txt.text().substr(0,155),'keyWord':keyWord},
                    function(result){
                        if(result.success){
                            $.messager.alert("系统提示","博客发布成功！");
                        }else{
                            $.messager.alert("系统提示","博客发布失败！");
                        }
                    },"json");
            }
        }
    </script>
</head>
<body style="margin: 10px">
<div id="p" class="easyui-panel" title="修改博客" style="padding: 10px">
    <table cellspacing="20px">
        <tr>
            <td width="80px">博客标题：</td>
            <td><input type="text" id="title" name="title" style="width: 400px;"/></td>
        </tr>
        <tr>
            <td>所属类别：</td>
            <td>
                <select class="easyui-combobox"  id="blogTypeId" name="blogType.id" style="width: 154px;" editable="false" panelHeight="auto">
                    <option value="">请选择博客类别...</option>
                    <c:forEach var="blogType" items="${blogTypeCountList}">
                        <option value="${blogType.id}">${blogType.typeName}</option>
                    </c:forEach>
                </select>
            </td>
        </tr>
        <tr>
            <td>博客内容：</td>
            <td>
                <div id="editor"></div>
            </td>
        </tr>
        <tr>
            <td>关键字：</td>
            <td><input type="text" id="keyWord" name="keyWord" style="width: 400px;"/>
                &nbsp;(多个关键字中间用空格隔开)</td>
        </tr>
        <tr>
            <td></td>
            <td><a href="javascript:submitData()" class="easyui-linkbutton" data-options="iconCls:'icon-submit'">发布博客</a></td>
        </tr>
    </table>
</div>
<script type="text/javascript">
    var E = window.wangEditor;
    var editor = new E('#editor');
    // 或者 var editor = new E( document.getElementById('editor') )
    editor.customConfig.zIndex = 100;
    //插入网络图片回调
    editor.customConfig.linkImgCallback = function (url) {
        console.log(url); //TODO: url 即插入图片的地址
    }

    //TODO:插入链接校验
    editor.customConfig.linkCheck = function (text, link) {
        console.log(text); // 插入的文字
        console.log(link); // 插入的链接
        return true // 返回 true 表示校验成功
        // return '验证失败' // 返回字符串，即校验失败的提示信息
    }

    //TODO:插入网络图片时，可对图片地址做自定义校验
    editor.customConfig.linkImgCheck = function (src) {
        console.log(src); // 图片的链接
        return true; // 返回 true 表示校验成功
        // return '验证失败' // 返回字符串，即校验失败的提示信息
    }

    // editor.customConfig.uploadImgShowBase64 = true   // 使用 base64 保存图片
    // TODO:配置服务器端地址
    editor.customConfig.uploadImgServer = '${pageContext.request.contextPath}/com.blog.upload/images.do';

    //TODO：其他上传设置
    // 将图片大小限制为 3M
    editor.customConfig.uploadImgMaxSize = 3 * 1024 * 1024;

    // 限制一次最多上传 5 张图片
    editor.customConfig.uploadImgMaxLength = 5;

    //TODO:自定义 fileName
    editor.customConfig.uploadFileName = 'myFileName';

    // 将 timeout 时间改为 3s
    editor.customConfig.uploadImgTimeout = 3000;

    //TODO:监听函数
    editor.uploadImgHooks = {
        success: function (xhr, editor, result) {
            // 图片上传并返回结果，图片插入成功之后触发
            // xhr 是 XMLHttpRequst 对象，editor 是编辑器对象，result 是服务器端返回的结果
            console.log("插入图片成功　success result = " + result.errno + "  path = " + result.data[0] );
        },

        fail: function fail(xhr, editor, result) {
            console.log(" fail result = " + result.errno + "  path = " + result.data[0] );
            // 图片上传并返回结果，但图片插入错误时触发
        },
        error: function error(xhr, editor) {
            // 图片上传出错时触发
            console.log("error result = " + result.errno + "  path = " + result.data[0] );
        },
        timeout: function timeout(xhr, editor) {
            // 图片上传超时时触发
            console.log("timeout result = " + result.errno + "  path = " + result.data );
        },

        customInsert: function (insertImg, result, editor) {
            // 图片上传并返回结果，自定义插入图片的事件（而不是编辑器自动插入图片！！！）
            // insertImg 是插入图片的函数，editor 是编辑器对象，result 是服务器端返回的结果

            // 举例：假如上传图片成功后，服务器端返回的是 {url:'....'} 这种格式，即可这样插入图片：
            var urls = result.data;
            alert("customInsert:" + urls);
            for (var url in urls) {
                insertImg(url)
            }
            // result 必须是一个 JSON 格式字符串！！！否则报错
        }
    }
    editor.create();
    E.fullscreen.init('#editor');

    //请求数据：
    $.ajax({
        url: "${pageContext.request.contextPath}/admin/blog/findById.do",
        type:"get",
        data:{'id':'${param.id}'},
        success:function (result){
            result = eval("("+result+")");
            $("#title").val(result.title);
            $("#keyWord").val(result.keyWord);
            $("#blogTypeId").combobox("setValue",result.blogType.id);
            editor.txt.html(result.content);
        },
        error:function () {
            $.messager.alert("系统提示","博客获取失败！");
        },
        dateType:"json"
    });
</script>
</body>
</html>