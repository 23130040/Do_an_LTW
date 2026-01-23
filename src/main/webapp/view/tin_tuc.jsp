<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div id="tin-tuc-page">

    <section class="tin-tuc-layout">

        <!-- ================= CỘT TRÁI ================= -->
        <section class="tin-tuc-container">
            <div class="tin-tuc-grid">

                <c:if test="${empty newsList}">
                    <p>Không có tin tức.</p>
                </c:if>

                <c:forEach items="${newsList}" var="n">
                    <div class="tin-item">

                        <!-- ẢNH TIN -->
                        <img class="tin-img"
                             src="${pageContext.request.contextPath}/${n.picture_url}"
                             alt="${n.title}">

                        <div class="tin-content">
                            <h3>${n.title}</h3>

                            <!-- NGÀY -->
                            <div class="tin-meta">
                                <i class="fa-regular fa-calendar"></i>
                                    ${n.created_at}
                            </div>

                            <!-- MÔ TẢ NGẮN -->
                            <p class="tin-desc">
                                <c:choose>
                                    <c:when test="${fn:length(n.content) > 200}">
                                        ${fn:substring(n.content, 0, 200)}...
                                    </c:when>
                                    <c:otherwise>
                                        ${n.content}
                                    </c:otherwise>
                                </c:choose>
                            </p>

                            <a class="tin-more"
                               href="${pageContext.request.contextPath}/chi-tiet-tin-tuc?id=${n.id}">
                                Xem thêm →
                            </a>
                        </div>
                    </div>
                </c:forEach>

            </div>
        </section>

        <!-- ================= CỘT PHẢI ================= -->
        <aside class="tin-moi">
            <h2>Bài viết mới nhất</h2>

            <c:forEach items="${latestNews}" var="n">
                <div class="tin-moi-item">
                    <img src="${pageContext.request.contextPath}/${n.picture_url}"
                         alt="${n.title}">
                    <div>
                        <a href="${pageContext.request.contextPath}/chi-tiet-tin-tuc?id=${n.id}">
                                ${n.title}
                        </a>
                        <p>${n.created_at}</p>
                    </div>
                </div>
            </c:forEach>
        </aside>

    </section>

    <!-- ================= PHÂN TRANG ================= -->
    <div class="pagination">

        <c:if test="${currentPage > 1}">
            <a href="?page=${currentPage - 1}">&laquo;</a>
        </c:if>

        <c:forEach begin="1" end="${totalPages}" var="i">
            <a href="?page=${i}"
               class="${i == currentPage ? 'active' : ''}">
                    ${i}
            </a>
        </c:forEach>

        <c:if test="${currentPage < totalPages}">
            <a href="?page=${currentPage + 1}">&raquo;</a>
        </c:if>

    </div>

</div>
