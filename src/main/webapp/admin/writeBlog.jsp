<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>写博客页面</title>

    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/icon.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/editor.md-master/css/editormd.min.css"/>

    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>

    <script type="text/javascript" src="${pageContext.request.contextPath}/static/editor.md-master/editormd.js"></script>

    <script type="text/javascript">

        var mdEditor;
        /**初始化marckdown*/
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


        /**发布博客*/
        function submitData() {
            var content = mdEditor.getMarkdown();       // 获取 Markdown 源码
            var contentHtml = mdEditor.getHTML();
            var contentNoTag = contentHtml.replace(/<[^>]*>|/g,"");
            var title = $("#title").val();
            var blogTypeId = $("#blogTypeId").combobox("getValue");
            var keyWord = $("#keyWord").val();

            if (title == null || title === '') {
                $.messager.alert("系统提示", "请输入标题！");
            } else if (blogTypeId == null || blogTypeId === '') {
                $.messager.alert("系统提示", "请输入博客类别！");
            } else if (content == null || content === '') {
                $.messager.alert("系统提示", "请输入内容！");
            } else {
                $.post("${pageContext.request.contextPath}/admin/blog/save.do",
                    {
                        'title': title, 'blogType.id': blogTypeId, 'content': content,
                        'contentNoTag': contentNoTag,
                        'summary': contentNoTag.substr(0, 155), 'keyWord': keyWord
                    },
                    function (result) {
                        if (result.success) {
                            $.messager.alert("系统提示", "博客修改成功！");
                        } else {
                            $.messager.alert("系统提示", "博客修改失败！");
                        }
                    }, "json");
            }
        }


        /**获取项目路径*/
        function getRootPath() {
            var curWwwPath = window.document.location.href;
            var pathName = window.document.location.pathname;
            var pos = curWwwPath.indexOf(pathName);
            var localhostPaht = curWwwPath.substring(0, pos);
            var projectName = pathName
                .substring(0, pathName.substr(1).indexOf('/') + 1);
            return (localhostPaht + projectName);
        }

    </script>
</head>
<body style="margin: 10px">
<div id="p" class="easyui-panel" title="编写博客" style="padding: 10px">

    <div>
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