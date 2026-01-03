<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- ===== PHẦN TIN TỨC ===== -->
<section class="tin-tuc-layout">

    <!-- ===== CỘT TRÁI: DANH SÁCH TIN ===== -->
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
                            <c:out value="${n.content}" escapeXml="true"/>
                        </p>

                        <a href="chi-tiet-tin-tuc?id=${n.id}" class="tin-link">
                            Xem thêm <i class="fa-solid fa-arrow-right"></i>
                        </a>
                    </div>
                </div>
            </c:forEach>

        </div>

    </section>

    <!-- ===== CỘT PHẢI: TIN MỚI ===== -->
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

<!-- ===== PHÂN TRANG ===== -->
<div class="pagination">
    <a class="prev"><i class="fa-solid fa-chevron-left"></i></a>
    <a class="page active" data-page="1">1</a>
    <a class="page" data-page="2">2</a>
    <a class="next"><i class="fa-solid fa-chevron-right"></i></a>
</div>
