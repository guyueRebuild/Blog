<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>修改博客页面</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/icon.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/editor.md-master/css/editormd.min.css"/>

    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
    <script src="${pageContext.request.contextPath}/static/editor.md-master/editormd.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/blog.js"></script>
    <script type="text/javascript">

        /**请求数据：*/
        $.ajax({
            url: "${pageContext.request.contextPath}/admin/blog/findById.do",
            type:"get",
            data:{'id':'${param.id}'},
            success:function (result){
                result = eval("("+result+")");
                $("#title").val(result.title);
                $("#keyWord").val(result.keyWord);
                $("#blogTypeId").combobox("setValue",result.blogType.id);
                $("#description").val(result.content);

            },
            error:function () {
                $.messager.alert("系统提示","博客获取失败！");
            },
            dateType:"json"
        });

        /**初始化marckdown*/
        var mdEditor;
        $(function () {
            mdEditor = editormd("blog-editor", {
                width: "100%",
                height: "350",
                path: getRootPath() + "/static/editor.md-master/lib/",
                watch: true,
                placeholder: "详细补充您的问题内容，并确保问题描述清晰直观，并提供一下相关的资料",
                saveHTMLToTextarea: true,
                imageUpload: true,
                imageFormats: ["jpg", "jpeg", "gif", "png", "bmp", "webp"],
                imageUploadURL: getRootPath() + "/upload/image.do"
            });
        });

    </script>


</head>
<body style="margin: 10px">
<div id="p" class="easyui-panel" title="修改博客" style="padding: 10px">

    <div>
        <input type="hidden" id="blogId" value="${param.id}">
        <h4><label for="title">博客标题：</label></h4>
        <input type="text" id="title" name="title" style="width: 400px;"/>
        <h4><label for="blogTypeId">所属类别：</label></h4>
        <select class="easyui-combobox" id="blogTypeId" name="blogTypeId" style="width: 154px;"
                editable="false" panelHeight="auto">
            <option value="">请选择博客类别...</option>
            <c:forEach var="blogType" items="${blogTypeCountList}">
                <option value="${blogType.id}">${blogType.typeName}</option>
            </c:forEach>
        </select>
        <h4>博客内容：</h4>
        <div id="blog-editor">
            <label for="description">问题补充（必填，请参照右侧提示):</label>
            <textarea id="description" style="display:none;" cols="30" rows="10"></textarea>
        </div>
        <h4><label for="keyWord">关键字：</label></h4>
        <input type="text" id="keyWord" name="keyWord" style="width: 400px;"/>
        &nbsp;<span>(多个关键字中间用空格隔开)</span>
        <hr>
        <a href="javascript:submitData()" class="easyui-linkbutton"
           data-options="iconCls:'icon-submit'">发布博客</a>
    </div>
</div>

</body>
</html>