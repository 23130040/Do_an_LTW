<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- ======================= CONTENT ======================= -->
<main class="container">

    <!-- ================= CHI TIẾT BÀI VIẾT ================= -->
    <article class="detail">

        <h1 class="detail-title">${news.title}</h1>

        <div class="date-view">
            <i class="fa fa-calendar"></i>
            <!-- LocalDate -> hiển thị trực tiếp -->
            ${news.created_at}
        </div>

        <div class="detail-content">
            ${news.content}
        </div>

        <p class="author">
            Tác giả:
            <strong>
                <c:choose>
                    <c:when test="${not empty news.author}">
                        ${news.author}
                    </c:when>
                    <c:otherwise>
                        ${news.created_by.name}
                    </c:otherwise>
                </c:choose>
            </strong>
        </p>

        <a href="<c:url value='/tin-tuc'/>" class="back-link">
            &larr; Quay lại tin tức
        </a>

    </article>

    <!-- ================= CỘT PHẢI: TIN MỚI ================= -->
    <aside class="tin-moi">
        <h2>Bài viết mới nhất</h2>

        <c:forEach items="${latestNews}" var="n">
            <div class="tin-moi-item">

                <img src="<c:url value='/images/${n.picture_url}'/>"
                     alt="${n.title}">

                <div>
                    <a href="<c:url value='/chi-tiet-tin-tuc?id=${n.id}'/>">
                            ${n.title}
                    </a>

                    <p>
                        <i class="fa-regular fa-calendar"></i>
                            ${n.created_at}
                    </p>
                </div>
            </div>
        </c:forEach>

    </aside>

</main>
