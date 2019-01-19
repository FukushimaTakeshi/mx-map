//= require swiper/dist/js/swiper

window.addEventListener('DOMContentLoaded', function() {
  const mySwiper = new Swiper ('.swiper-container', {
    autoHeight: true,
    loop: true,
    slidesPerView: 2,
    spaceBetween: 10,
    centeredSlides : true,
    pagination: '.swiper-pagination',
    nextButton: '.swiper-button-next',
    prevButton: '.swiper-button-prev',
    breakpoints: {
      767: {
        slidesPerView: 1,
        spaceBetween: 0
      }
    }
  })

  document.querySelectorAll("#nav li").forEach(function(navEl) {
    navEl.onclick = function() { toggleTab(this.id, this.dataset.target); }
  });

  function toggleTab(selectedNav, targetId) {
    const navEls = document.querySelectorAll("#nav li");

    navEls.forEach(function(navEl) {
      if (navEl.id == selectedNav) {
        navEl.classList.add("is-active");
      } else {
        if (navEl.classList.contains("is-active")) {
          navEl.classList.remove("is-active");
        }
      }
    });

    const tabs = document.querySelectorAll(".tab-pane");

    tabs.forEach(function(tab) {
      if (tab.id == targetId) {
        tab.style.display = "block";
      } else {
        tab.style.display = "none";
      }
    });
  }
});
