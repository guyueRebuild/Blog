<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<div class="data_list">
    <div class="data_list_title">
        <img src="${pageContext.request.contextPath}/static/images/about_icon.png"/>
        关于博主
    </div>
    <div style="padding:30px">
        <!--内容-->
        <div class="blog_content" id="blog-markdown-view">
            <textarea style="display:none;">${blogger.profile}</textarea>
        </div>
        <script type="text/javascript">
            $(function () {
                var testView = editormd.markdownToHTML("blog-markdown-view", {
                    htmlDecode: "style,script,iframe",  // you can filter tags decode
                    emoji: true,
                    taskList: true,
                    tex: true  // 默认不解析
                });
            });
        </script>
    </div>


</div>