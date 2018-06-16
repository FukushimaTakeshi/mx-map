import 'babel-polyfill'
import Vue from 'vue'

import Plan from '../../components/plans/Plan.vue'
import Carousel from '../../components/carousel/Carousel.vue'

import TurbolinksAdapter from 'vue-turbolinks'
Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  if (document.getElementById('form')) {
    new Vue({
      el: '#form',
      data: {
        poins: 0
      },
      components: {
        'plan': Plan,
        'carousel': Carousel
      }
    })
  }
})
