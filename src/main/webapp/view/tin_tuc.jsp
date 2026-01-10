<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<section class="tin-tuc-layout">

    <section class="tin-tuc-container">
        <div class="tin-tuc-grid">

            <c:forEach items="${newsList}" var="n">
                <div class="tin-item">
                    <img src="${n.picture_url}" alt="${n.title}">

                    <div class="tin-content">
                        <h3>${n.title}</h3>

                        <div class="tin-meta">
                            <span>
                                <i class="fa-regular fa-calendar"></i>
                                ${n.created_at}
                            </span>
                        </div>

                        <p class="tin-desc">
                            <c:choose>
                                <c:when test="${fn:length(n.content) > 250}">
                                    ${fn:substring(n.content, 0, 250)}...
                                </c:when>
                                <c:otherwise>
                                    ${n.content}
                                </c:otherwise>
                            </c:choose>
                        </p>

                        <a href="chi-tiet-tin-tuc?id=${n.id}" class="tin-link">
                            Xem thêm <i class="fa-solid fa-arrow-right"></i>
                        </a>
                    </div>
                </div>
            </c:forEach>

        </div>
    </section>

    <!-- CỘT PHẢI -->
    <aside class="tin-moi">
        <h2>Bài viết mới nhất</h2>

        <c:forEach items="${newsList}" var="n" begin="0" end="2">
            <div class="tin-moi-item">
                <img src="${n.picture_url}" alt="${n.title}">
                <div>
                    <a href="chi-tiet-tin-tuc?id=${n.id}">
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

</section>
<div class="pagination">

    <c:if test="${currentPage > 1}">
        <a href="${ctx}/tin-tuc?page=${currentPage - 1}">
            &laquo;
        </a>
    </c:if>

    <c:forEach begin="1" end="${totalPages}" var="i">
        <a href="${ctx}/tin-tuc?page=${i}"
           class="page ${i == currentPage ? 'active' : ''}">
                ${i}
        </a>
    </c:forEach>

    <c:if test="${currentPage < totalPages}">
        <a href="${ctx}/tin-tuc?page=${currentPage + 1}">
            &raquo;
        </a>
    </c:if>

</div>


</div>
