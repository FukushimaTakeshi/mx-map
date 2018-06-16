import Vue from 'vue'
import Carousel from '../../components/carousel/Carousel.vue'
import TurbolinksAdapter from 'vue-turbolinks'
Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  if (document.getElementById('form')) {
    new Vue({
      el: '#form',
      data: {
        dropImageUrls: []
      },
      components:{
        'carousel': Carousel
      }
    })
  }
})
